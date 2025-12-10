# STAC Folder - Core STAC Files

This folder contains all STAC (Server-Driven UI) related files for the Tobank SDUI project.

See [STAC Folder Structure Documentation](../../docs/stac/STAC_FOLDER_STRUCTURE.md) for complete details.

## Quick Reference

- **`.build/`** - Generated JSON files (STAC build output)
- **`api_mock/`** - Mock API responses for development
- **`design_system/`** - Theme and UI design system files
- **`localization/`** - Localization/translation strings
- **`actions/`** - Custom STAC actions (empty for now)
- **`widgets/`** - Custom STAC widgets (empty for now)
- **`registry/`** - STAC component registry
- **`tobank/`** - Feature-based screen definitions
- **`default_stac_options.dart`** - STAC CLI configuration

## Asset Path Note

⚠️ **Important**: Some assets may need to remain accessible from root level for Flutter's asset system. If asset loading fails, we may need to:
1. Create symlinks from root `stac/` to `lib/stac/`
2. Or update asset loading to use file system access instead of `rootBundle`
