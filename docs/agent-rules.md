# AI Agent Rules & Change Memory

## Project Snapshot

- Tobank SDUI screens are implemented with STAC Dart builders under `lib/stac/tobank`.
- Routeable Dart STAC screens must be registered in `lib/core/stac/services/widget/stac_widget_loader.dart`.
- Menu content is driven by `lib/stac/tobank/menu/api/GET_menu-items.json`.
- Local reactive screen state uses the custom `stateFull`, `setValue`, `visibility`, and `registryReactive` STAC extensions.
- Existing legacy feature sections such as `home`, `profile`, and `menu` remain active beside new flows.
- Assets are loaded from `assets/icons/` and `assets/images/`, with shared config under `lib/stac/config/GET_assets.json`.

## Behavior Rules

- Keep new Tobank STAC features inside their own feature folder with `dart`, `json`, and `api` subfolders.
- Do not replace the legacy `lib/stac/tobank/home` flow unless the user explicitly asks for it.
- When adding a new routeable Dart STAC screen, also register its widget type in the STAC widget loader.
- Prefer existing Tobank assets and patterns before introducing new UI assets or navigation shapes.
- Keep bottom navigation outside child page implementations when the user marks it as parent-owned UI.
- For v1 feature work, enable only the paths the user requested and keep out-of-scope buttons visually present but inactive when needed.

## Recent Changes (Last 20)

- 2026-04-19: Added a new Tobank `home_page` flow with a selector screen, Dart home page, menu integration in `apiFlows`, and widget-loader registration. Kept the legacy `home` screen unchanged.

## Last Updated

- 2026-04-19
