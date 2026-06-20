#!/usr/bin/env python3
"""
JSON Automation Panel (step-by-step wizard)

Real build / upload / fetch against the Stac repo + configs API.

Run:
    python panel.py
"""
from __future__ import annotations

import datetime as _dt
import json
import os
import re
import shutil
import subprocess
import sys
import time
import urllib.error
import urllib.request
from pathlib import Path
from typing import Any

# ---------------------------------------------------------------- paths
HERE = Path(__file__).resolve().parent
REPO = HERE.parent  # tobank_sdui/
STAC_ROOT = REPO / "lib" / "stac"
FLOWS_DIR = STAC_ROOT / "tobank" / "flows"
READY_DIR = STAC_ROOT / "ready_for_build"
BUILD_OUT = STAC_ROOT / ".build" / "screens"
BUILT_DIR = HERE / "built_json"
FETCHED_DIR = HERE / "fetched"

# stac CLI executable (override via STAC_BIN env)
STAC_BIN = os.environ.get("STAC_BIN", "stac")

# navMode forced on fetched files' navigate actions. apiJson or localJson.
FETCH_NAV_MODE = "localJson"


# ---------------------------------------------------------------- color
class C:
    R = "\033[0m"
    DIM = "\033[2m"
    B = "\033[1m"
    CYAN = "\033[36m"
    GREEN = "\033[32m"
    YELLOW = "\033[33m"
    RED = "\033[31m"
    BLUE = "\033[34m"
    MAGENTA = "\033[35m"


def _supports_color() -> bool:
    if os.environ.get("NO_COLOR"):
        return False
    if sys.platform == "win32":
        try:
            import ctypes

            k = ctypes.windll.kernel32
            k.SetConsoleMode(k.GetStdHandle(-11), 7)
            return True
        except Exception:
            return False
    return sys.stdout.isatty()


COLOR = _supports_color()


def paint(s: str, color: str) -> str:
    return f"{color}{s}{C.R}" if COLOR else s


# ---------------------------------------------------------------- logging
def log(tag: str, msg: str) -> None:
    colors = {"INFO": C.CYAN, "OK": C.GREEN, "WARN": C.YELLOW, "ERR": C.RED, "DEBUG": C.DIM}
    label = paint(f"[{tag}]".ljust(7), colors.get(tag, C.R))
    print(f"  {label} {msg}")


def step(msg: str) -> None:
    log("INFO", msg)
    time.sleep(0.12)


# ---------------------------------------------------------------- state
class Config:
    def __init__(self) -> None:
        self.env = "dev"
        # single configs API base (swagger). used for fetch + upload.
        self.base_url = "http://192.168.179.21:8101/api/configurations"
        # namespace base for all mobile pages. pathKey = path_key.<flow>.<file>
        self.path_key = "ipaam.form.mobile"
        self.parent_id = "7b69a57d-05b9-459a-8cf6-1a87177402a9"
        self.build = 1
        self.verbose = False
        self.dimension = '{"app":["mobile"]}'
        self.stac_root = str(STAC_ROOT)
        # fetch params
        self.page_size = 200
        self.operator = "contains"
        self.timeout = 30
        self.last_version = False  # True -> /configs/all/last-version


CFG = Config()


# ---------------------------------------------------------------- ui core
def clear() -> None:
    os.system("cls" if sys.platform == "win32" else "clear")


def screen(crumb: str) -> None:
    """Clear + draw a clean header with breadcrumb."""
    clear()
    bar = paint("=" * 56, C.BLUE)
    print(bar)
    print(" " + paint("JSON Automation Panel", C.B + C.MAGENTA))
    print(" " + paint(crumb, C.DIM))
    print(bar)
    print()


def menu(crumb: str, title: str, options: list[tuple[str, str]], back: str = "back") -> str:
    """Show a single clean menu, return chosen key. '0' = back/quit."""
    while True:
        screen(crumb)
        if title:
            print(" " + paint(title, C.B))
            print()
        for key, label in options:
            print(f"   {paint(key, C.B + C.CYAN)})  {label}")
        print()
        print(f"   {paint('0', C.DIM)})  {paint(back, C.DIM)}")
        print()
        try:
            choice = input(paint(" > ", C.B + C.GREEN)).strip().lower()
        except (EOFError, KeyboardInterrupt):
            return "0"
        valid = {k for k, _ in options} | {"0"}
        if choice in valid:
            return choice
        log("WARN", f"invalid choice: {choice or '(empty)'}")
        pause()


def pause() -> None:
    try:
        input(paint("\n   [enter] continue ", C.DIM))
    except (EOFError, KeyboardInterrupt):
        pass


def ask_yes(label: str, default_yes: bool = True) -> bool:
    d = "Y/n" if default_yes else "y/N"
    try:
        v = input(f"   {label} [{d}]: ").strip().lower()
    except (EOFError, KeyboardInterrupt):
        return default_yes
    if not v:
        return default_yes
    return v in ("y", "yes")


def ask(label: str, default: str = "") -> str:
    suffix = paint(f" [{default}]", C.DIM) if default else ""
    try:
        v = input(f"   {label}{suffix}: ").strip()
    except (EOFError, KeyboardInterrupt):
        return default
    return v or default


def summary(rows: list[tuple[str, str, str]]) -> None:
    """rows = (item, status, path). path = full pathKey / file path."""
    print()
    print("  " + paint("SUMMARY", C.B))
    print(paint("  " + "-" * 74, C.DIM))
    print(f"  {'item':<22}{'status':<8}path")
    print(paint("  " + "-" * 74, C.DIM))
    for item, status, path in rows:
        sc = C.GREEN if status == "OK" else (C.RED if status == "ERR" else C.YELLOW)
        print(f"  {item:<22}{paint(status.ljust(7), sc)} {path}")


def list_flows() -> list[str]:
    if not FLOWS_DIR.exists():
        return []
    return sorted(p.name for p in FLOWS_DIR.iterdir() if p.is_dir())


# ---------------------------------------------------------------- fetch backend
class FetchError(Exception):
    pass


def http_json(url: str, *, method: str = "GET", body: dict | None = None,
              timeout: int = 30) -> Any:
    """POST/GET JSON via stdlib urllib. Raises FetchError on failure."""
    data = json.dumps(body, ensure_ascii=False).encode("utf-8") if body is not None else None
    headers = {"accept": "*/*"}
    if data is not None:
        headers["Content-Type"] = "application/json"
    req = urllib.request.Request(url, data=data, headers=headers, method=method)
    try:
        with urllib.request.urlopen(req, timeout=timeout) as resp:
            raw = resp.read().decode("utf-8")
    except urllib.error.HTTPError as e:
        raise FetchError(f"HTTP {e.code} {e.reason} @ {url}") from e
    except urllib.error.URLError as e:
        raise FetchError(f"connection failed @ {url}: {e.reason}") from e
    except Exception as e:  # timeout etc
        raise FetchError(f"request failed @ {url}: {e}") from e
    try:
        return json.loads(raw)
    except json.JSONDecodeError as e:
        snippet = raw[:200].replace("\n", " ")
        raise FetchError(f"expected JSON @ {url}, got: {snippet}") from e


def has_mobile_dim(rec: dict) -> bool:
    dim = rec.get("dimension")
    if not isinstance(dim, dict):
        return False
    app = dim.get("app")
    return app == "mobile" or (isinstance(app, list) and "mobile" in app)


# dimension.type discriminator
DIM_FOLDER = {"type": "folder"}                       # namespace nodes
DIM_CONFIG = {"app": "mobile", "type": "config"}      # assets/strings/colors
DIM_SCREEN = {"app": "mobile", "type": "screen"}      # page jsons


def record_type(rec: dict) -> str:
    dim = rec.get("dimension")
    t = dim.get("type", "") if isinstance(dim, dict) else ""
    if isinstance(t, list):
        t = t[0] if t else ""
    if t:
        return t
    # server omits dimension.type: infer from childrenCount.
    # leaf (no children) = real file; node with children = folder/namespace.
    cc = rec.get("childrenCount")
    if isinstance(cc, int):
        return "folder" if cc > 0 else "config"
    return ""


TEHRAN_OFFSET = _dt.timedelta(hours=3, minutes=30)


def fmt_ts(iso: str | None) -> str:
    """Server UTC ISO8601 -> Tehran (+3:30) 'YYYY-MM-DD HH:MM'. '-' if missing."""
    if not iso or not isinstance(iso, str):
        return "-"
    s = iso.strip()
    # parse UTC: strip zone, take 'YYYY-MM-DDTHH:MM:SS'
    core = s.replace("Z", "")[:19]
    try:
        dt = _dt.datetime.strptime(core, "%Y-%m-%dT%H:%M:%S")
        return (dt + TEHRAN_OFFSET).strftime("%Y-%m-%d %H:%M")
    except ValueError:
        return s.replace("T", " ")[:16]


def sanitize(name: str) -> str:
    return re.sub(r"[^A-Za-z0-9._-]+", "_", name).strip("._") or "config"


def _resolved_base() -> str:
    base = CFG.base_url.strip().rstrip("/")
    if not base:
        raise FetchError("base-url not set (System > base-url)")
    return base


def fetch_all_configs() -> list[dict]:
    """POST /configs/all (QueryRequest), paginate, return every config (flat)."""
    base = _resolved_base()
    endpoint = "all/last-version" if CFG.last_version else "all"
    items: list[dict] = []
    page, total_pages = 0, 1
    while page < total_pages:
        url = f"{base}/v1.0/configs/{endpoint}?page={page}&size={CFG.page_size}"
        if CFG.verbose:
            log("DEBUG", f"POST {url}")
        res = http_json(url, method="POST", body={"filters": [], "sorts": []},
                        timeout=CFG.timeout)
        data = res.get("data", {}) if isinstance(res, dict) else {}
        content = data.get("content", []) or []
        total_pages = int(data.get("pages", total_pages) or total_pages)
        items.extend(x for x in content if isinstance(x, dict))
        log("INFO", f"page {page + 1}/{total_pages}: +{len(content)} config(s)")
        page += 1
    return items


def _dedupe_latest(records: list[dict]) -> list[dict]:
    """Keep only highest-reversion record per pathKey (drop old versions/dups)."""
    best: dict[str, dict] = {}
    for r in records:
        pk = record_pathkey(r)
        cur = best.get(pk)
        if cur is None or int(r.get("reversion", 0) or 0) > int(cur.get("reversion", 0) or 0):
            best[pk] = r
    return list(best.values())


def fetch_records() -> list[dict]:
    """Configs under path_key namespace (flow nodes + screen files).
    Latest reversion only per pathKey."""
    base = CFG.path_key.strip(".") + "."
    matched = [x for x in fetch_all_configs() if record_pathkey(x).startswith(base)]
    return _dedupe_latest(matched)


def fetch_screens() -> list[dict]:
    """Screen page files under path_key (dimension.type == screen)."""
    return [x for x in fetch_records() if record_type(x) == "screen"]


def fetch_files() -> list[dict]:
    """All real files under path_key (config + screen), excluding folders."""
    return [x for x in fetch_records() if record_type(x) in ("screen", "config")]


def resolve_value(path_key: str, build: int) -> Any:
    """POST /configs/resolve/value/{path-key}/{build} -> resolved value (no wrapper)."""
    base = _resolved_base()
    try:
        dimension = json.loads(CFG.dimension)
    except json.JSONDecodeError as e:
        raise FetchError(f"bad dimension json: {e}") from e
    url = f"{base}/v1.0/configs/resolve/value/{path_key}/{build}"
    res = http_json(url, method="POST",
                    body={"operator": CFG.operator, "dimension": dimension},
                    timeout=CFG.timeout)
    return res.get("data") if isinstance(res, dict) else res


def write_fetched(records: list[dict]) -> int:
    FETCHED_DIR.mkdir(parents=True, exist_ok=True)
    index = []
    for i, rec in enumerate(records, 1):
        logical = (rec.get("pathKey") or rec.get("key") or rec.get("title")
                   or rec.get("id") or f"item_{i}")
        fname = f"{i:04d}_{sanitize(str(logical))}.json"
        (FETCHED_DIR / fname).write_text(
            json.dumps(rec, ensure_ascii=False, indent=2), encoding="utf-8")
        index.append({"file": fname, "id": rec.get("id"), "key": rec.get("key"),
                      "pathKey": rec.get("pathKey"), "title": rec.get("title"),
                      "dimension": rec.get("dimension")})
    (FETCHED_DIR / "_index.json").write_text(
        json.dumps(index, ensure_ascii=False, indent=2), encoding="utf-8")
    return len(records)


def fetched_files() -> list[Path]:
    if not FETCHED_DIR.exists():
        return []
    return sorted(p for p in FETCHED_DIR.glob("*.json") if p.name != "_index.json")


def shorten_fetched_names() -> tuple[int, int]:
    """Rename fetched files to last pathKey segment (colors.json etc).
    Reads pathKey from _index.json by current filename. Dedups collisions
    with _2, _3 suffix. Returns (renamed, total)."""
    files = fetched_files()
    idx_path = FETCHED_DIR / "_index.json"
    try:
        index = json.loads(idx_path.read_text(encoding="utf-8"))
    except (json.JSONDecodeError, FileNotFoundError):
        index = []
    pk_by_file = {e.get("file"): (e.get("pathKey") or "") for e in index
                  if isinstance(e, dict)}
    used: set[str] = set()
    renamed = 0
    for p in files:
        pk = pk_by_file.get(p.name, "")
        leaf = pk.rsplit(".", 1)[-1] if pk else p.stem
        base = sanitize(leaf) or "config"
        target = f"{base}.json"
        n = 2
        while target in used or (target != p.name and (FETCHED_DIR / target).exists()):
            target = f"{base}_{n}.json"
            n += 1
        used.add(target)
        if target != p.name:
            p.rename(FETCHED_DIR / target)
            renamed += 1
    return renamed, len(files)


def normalize_fetched() -> tuple[int, int]:
    """value-only strip, in place. Returns (changed, total)."""
    files = fetched_files()
    changed = 0
    for p in files:
        try:
            data = json.loads(p.read_text(encoding="utf-8"))
        except json.JSONDecodeError:
            log("WARN", f"skip invalid json: {p.name}")
            continue
        new = data["value"] if isinstance(data, dict) and "value" in data else data
        new_txt = json.dumps(new, ensure_ascii=False, indent=2) + "\n"
        if new_txt != p.read_text(encoding="utf-8"):
            p.write_text(new_txt, encoding="utf-8")
            changed += 1
    return changed, len(files)


def _walk_navfix(node: Any, nav_mode: str, counter: list[int]) -> None:
    if isinstance(node, dict):
        if node.get("actionType") == "navigate" and "fileName" in node:
            node["navMode"] = nav_mode
            counter[0] += 1
        for v in node.values():
            _walk_navfix(v, nav_mode, counter)
    elif isinstance(node, list):
        for v in node:
            _walk_navfix(v, nav_mode, counter)


def navfix_fetched(nav_mode: str) -> tuple[int, int]:
    """Force navMode on navigate-with-fileName actions. Returns (fixed, files)."""
    files = fetched_files()
    fixed_total = 0
    for p in files:
        try:
            data = json.loads(p.read_text(encoding="utf-8"))
        except json.JSONDecodeError:
            log("WARN", f"skip invalid json: {p.name}")
            continue
        c = [0]
        _walk_navfix(data, nav_mode, c)
        if c[0]:
            p.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n",
                         encoding="utf-8")
            fixed_total += c[0]
    return fixed_total, len(files)


def config_panel() -> None:
    """Show all needed data: connection + paths + options."""
    def row(k: str, v: str) -> None:
        print(f"   {paint(k.ljust(12), C.DIM)} {v}")

    print(" " + paint("Current configuration", C.B))
    print()
    print("  " + paint("connection", C.YELLOW))
    row("env", paint(CFG.env, C.GREEN))
    row("base-url", CFG.base_url)
    row("path_key", paint(CFG.path_key, C.GREEN))
    row("parentId", CFG.parent_id)
    row("build", str(CFG.build))
    row("dimension", CFG.dimension)
    print()
    print("  " + paint("paths", C.YELLOW))
    row("stac root", CFG.stac_root)
    row("flows", str(FLOWS_DIR))
    row("built out", str(BUILT_DIR))
    row("fetched", str(FETCHED_DIR))
    print()
    print("  " + paint("options", C.YELLOW))
    row("verbose", "on" if CFG.verbose else "off")
    row("flows found", str(len(list_flows())))
    print()
    print(paint("   edit via  4) System", C.DIM))
    print()


# ---------------------------------------------------------------- BUILD
def build_pick_flows(crumb: str) -> list[str]:
    flows = list_flows()
    if not flows:
        screen(crumb)
        log("WARN", f"no flows in {FLOWS_DIR}")
        pause()
        return []
    while True:
        screen(crumb)
        print(" " + paint("Pick flow(s) to build", C.B))
        print()
        for i, name in enumerate(flows, 1):
            print(f"   {i:>2})  {name}")
        print(f"   {paint(' a', C.B + C.CYAN)})  all flows")
        print(f"   {paint(' 0', C.DIM)})  {paint('back', C.DIM)}")
        print()
        print(paint("   multi-select ok, e.g.  1 3 16", C.DIM))
        raw = input(paint("\n > ", C.B + C.GREEN)).strip().lower()
        if raw in {"0", ""}:
            return []
        if raw == "a":
            return flows
        picks, bad = [], []
        for tok in raw.split():
            if tok.isdigit() and 1 <= int(tok) <= len(flows):
                picks.append(flows[int(tok) - 1])
            else:
                bad.append(tok)
        if bad:
            log("WARN", f"ignored: {' '.join(bad)}")
            pause()
        if picks:
            return picks


def _wipe_dir(d: Path) -> None:
    """Remove all contents of d (keep dir)."""
    if not d.exists():
        d.mkdir(parents=True, exist_ok=True)
        return
    for p in d.iterdir():
        if p.is_dir():
            shutil.rmtree(p)
        else:
            p.unlink()


def run_stac_build() -> tuple[bool, str]:
    """Invoke `stac build` at REPO root (stac.yaml + default_stac_options.dart
    live there; source=lib/stac/ready_for_build). Returns (ok, output)."""
    cmd = [STAC_BIN, "build", "-p", str(REPO)]
    try:
        proc = subprocess.run(
            cmd, cwd=str(REPO), capture_output=True, text=True,
            timeout=CFG.timeout * 6, shell=(os.name == "nt"))
    except FileNotFoundError:
        return False, f"stac binary not found: {STAC_BIN} (set STAC_BIN env)"
    except subprocess.TimeoutExpired:
        return False, "stac build timed out"
    out = (proc.stdout or "") + (proc.stderr or "")
    return proc.returncode == 0, out.strip()


def run_build(crumb: str, nav_mode: str, flows: list[str]) -> None:
    screen(crumb)
    if not flows:
        log("WARN", "no flows selected, abort")
        pause()
        return
    log("INFO", f"build type: navMode -> {paint(nav_mode, C.B)}")
    log("INFO", f"flows: {', '.join(flows)}")
    print()
    rows = []
    for flow in flows:
        print()
        log("INFO", paint(flow, C.B))
        flow_dir = FLOWS_DIR / flow
        # recursive: dart files at any depth (dart/, menu/, nested subdirs)
        darts = sorted(flow_dir.rglob("*.dart")) if flow_dir.exists() else []
        if not darts:
            log("WARN", f"no dart files in {flow_dir}")
            rows.append((flow, "WARN", "no dart files"))
            continue

        # 1. wipe ready_for_build + previous build output
        _wipe_dir(READY_DIR)
        _wipe_dir(BUILD_OUT)
        # 2. copy this flow's dart files in, preserving relative structure
        #    (keeps relative imports working)
        for d in darts:
            rel = d.relative_to(flow_dir)
            target = READY_DIR / rel
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(d, target)
        log("INFO", f"copied {len(darts)} dart file(s) -> ready_for_build/")
        # 3. run stac build
        log("INFO", "run `stac build`")
        ok, out = run_stac_build()
        if CFG.verbose and out:
            for line in out.splitlines():
                log("DEBUG", line)
        if not ok:
            log("ERR", f"stac build failed for {flow}")
            if not CFG.verbose and out:
                for line in out.splitlines()[-8:]:
                    log("ERR", line)
            rows.append((flow, "ERR", "stac build failed"))
            continue
        # 4. read output
        built = sorted(BUILD_OUT.glob("*.json"))
        if not built:
            log("WARN", "stac build produced no json")
            rows.append((flow, "WARN", "no output json"))
            continue
        # 5. navMode correction + 6. move -> built_json/<flow>/
        dest = BUILT_DIR / flow
        _wipe_dir(dest)
        for jf in built:
            try:
                data = json.loads(jf.read_text(encoding="utf-8"))
            except json.JSONDecodeError:
                log("WARN", f"skip invalid json: {jf.name}")
                continue
            _walk_navfix(data, nav_mode, [0])
            (dest / jf.name).write_text(
                json.dumps(data, ensure_ascii=False, indent=2) + "\n",
                encoding="utf-8")
        log("OK", f"navMode -> {nav_mode}, moved {len(built)} screen(s)")
        log("OK", f"{flow} built ({len(built)} screens)")
        rows.append((flow, "OK", f"built_json/{flow}/ ({len(built)} screens)"))
    summary(rows)
    pause()


def section_build() -> None:
    crumb = "Home > Build"
    while True:
        choice = menu(
            crumb,
            "Select build type",
            [("1", "api json build   " + paint("(navMode: apiJson)", C.DIM)),
             ("2", "local json build " + paint("(navMode: localJson)", C.DIM))],
            back="back to home",
        )
        if choice == "0":
            return
        nav = "apiJson" if choice == "1" else "localJson"
        sub = f"{crumb} > {'api' if choice == '1' else 'local'}"
        flows = build_pick_flows(sub)
        if flows:
            run_build(sub, nav, flows)


# ---------------------------------------------------------------- UPLOAD
# ---------------------------------------------------------------- upload backend
ASSET_FILES = {
    "assets.json": STAC_ROOT / "config" / "assets.json",
    "strings.json": STAC_ROOT / "config" / "strings.json",
    "colors.json": STAC_ROOT / "design_system" / "colors.json",
}

# sub-namespace node for config files (assets/strings/colors) under path_key
CONFIG_SEGMENT = "config"


def add_config(key: str, title: str, parent_id: str, value: Any,
               dimension: dict | None = None) -> tuple[bool, str, str | None]:
    """POST /configs/add. Returns (ok, msg, created_id)."""
    url = _resolved_base() + "/v1.0/configs/add"
    payload = {
        "key": key,
        "build": CFG.build,
        "parentId": parent_id,
        "title": title,
        "dimension": {"app": "mobile"} if dimension is None else dimension,
        "value": value,
        "schema": {},
    }
    try:
        res = http_json(url, method="POST", body=payload, timeout=CFG.timeout)
        data = res.get("data", {}) if isinstance(res, dict) else {}
        st = res.get("status", {}) if isinstance(res, dict) else {}
        code = st.get("code", "?") if isinstance(st, dict) else "?"
        desc = st.get("description", "") if isinstance(st, dict) else ""
        msgs = st.get("message") if isinstance(st, dict) else None
        msg_txt = " ".join(msgs) if isinstance(msgs, list) else (str(msgs) if msgs else "")
        out = f"{code} {rtl(msg_txt)} ({desc})".strip()
        return True, out, (data.get("id") if isinstance(data, dict) else None)
    except FetchError as e:
        return False, str(e), None


def rtl(s: str) -> str:
    """Wrap text in RTL embedding so Persian renders correctly in terminal."""
    if not s:
        return s
    return "‫" + s + "‬"


def file_url(path_key: str, build: int | None = None) -> str:
    """Full URL to resolve a config's value by pathKey."""
    b = CFG.base_url.rstrip("/")
    return f"{b}/v1.0/configs/resolve/value/{path_key}/{CFG.build if build is None else build}"


def find_node(path_key: str) -> dict | None:
    """Locate a config node by exact pathKey via /all."""
    for c in fetch_all_configs():
        if record_pathkey(c) == path_key:
            return c
    return None


def ensure_node(path_key: str) -> str:
    """Return id of node at path_key; create namespace node (+parents) if missing."""
    node = find_node(path_key)
    if node and node.get("id"):
        return node["id"]
    parent_path, _, key = path_key.rpartition(".")
    if not parent_path:
        raise FetchError(f"cannot create root node '{path_key}'")
    parent_id = ensure_node(parent_path)
    log("INFO", f"create folder node {path_key}")
    ok, msg, new_id = add_config(key, key, parent_id, value={}, dimension=DIM_FOLDER)
    if not ok or not new_id:
        raise FetchError(f"failed to create {path_key}: {msg}")
    log("OK", f"created {path_key} -> id {new_id}")
    return new_id


def post_config(key: str, title: str, value: Any, parent_id: str) -> tuple[bool, str]:
    ok, msg, _ = add_config(key, title, parent_id, value)
    return ok, msg


def read_json_file(path: Path) -> Any:
    txt = path.read_text(encoding="utf-8").replace("﻿", "")
    return json.loads(txt)


def pick_list(crumb: str, title: str, items: list[str], allow_all: bool = True) -> list[str]:
    """Generic multi-select picker. Returns chosen items, [] on back."""
    if not items:
        screen(crumb)
        log("WARN", "nothing to select here")
        pause()
        return []
    while True:
        screen(crumb)
        print(" " + paint(title, C.B))
        print()
        for i, name in enumerate(items, 1):
            print(f"   {i:>2})  {name}")
        if allow_all:
            print(f"   {paint(' a', C.B + C.CYAN)})  all")
        print(f"   {paint(' 0', C.DIM)})  {paint('back', C.DIM)}")
        print()
        print(paint("   multi-select ok, e.g.  1 3", C.DIM))
        raw = input(paint("\n > ", C.B + C.GREEN)).strip().lower()
        if raw in {"0", ""}:
            return []
        if allow_all and raw == "a":
            return list(items)
        picks, bad = [], []
        for tok in raw.split():
            if tok.isdigit() and 1 <= int(tok) <= len(items):
                picks.append(items[int(tok) - 1])
            else:
                bad.append(tok)
        if bad:
            log("WARN", f"ignored: {' '.join(bad)}")
            pause()
        if picks:
            return picks


def confirm_upload(crumb: str, kind: str, items: list[str]) -> bool:
    """Show everything before sending. Return True to continue."""
    screen(crumb + " > confirm")
    print(" " + paint("Confirm upload", C.B))
    print()
    if kind == "config":
        ns = CFG.path_key.strip(".") + "." + CONFIG_SEGMENT
    else:
        ns = CFG.path_key.strip(".") + ".<flow>"
    print("  " + paint("kind", C.DIM) + f"      {kind}")
    print("  " + paint("target", C.DIM) + f"    {CFG.base_url}/v1.0/configs/add")
    print("  " + paint("namespace", C.DIM) + f" {ns}.<key>  (parent auto-resolved/created)")
    print("  " + paint("build", C.DIM) + f"     {CFG.build}")
    print()
    print("  " + paint(f"files ({len(items)})", C.YELLOW))
    for it in items:
        print(f"    - {it}")
    print()
    print(paint("   review above.", C.DIM))
    print(f"   {paint('1', C.B + C.CYAN)})  continue + upload")
    print(f"   {paint('0', C.DIM)})  back (cancel)")
    print()
    ans = input(paint("\n > ", C.B + C.GREEN)).strip().lower()
    return ans == "1"


def do_upload(crumb: str, kind: str, items: list[str]) -> None:
    screen(crumb + " > result")
    log("INFO", f"upload {kind} -> {_resolved_base()}/v1.0/configs/add")
    print()
    rows = []
    # resolve target parent node (create if missing)
    try:
        if kind == "config":
            config_path = CFG.path_key.strip(".") + "." + CONFIG_SEGMENT
            parent_id = ensure_node(config_path)
            log("INFO", f"parent {config_path} -> id {parent_id}")
        else:  # flow jsons -> parent = path_key.<flow>
            parent_id = None  # resolved per-file below (flow varies)
    except FetchError as e:
        log("ERR", str(e))
        summary([(kind, "ERR", "resolve parent failed")])
        pause()
        return
    print()
    base = CFG.path_key.strip(".")
    uploaded_pks = []  # successful pathKeys, for verify pass
    uploaded_vals: dict[str, Any] = {}  # pk -> value sent, for content verify
    for it in items:
        if kind == "config":
            path = ASSET_FILES[it]
            key = title = Path(it).stem  # assets / strings / colors
            pid = parent_id
            full_pk = f"{base}.{CONFIG_SEGMENT}.{key}"
        else:  # flow jsons: it = "<flow>/<file>.json"
            path = BUILT_DIR / it
            key = title = Path(it).stem
            flow = it.split("/", 1)[0]
            full_pk = f"{base}.{flow}.{key}"
            try:
                pid = ensure_node(f"{base}.{flow}")
            except FetchError as e:
                log("ERR", f"{it}: parent resolve failed ({e})")
                rows.append((key, "ERR", file_url(full_pk)))
                continue
        if not path.exists():
            log("ERR", f"{it}: file not found {path}")
            rows.append((key, "ERR", str(path)))
            continue
        try:
            value = read_json_file(path)
        except json.JSONDecodeError as e:
            log("ERR", f"{it}: invalid json ({e})")
            rows.append((key, "ERR", file_url(full_pk)))
            continue
        mtime = _dt.datetime.fromtimestamp(path.stat().st_mtime).strftime("%Y-%m-%d %H:%M:%S")
        leaf_dim = DIM_CONFIG if kind == "config" else DIM_SCREEN
        step(f"POST {key} (parentId={pid[:8]}..., build={CFG.build}, dim={leaf_dim}, file mtime={mtime})")
        ok, msg, _ = add_config(key, title, pid, value, dimension=leaf_dim)
        if ok:
            log("OK", f"{key} -> {msg}")
            rows.append((key, "OK", file_url(full_pk)))
            uploaded_pks.append(full_pk)
            uploaded_vals[full_pk] = value
        else:
            log("ERR", f"{key} -> {msg}")
            rows.append((key, "ERR", file_url(full_pk)))
    summary(rows)
    pause()
    if uploaded_pks:
        verify_uploads(crumb, uploaded_pks, uploaded_vals)


def _canon(obj: Any) -> str:
    """Canonical JSON (sorted keys, no whitespace) for content equality."""
    return json.dumps(obj, sort_keys=True, ensure_ascii=False, separators=(",", ":"))


def resolve_server_value(pk: str) -> Any:
    """Fetch the live value the APP would get: POST resolve with CFG operator+dimension.
    Returns content[0]['value'] or None. Raises FetchError on transport error."""
    url = f"{_resolved_base()}/v1.0/configs/resolve/{pk}/{CFG.build}"
    try:
        dim = json.loads(CFG.dimension)
    except json.JSONDecodeError:
        dim = {"app": "mobile"}
    res = http_json(url, method="POST",
                    body={"operator": CFG.operator, "dimension": dim},
                    timeout=CFG.timeout)
    data = res.get("data", {}) if isinstance(res, dict) else {}
    content = data.get("content") if isinstance(data, dict) else None
    if content:
        return content[0].get("value")
    return None


def verify_uploads(crumb: str, path_keys: list[str],
                   uploaded_vals: dict[str, Any] | None = None) -> None:
    """Re-fetch each uploaded config the SAME way the app does and compare the
    live server value against the exact value we just uploaded. Content mismatch
    => loud MISMATCH (catches stale files, failed writes, wrong lineage)."""
    screen(crumb + " > verify")
    log("INFO", f"verify {len(path_keys)} uploaded file(s) via resolve + content compare")
    print()
    uploaded_vals = uploaded_vals or {}
    rows = []
    print("  " + paint("VERIFY", C.B))
    print(paint("  " + "-" * 78, C.DIM))
    print(f"  {'file':<20}{'match':<8}{'rev':<5}{'updatedOn':<22}url")
    print(paint("  " + "-" * 78, C.DIM))
    # metadata (rev/updatedOn) via /all
    try:
        by = {record_pathkey(c): c for c in fetch_all_configs()}
    except FetchError as e:
        log("ERR", str(e)); pause(); return
    all_ok = True
    for pk in path_keys:
        leaf = pk.rsplit(".", 1)[-1]
        c = by.get(pk)
        rev = str(c.get("reversion", "?")) if c else "?"
        updated = str(c.get("updatedOn", "-"))[:19] if c else "-"
        # content compare
        match = "?"
        if pk in uploaded_vals:
            try:
                live = resolve_server_value(pk)
            except FetchError as e:
                live = None
                log("ERR", f"{leaf}: resolve failed ({e})")
            if live is None:
                match = paint("MISSING", C.RED); all_ok = False
            elif _canon(live) == _canon(uploaded_vals[pk]):
                match = paint("OK", C.GREEN)
            else:
                match = paint("MISMATCH", C.RED); all_ok = False
        mcol = match + " " * max(0, 8 - _vislen(match))
        print(f"  {leaf:<20}{mcol}{rev:<5}{updated:<22}{paint(file_url(pk), C.DIM)}")
        status = "OK" if "OK" in match else ("MISS" if "MISSING" in match else
                 ("MISMATCH" if "MISMATCH" in match else "OK"))
        rows.append((leaf, status, file_url(pk)))
    print(paint("  " + "-" * 78, C.DIM))
    if all_ok:
        log("OK", "all uploaded values match live server content")
    else:
        log("ERR", "CONTENT MISMATCH: server value != uploaded file. "
                   "Save the file then re-upload; check duplicates/lineage.")
    summary(rows)
    pause()


def _vislen(s: str) -> int:
    """Visible length ignoring ANSI color codes."""
    return len(re.sub(r"\x1b\[[0-9;]*m", "", s))


def built_files() -> list[str]:
    """Built jsons available to upload = built_json/<flow>/*.json (relative)."""
    if not BUILT_DIR.exists():
        return []
    return sorted(
        str(p.relative_to(BUILT_DIR)).replace("\\", "/")
        for p in BUILT_DIR.rglob("*.json")
    )


def section_upload() -> None:
    crumb = "Home > Upload"
    while True:
        choice = menu(
            crumb,
            "What to upload",
            [("1", "flow jsons     " + paint("(built_json/<flow>/*)", C.DIM)),
             ("2", "config         " + paint("(assets/strings/colors)", C.DIM))],
            back="back to home",
        )
        if choice == "0":
            return
        if choice == "1":
            files = built_files()
            if not files:
                screen(crumb + " > flow jsons")
                log("WARN", f"no built jsons in {BUILT_DIR} (run Build first)")
                pause()
                continue
            sel = pick_list(crumb + " > flow jsons", "Pick built json(s)", files)
            if sel and confirm_upload(crumb + " > flow jsons", "flow jsons", sel):
                do_upload(crumb + " > flow jsons", "flow jsons", sel)
        elif choice == "2":
            files = pick_list(
                crumb + " > config", "Pick config file(s)",
                ["assets.json", "strings.json", "colors.json"],
            )
            if files and confirm_upload(crumb + " > config", "config", files):
                do_upload(crumb + " > config", "config", files)


# ---------------------------------------------------------------- FETCH
def _clear_fetched() -> None:
    if FETCHED_DIR.exists():
        for p in FETCHED_DIR.glob("*.json"):
            p.unlink()


def record_pathkey(rec: dict) -> str:
    return str(rec.get("pathKey") or rec.get("key") or rec.get("id") or "")


def feature_prefixes(records: list[dict]) -> list[str]:
    """Flow/folder names = first segment after path_key. e.g. profile, config."""
    base = CFG.path_key.strip(".") + "."
    flows = set()
    for r in records:
        pk = record_pathkey(r)
        if pk.startswith(base):
            flows.add(pk[len(base):].split(".", 1)[0])
    return sorted(f for f in flows if f)


def persist_fetched(records: list[dict], label: str, rows: list) -> None:
    """Write subset + auto-normalize. Clears fetched/ first. Per-file rows."""
    _clear_fetched()
    n = write_fetched(records)
    log("OK", f"fetched {n} config(s) -> fetched/ + _index.json")
    if n:
        changed, total = normalize_fetched()
        log("OK", f"normalized {changed}/{total} (value-only)")
        if ask_yes("shorten file names to last segment (colors.json)?", True):
            renamed, tot = shorten_fetched_names()
            log("OK", f"renamed {renamed}/{tot} file(s) -> short names")
    for i, rec in enumerate(records, 1):
        pk = record_pathkey(rec)
        leaf = pk.rsplit(".", 1)[-1] if pk else f"item_{i}"
        rows.append((leaf, "OK", pk or "(no pathKey)"))
    if not records:
        rows.append((label, "WARN", "0 matched"))


def run_fetch_all(crumb: str) -> None:
    screen(crumb)
    log("INFO", "fetch READ-ONLY. repo untouched. output -> fetched/")
    rows = []
    try:
        log("INFO", f"download from {CFG.base_url}")
        records = fetch_files()
    except FetchError as e:
        log("ERR", str(e))
        summary([("fetch all", "ERR", "download failed")])
        pause()
        return
    persist_fetched(records, "fetch all", rows)
    summary(rows)
    pause()


def run_fetch_features(crumb: str) -> None:
    screen(crumb)
    log("INFO", "load config list to derive features (pathKey prefixes)")
    try:
        records = fetch_records()
    except FetchError as e:
        log("ERR", str(e)); pause(); return
    if not records:
        log("WARN", "no configs returned"); pause(); return
    flows = feature_prefixes(records)
    picks = pick_list(crumb + " > features", "Pick flow(s) under " + CFG.path_key, flows)
    if not picks:
        return
    base = CFG.path_key.strip(".") + "."
    sel = [r for r in records
           if any(record_pathkey(r).startswith(base + f + ".") for f in picks)
           and record_type(r) != "folder"]
    screen(crumb + " > features")
    log("INFO", f"matched {len(sel)} config(s) for {len(picks)} feature(s)")
    rows = []
    persist_fetched(sel, "fetch features", rows)
    summary(rows)
    pause()


def _filter_by_tokens(records: list[dict], tokens: list[str]) -> list[dict]:
    return [r for r in records
            if any(t.lower() in record_pathkey(r).lower() for t in tokens)]


def run_fetch_by_name(crumb: str) -> None:
    screen(crumb)
    log("INFO", "load file list, then type name(s) to fetch")
    try:
        records = fetch_files()
    except FetchError as e:
        log("ERR", str(e)); pause(); return
    if not records:
        log("WARN", "no files found"); pause(); return
    keys = sorted(record_pathkey(r) for r in records)
    screen(crumb + " > by name")
    print(" " + paint(f"Available files ({len(keys)})", C.B))
    print()
    for k in keys:
        print(f"   {k}")
    print()
    print(paint("   type name substring(s), space-separated (multi). blank = cancel", C.DIM))
    raw = input(paint("\n > ", C.B + C.GREEN)).strip()
    if not raw:
        return
    sel = _filter_by_tokens(records, raw.split())
    screen(crumb + " > by name")
    if not sel:
        log("WARN", f"no pathKey matched: {raw}"); pause(); return
    log("INFO", f"matched {len(sel)} file(s)")
    rows = []
    persist_fetched(sel, "fetch by name", rows)
    summary(rows)
    pause()


def pathkey_from_url(url: str) -> str | None:
    """Extract pathKey from resolve/tree/get URLs."""
    m = re.search(r"/configs/(?:resolve/value|resolve|tree/value|tree)/([^/?]+)", url)
    if m:
        return m.group(1)
    m = re.search(r"/configs/get/([^/?]+)", url)
    return m.group(1) if m else None


def infer_request(url: str) -> tuple[str, dict | None]:
    """Method + body auto-derived from endpoint (per swagger). No user input."""
    if "/configs/all" in url:
        return "POST", {"filters": [], "sorts": []}
    if "/configs/resolve" in url or "/configs/tree" in url:
        try:
            dim = json.loads(CFG.dimension)
        except json.JSONDecodeError:
            dim = {}
        return "POST", {"operator": CFG.operator, "dimension": dim}
    # get/{id}, message/resolve, anything else
    return "GET", None


def url_suggestions() -> list[tuple[str, str]]:
    """Suggested (label, url) for this flow, derived from live server + swagger."""
    sug: list[tuple[str, str]] = []
    base = _resolved_base()
    # static useful endpoints
    sug.append(("list all configs", f"{base}/v1.0/configs/all?page=0&size={CFG.page_size}"))
    sug.append((f"subtree of {CFG.path_key}",
                f"{base}/v1.0/configs/tree/{CFG.path_key}/{CFG.build}/0/100"))
    # live: resolve url per known file under path_key
    try:
        for c in fetch_files():
            pk = record_pathkey(c)
            sug.append((pk, file_url(pk)))
    except FetchError as e:
        log("WARN", f"could not load live suggestions: {e}")
    return sug


def run_fetch_by_url(crumb: str) -> None:
    screen(crumb)
    print(" " + paint("Fetch by URL", C.B) + paint("  (pick suggestion or paste full url)", C.DIM))
    print()
    sug = url_suggestions()
    if sug:
        print(" " + paint("Suggestions (this flow):", C.B))
        for i, (label, u) in enumerate(sug, 1):
            print(f"   {i:>2}) {label}")
            print(paint(f"       {u}", C.DIM))
        print()
        print(paint("   type a number to pick, or paste full url. blank = cancel", C.DIM))
    url = input(paint("\n url/# > ", C.B + C.GREEN)).strip()
    if not url:
        return
    if url.isdigit() and 1 <= int(url) <= len(sug):
        url = sug[int(url) - 1][1]
    method, body = infer_request(url)
    screen(crumb + " > by url")
    log("INFO", f"{method} {url}  " + paint("(method auto-detected)", C.DIM))
    if body is not None and CFG.verbose:
        log("DEBUG", f"body = {body}")
    try:
        data = http_json(url, method=method, body=body, timeout=CFG.timeout)
    except FetchError as e:
        log("ERR", str(e))
        summary([("fetch by url", "ERR", url)]); pause(); return
    FETCHED_DIR.mkdir(parents=True, exist_ok=True)
    fname = sanitize(url.split("//", 1)[-1]) + ".json"
    saved = FETCHED_DIR / fname
    saved.write_text(json.dumps(data, ensure_ascii=False, indent=2), encoding="utf-8")
    log("OK", f"saved raw response -> fetched/{fname}")
    print()
    # 1) normalize just this file
    if ask_yes("normalize value-only this file?"):
        d = json.loads(saved.read_text(encoding="utf-8"))
        if isinstance(d, dict) and "data" in d:
            d = d["data"]
        if isinstance(d, dict) and "value" in d:
            d = d["value"]
        saved.write_text(json.dumps(d, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
        log("OK", "normalized (value-only)")
    # 2) rename to project-style short name (pathKey leaf)
    pk = pathkey_from_url(url)
    if pk:
        short = pk.rsplit(".", 1)[-1] + ".json"
        if short != fname and ask_yes(f"rename to project-style name '{short}'?"):
            target = FETCHED_DIR / short
            saved.rename(target)
            saved = target
            log("OK", f"renamed -> {short}")
    screen(crumb + " > by url")
    summary([(saved.name, "OK", str(saved))])
    pause()


def run_navfix(crumb: str) -> None:
    screen(crumb)
    if not fetched_files():
        log("WARN", "no fetched files to nav-fix (fetch first)"); pause(); return
    fixed, total = navfix_fetched(FETCH_NAV_MODE)
    log("OK", f"nav fixed {fixed} action(s) across {total} file(s) -> {FETCH_NAV_MODE}")
    summary([("nav fix", "OK", f"{fixed} actions / {total} files -> {FETCH_NAV_MODE}")])
    pause()


def _type_color(t: str) -> str:
    return {"folder": C.BLUE, "config": C.YELLOW, "screen": C.GREEN}.get(t, C.DIM)


def run_map(crumb: str) -> None:
    """Build full tree map from path_key. Read-only. Saves map.txt + map.json."""
    screen(crumb)
    base = CFG.path_key.strip(".")
    log("INFO", f"build map from {base} (read-only)")
    try:
        cfgs = fetch_all_configs()
    except FetchError as e:
        log("ERR", str(e)); pause(); return
    nodes = [c for c in cfgs
             if record_pathkey(c) == base or record_pathkey(c).startswith(base + ".")]
    if not nodes:
        log("WARN", f"nothing under {base}"); pause(); return
    # dedup by pathKey (keep highest reversion), count duplicates
    bypk: dict[str, dict] = {}
    dup: dict[str, int] = {}
    for c in nodes:
        pk = record_pathkey(c)
        dup[pk] = dup.get(pk, 0) + 1
        prev = bypk.get(pk)
        if prev is None or (c.get("reversion") or 0) >= (prev.get("reversion") or 0):
            bypk[pk] = c
    pks = sorted(bypk)
    base_depth = base.count(".")
    counts = {"folder": 0, "config": 0, "screen": 0, "?": 0}
    txt_lines, json_rows = [], []
    NAME_W, TYPE_W, REV_W, DUP_W, UPD_W = 34, 8, 4, 4, 18
    print()
    print("  " + paint(f"MAP  {base}", C.B))
    print(paint("  " + "-" * 118, C.DIM))
    hdr = f"  {'name':<{NAME_W}}{'type':<{TYPE_W}}{'rev':<{REV_W}}{'dup':<{DUP_W}}{'updated':<{UPD_W}}url"
    print(paint(hdr, C.B))
    print(paint("  " + "-" * 118, C.DIM))
    for pk in pks:
        c = bypk[pk]
        t = record_type(c) or "?"
        counts[t] = counts.get(t, 0) + 1
        depth = pk.count(".") - base_depth
        seg = pk.split(".")[-1] if depth > 0 else pk
        name = ("  " * depth) + seg
        rev = str(c.get("reversion", "?"))
        dn = str(dup[pk])
        upd = fmt_ts(c.get("updatedOn") or c.get("createdOn"))
        url = file_url(pk)
        txt_lines.append(f"{name:<{NAME_W}}{('[' + t + ']'):<{TYPE_W}}{rev:<{REV_W}}{dn:<{DUP_W}}{upd:<{UPD_W}}{url}")
        dupc = paint(dn.ljust(DUP_W), C.RED) if dup[pk] > 1 else dn.ljust(DUP_W)
        print(f"  {name:<{NAME_W}}{paint(t.ljust(TYPE_W), _type_color(t))}"
              f"{rev:<{REV_W}}{dupc}{paint(upd.ljust(UPD_W), C.CYAN)}{paint(url, C.DIM)}")
        json_rows.append({"pathKey": pk, "type": t, "url": url, "id": c.get("id"),
                          "reversion": c.get("reversion"),
                          "childrenCount": c.get("childrenCount"),
                          "updatedOn": c.get("updatedOn"),
                          "createdOn": c.get("createdOn"),
                          "duplicates": dup[pk]})
    print(paint("  " + "-" * 100, C.DIM))
    log("INFO", f"folders={counts['folder']} configs={counts['config']} "
                f"screens={counts['screen']} other={counts['?']} total={len(pks)}")
    # save (read-only to repo; writes only to .json_automation)
    (HERE / "map.txt").write_text(f"MAP {base}\n" + "\n".join(txt_lines) + "\n",
                                  encoding="utf-8")
    (HERE / "map.json").write_text(json.dumps(json_rows, ensure_ascii=False, indent=2),
                                   encoding="utf-8")
    log("OK", f"saved -> {HERE / 'map.txt'}")
    log("OK", f"saved -> {HERE / 'map.json'}")
    pause()


def section_fetch() -> None:
    crumb = "Home > Fetch"
    while True:
        choice = menu(
            crumb,
            "Fetch " + paint("(read-only, sandbox: fetched/, auto-normalizes)", C.DIM),
            [("1", "fetch all"),
             ("2", "fetch by features " + paint("(pick pathKey prefix)", C.DIM)),
             ("3", "fetch by name " + paint("(list, then type name(s), multi)", C.DIM)),
             ("4", "fetch by url " + paint("(paste full url, raw)", C.DIM)),
             ("n", f"nav correction " + paint(f"(-> {FETCH_NAV_MODE})", C.DIM))],
            back="back to home",
        )
        if choice == "0":
            return
        if choice == "1":
            run_fetch_all(crumb)
        elif choice == "2":
            run_fetch_features(crumb)
        elif choice == "3":
            run_fetch_by_name(crumb)
        elif choice == "4":
            run_fetch_by_url(crumb)
        elif choice == "n":
            run_navfix(crumb)


# ---------------------------------------------------------------- SYSTEM
def section_system() -> None:
    crumb = "Home > System"
    while True:
        choice = menu(
            crumb,
            "Settings",
            [("1", f"base-url        {paint(CFG.base_url, C.DIM)}"),
             ("p", f"path_key        {paint(CFG.path_key, C.DIM)}"),
             ("2", f"parentId        {paint(CFG.parent_id, C.DIM)}"),
             ("3", f"build number    {paint(str(CFG.build), C.DIM)}"),
             ("4", f"env             {paint(CFG.env, C.DIM)}"),
             ("5", f"stac root       {paint(CFG.stac_root, C.DIM)}"),
             ("6", f"verbose         {paint('on' if CFG.verbose else 'off', C.DIM)}"),
             ("7", f"dimension       {paint(CFG.dimension, C.DIM)}"),
             ("9", f"fetch tuning    {paint(f'page={CFG.page_size} op={CFG.operator} timeout={CFG.timeout}', C.DIM)}"),
             ("l", f"last-version    {paint('on (/all/last-version)' if CFG.last_version else 'off (/all)', C.DIM)}")],
            back="back to home",
        )
        if choice == "0":
            return
        screen(crumb)
        if choice == "1":
            CFG.base_url = ask("base-url", CFG.base_url)
        elif choice == "2":
            CFG.parent_id = ask("parentId", CFG.parent_id)
        elif choice == "3":
            v = ask("build", str(CFG.build))
            if v.isdigit():
                CFG.build = int(v)
        elif choice == "4":
            CFG.env = ask("env (dev/stage/prod)", CFG.env)
        elif choice == "5":
            CFG.stac_root = ask("stac root", CFG.stac_root)
        elif choice == "6":
            CFG.verbose = not CFG.verbose
            log("OK", f"verbose -> {'on' if CFG.verbose else 'off'}")
            pause()
        elif choice == "7":
            CFG.dimension = ask("dimension json", CFG.dimension)
        elif choice == "p":
            CFG.path_key = ask("path_key", CFG.path_key).strip(".")
        elif choice == "9":
            v = ask("page-size", str(CFG.page_size))
            if v.isdigit():
                CFG.page_size = int(v)
            CFG.operator = ask("operator", CFG.operator)
            v = ask("timeout", str(CFG.timeout))
            if v.isdigit():
                CFG.timeout = int(v)
        elif choice == "l":
            CFG.last_version = not CFG.last_version
            log("OK", f"last-version -> {'on' if CFG.last_version else 'off'}")
            pause()


# ---------------------------------------------------------------- home
def section_home() -> None:
    options = [
        ("1", paint("Build", C.B) + "   flow dart -> stac build -> built_json/"),
        ("2", paint("Upload", C.B) + "  POST jsons to panel"),
        ("3", paint("Fetch", C.B) + "   download from panel (sandbox)"),
        ("5", paint("Map", C.B) + "     full tree from path_key (folders/configs/screens)"),
        ("4", paint("System", C.B) + "  settings"),
    ]
    while True:
        screen("Home")
        config_panel()
        print(paint("  " + "-" * 52, C.DIM))
        print()
        for key, label in options:
            print(f"   {paint(key, C.B + C.CYAN)})  {label}")
        print()
        print(f"   {paint('0', C.DIM)})  {paint('quit', C.DIM)}")
        print()
        try:
            choice = input(paint(" > ", C.B + C.GREEN)).strip().lower()
        except (EOFError, KeyboardInterrupt):
            choice = "0"
        if choice == "0":
            screen("Home")
            print(paint("  bye.\n", C.DIM))
            return
        elif choice == "1":
            section_build()
        elif choice == "2":
            section_upload()
        elif choice == "3":
            section_fetch()
        elif choice == "5":
            run_map("Home > Map")
        elif choice == "4":
            section_system()
        else:
            log("WARN", f"invalid choice: {choice or '(empty)'}")
            pause()


def main() -> int:
    section_home()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
