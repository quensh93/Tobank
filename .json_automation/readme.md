# JSON Automation Panel

CLI tool to **build**, **upload**, and **fetch** Stac SDUI JSON screens for the Tobank project.

Replaces the old split toolchain (Node uploader + Python downloader/normalizer) with one cross-platform CLI.

---

## Stack

- **Python 3** (single stack, cross-platform: Windows + macOS).
- HTTP via `requests` (drops old `curl` dependency).
- JSON via stdlib (drops old `jq` dependency).
- Paths via `pathlib` (no hardcoded OS paths).

---

## Directory layout

```
.json_automation/
  readme.md
  panel.py              # entry, sticky-section CLI
  config.py             # env / base-url / parentId / build (persisted, no hardcode)
  build.py              # flow dart -> stac build -> navMode correction
  upload.py             # batch POST to panel
  fetch.py              # download panel configs (sandboxed)
  navfix.py             # navMode correction
  logger.py             # tagged logging
  flow_map.json         # (future) panel-key -> flow routing if needed

  built_json/           # OUTPUT of build, per flow:  built_json/<flow>/*.json
  fetched/              # OUTPUT of fetch (sandbox, never touches repo code)
  logs/                 # per-section run logs
```

Stac source root (read for build): `lib/stac`
- flows dart:   `lib/stac/tobank/flows/<flow>/dart/`
- stac build in:  `lib/stac/ready_for_build/`
- stac build out: `lib/stac/.build/screens/`
- config (upload-only): `lib/stac/config/assets.json`, `lib/stac/config/strings.json`, `lib/stac/design_system/colors.json`

---

## CLI map

```
+= JSON Automation Panel ===============================+
| System: <env> (<base-url>) parentId:<id> build:<n>    |
| Stac root: lib/stac   Out: .json_automation/built_json|
+=======================================================+
 GLOBAL KEYS (any time): [b]uild  [u]pload  [f]etch  [s]ystem  [q]uit
---------------------------------------------------------

[b] BUILD --------------------------------------- (sticky)
   step A - pick build type:
     1) api json build      -> navMode: apiJson
     2) local json build    -> navMode: localJson
   step B - pick flow(s) (whole flow):
     show flow list from lib/stac/tobank/flows/*
     select one or many
   pipeline per run:
     wipe lib/stac/ready_for_build/
       -> copy selected flow dart files in
       -> run `stac build` [--verbose]
       -> read output from lib/stac/.build/screens/
       -> navMode correction (per build type)
       -> move built json -> .json_automation/built_json/<flow>/

[u] UPLOAD -------------------------------------- (sticky)
     1) upload flow jsons     POST built_json/<flow>/* -> /configs/add
     2) upload asset binding  POST assets.json + strings.json + colors.json
     3) dry-run preview        show payloads, no send
     4) preview + upload       chain 3 -> (1|2)

[f] FETCH --------------------------------------- (sticky)
   READ-ONLY to repo. Output isolated in .json_automation/fetched/.
     1) fetch all              download mobile configs + _index.json
     2) normalize              value-only strip (keep `value`)
     3) nav correction         force navMode (api/local)
   files arrive with correct path structure (pathKey) from API,
   already placed in their related folder under fetched/.

[s] SYSTEM ------------------ (inline edit, return to prev section)
     1) base-url / IP          5) stac root dir
     2) parentId               6) verbose on/off
     3) build number           7) dimension default ({"app":["mobile"]})
     4) switch env (dev/stage/prod)

[q] QUIT
```

### UX rules
- Section is **sticky**: stays open after a run; run many actions in a row.
- Switch section any time with global keys `b/u/f/s/q` (no back-and-forth).
- Multi-select steps: e.g. `1 f` (build type + flow), `1 2` (chain).
- `s` edits config inline, returns to previous section.
- Persistent header shows active config always.

---

## Sub-tasks -> menu mapping

| Sub-task                      | Location |
|-------------------------------|----------|
| select module/system          | `[s]` system, build flow picker |
| auto json build (api/local)   | `[b]` 1 / 2 |
| auto json nav correction      | build step (navMode per type), fetch step 3 |
| auto batch uploader           | `[u]` 1 / 2 |
| fetch all jsons               | `[f]` 1 |
| create map / correct inventory| fetch keeps API path structure under `fetched/` |
| put fetched in correct dir    | auto by pathKey under `fetched/` (no repo write) |

---

## Nav correction rule

Walk json tree, find every object with `"actionType": "navigate"`:
- has `"fileName"` (forward nav) -> set `"navMode"` to target value:
  - api json build  -> `"apiJson"`
  - local json build -> `"localJson"`
- pop action (`navigationStyle: "pop"`, no `fileName`) -> skip (no navMode).

---

## Logging

Per-step, tagged, colored:

```
[INFO]  step start/end, counts, paths
[OK]    success            (green)
[WARN]  skipped / partial  (yellow)
[ERR]   failure + reason + file/step context  (red)
[DEBUG] verbose only (stac build stdout, payloads, HTTP req/resp)
```

Rules:
- Every step prints start + result line. Never silent.
- Errors show **which file/key**, **which step**, **exact error** (no swallowing).
  e.g. `[ERR] upload profile_about: 422 - value missing key`
- Counts always: `[OK] nav fixed 12/14 (2 skipped: pop)`.
- Pipeline ends with summary table (page | step | status | note).
- `--verbose` toggle adds DEBUG.
- Tee to `.json_automation/logs/<section>_<timestamp>.log`.

---

## Safety constraints

- **Fetch never writes to repo code** (`lib/stac/**`). Output isolated in `fetched/`.
- Build only wipes `lib/stac/ready_for_build/` (its scratch dir), nothing else.
- No hardcoded IPs / OS paths. All env config via `[s]` system, persisted.

---

## Open TODO (clarify during impl)

- `stac build` exact invocation + how it scopes to `ready_for_build/` contents.
- Upload payload shape per env (parentId/build override per system profile).
- Whether `built_json/` should mirror flow subfolders exactly or flatten.
```
