import 'package:stac_core/core/stac_options.dart';

/// Default STAC options for the project
/// 
/// This file is required for STAC CLI to work properly (for `stac build` command).
/// 
/// **IMPORTANT**: This is for LOCAL development ONLY.
/// - We do NOT deploy to STAC Cloud servers
/// - All JSON files are stored locally in `lib/stac/.build/`
/// - This configuration is only used by the STAC CLI build process
/// - The `projectId` is just an identifier for local builds, not for cloud deployment
final defaultStacOptions = StacOptions(
  name: 'Tobank SDUI Mock',
  description: 'Local-only Tobank SDUI mock implementation using STAC framework',
  projectId: 'tobank_sdui_local', // Local identifier only - NOT used for cloud deployment
  sourceDir: 'lib/stac/tobank', // Where STAC Dart widget files are located
  outputDir: 'lib/stac/.build', // Where STAC CLI generates JSON files (temporary)
);
