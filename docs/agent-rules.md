# AI Agent Rules & Change Memory

## Project Snapshot
- Entry point `lib/main.dart` starts `MaterialApp`.
- Primary package dependencies include `cupertino_icons`, `collection`, `basic_utils`, `hooks_riverpod`, +47 more.
- Repository targets Flutter multi-platform builds: `android`, `ios`, `web`, `macos`, `linux`, `windows`.
- Keep updates focused on architecture, behavior rules, and high-impact changes only.
- Prefer short, implementation-focused bullets over narrative prose.

## Behavior Rules
- Keep new Tobank STAC features inside their own feature folder with `dart`, `json`, and `api` subfolders.
- Do not replace the legacy `lib/stac/tobank/home` flow unless the user explicitly asks for it.
- When adding a new routeable Dart STAC screen, also register its widget type in the STAC widget loader.
- Prefer existing Tobank assets and patterns before introducing new UI assets or navigation shapes.
- Keep bottom navigation outside child page implementations when the user marks it as parent-owned UI.
- For v1 feature work, enable only the paths the user requested and keep out-of-scope buttons visually present but inactive when needed.
- Never auto-convert local STAC `assetPath` values from `/json/*.json` to `/api/GET_*.json` unless the user explicitly asks for API-path mode.
- Treat Persian/Arabic JSON and Dart files as UTF-8 only; when scripting file edits use explicit UTF-8 read/write APIs and avoid shell defaults that can cause mojibake (`Ã...`, `Ø...`, `ï¿½...`).

## Recent Changes (Last 20)
### 2026-05-02T09:49:46+03:30
- Changed files: `lib/core/stac/parsers/widgets/tobank_mega_gasht_webview_parser.dart`
- Summary: Added categorized Mega Gasht webview diagnostics for initial requests, navigation decisions, load progress, load completion snapshots, HTTP/resource errors, external launches, lifecycle resume, and back handling.
- Behavior impact: Recorded code-level deltas for future AI context.
<!-- fingerprint:4182a2a93235 -->

### 2026-05-02T09:42:16+03:30
- Changed files: `lib/core/stac/builders/stac_common_builders.dart`, `lib/core/stac/builders/stac_custom_actions.dart`, `lib/core/stac/parsers/widgets/tobank_mega_gasht_webview_parser.dart`, `lib/core/stac/registry/register_custom_parsers.dart`, `lib/core/stac/services/widget/stac_widget_loader.dart`, `lib/stac/tobank/home_page/dart/home_page.dart`, `lib/stac/tobank/home_page/inline_dart/home_page.dart`, `lib/stac/tobank/home_page/dart/travel_services_page.dart`, +3 more
- Summary: Added Tobank travel services Stac page, Mega Gasht webview parser/back action, home services navigation, loader registration, and generated JSON/API artifacts.
- Behavior impact: Recorded code-level deltas for future AI context.
<!-- fingerprint:607680c24663 -->

## Last Updated
- 2026-05-02T09:49:46+03:30
