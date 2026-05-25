# STAC Folder - Screen DSL Files

This folder contains STAC screen definitions (Dart DSL) and build tooling for the Tobank SDUI project.

## Structure

- **`.build/`** - Generated JSON files (output of `stac build`, temporary)
- **`ready_for_build/`** - Place Dart screen files here before running `stac build`
- **`config/`** - App config JSON files (assets, strings)
- **`design_system/`** - Theme and color definition files
- **`tobank/`** - Feature-based screen definitions (flows, menu, onboarding, auth)

## Build Workflow

1. Copy dart screen file into `ready_for_build/`
2. Run `stac build`
3. JSON output appears in `.build/`

## Key Files (in core)

- `default_stac_options.dart` → `lib/core/stac/default_stac_options.dart` (STAC CLI config)
- Registry → `lib/core/stac/registry/` (parser registration)
