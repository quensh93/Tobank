# Configurations API — Reference

Source: `http://192.168.179.21:8101/api/configurations/v3/api-docs`
Full spec saved: `openapi.json` (same dir).
Server base: `http://192.168.179.21:8101/api/configurations`

---

## Endpoints

| Method | Path | Body schema | Purpose |
|--------|------|-------------|---------|
| POST | `/v1.0/configs/all?page&size` | **QueryRequest** | list ALL configs (flat, paginated) |
| POST | `/v1.0/configs/all/last-version?page&size` | QueryRequest | same, latest reversion only |
| POST | `/v1.0/configs/tree/{path-key}/{build}/{start}/{end}?page&size` | ResolveConfigRequest | subtree under a pathKey |
| POST | `/v1.0/configs/tree/value/{path-key}/{build}/{start}/{end}` | ResolveConfigRequest | subtree, value-only |
| POST | `/v1.0/configs/resolve/{path-key}/{build}` | ResolveConfigRequest | resolve one config (full) |
| POST | `/v1.0/configs/resolve/value/{path-key}/{build}` | ResolveConfigRequest | resolve one config, value-only |
| POST | `/v1.0/configs/add` | **AddConfigRequest** | create/update config |
| GET | `/v1.0/configs/get/{id}` | — | get one by id |
| PUT | `/v1.0/configs/active/{id}` | — | activate |
| PUT | `/v1.0/configs/disable/{id}` | — | disable |
| DELETE | `/v1.0/configs/delete/{id}` | — | delete |
| POST | `/v1.0/message/add` | AddMessageRequest | (messages, unrelated) |
| GET | `/v1.0/message/resolve/{app}` | — | (messages, unrelated) |

---

## Request schemas

**QueryRequest** (for `/all`):
```json
{ "filters": [ { "property": "pathKey", "operator": "contains", "value": "..." } ],
  "sorts":   [ { "property": "pathKey", "direction": "ASC", "meaningful": true } ] }
```
- empty `{"filters":[],"sorts":[]}` = list everything.
- Filter = `{property, value, operator}`.

**ResolveConfigRequest** (for `/tree`, `/resolve`):
```json
{ "operator": "contains", "dimension": { "app": ["mobile"] } }
```

**AddConfigRequest** (for `/add`):
```json
{ "key": "...", "build": 1, "parentId": "...", "title": "...",
  "dimension": { "app": "mobile" }, "value": { ... }, "schema": {} }
```

---

## Response shapes

All wrapped: `{ "status": Status, "data": <T>, "meta": Meta }`
- `Status` = `{code, message[], description}`
- `Meta`   = `{time, traceId}`

**Paged** (`/all`, `/tree`): `data` = `PageModelConfigResponse` = `{pages, total, content: [ConfigResponse]}`
**Single** (`/get`): `data` = `ConfigByIdResponse`

**ConfigResponse** fields:
```
id, parentId, rootId, depth, pathKey, childrenCount, key, build, reversion,
title, dimension(obj), value(obj), schema(obj),
createdBy/On, updatedBy/On, client, owner, deviceCode, appVersion, channel, os, endTime, activity
```

---

## REQUIRED CODE CHANGES (panel.py)

1. **fetch wrong body** — current `fetch_records()` POSTs `/tree` with `{operator,dimension}`.
   - For "fetch all files" use **`/configs/all`** with **QueryRequest** body
     `{"filters":[],"sorts":[]}` (NOT `{operator,dimension}`). `/all` returns flat
     `content` of every config incl. leaves — the real file list.
   - Earlier "only kyc / total 1" = wrong body schema sent to `/all`.

2. **mobile filter** — `/all` has no dimension arg in path. Either:
   - add Filter `{property:"dimension"...}` (verify server supports), or
   - fetch all + client-filter `dimension.app contains "mobile"` (current `has_mobile_dim`, keep).

3. **fetch by name / pathKey single** — use
   `POST /configs/resolve/value/{path-key}/{build}` → returns value directly
   (no need to normalize). Good for exact-key fetch.

4. **fetch by features** — derive prefixes from `/all` content pathKeys (already done),
   OR query `/tree/{prefix}/{build}/{start}/{end}` to pull a subtree directly.

5. **fetch tuning params** — current `depth/children_limit` map to tree path
   `{start}/{end}` (children index range), `{build}` = build. Rename for clarity later.

6. **upload `/add`** — payload already matches AddConfigRequest. OK.
   `dimension` sent as `{app:"mobile"}` (object) — spec says object, fine.

7. **add `/all/last-version`** option — to fetch only newest reversions.

---

## Quick verified facts
- `/all` body must be QueryRequest, else mis-parsed.
- `/add` payload shape confirmed correct vs current uploader.
- All responses are `{status,data,meta}` — unwrap `data` then `data.content` for lists.
