import 'package:stac/stac.dart';

/// Default STAC options for the project
///
/// This file is required for STAC CLI to work properly (for `stac build` command).
///
/// **IMPORTANT**: This is for LOCAL development ONLY.
/// - We do NOT deploy to STAC Cloud servers
/// - All JSON files are stored locally in `lib/stac/.build/`
/// - This configuration is only used by the STAC CLI build process
/// - The `projectId` is just an identifier for local builds, not for cloud deployment
///
/// **BUILD WORKFLOW**:
/// - Only files placed in `lib/stac/ready_for_build/` will be built
/// - Copy or symlink Dart files you want to build into that folder
/// - Run `stac build` to build only those files
/// - This avoids building all files every time
final defaultStacOptions = StacOptions(
  name: 'Tobank SDUI Mock',
  description:
      'Local-only Tobank SDUI mock implementation using STAC framework',
  projectId:
      'tobank_sdui_local', // Local identifier only - NOT used for cloud deployment
  sourceDir:
      'lib/stac/ready_for_build', // Only build files placed in this folder
  outputDir:
      'lib/stac/.build', // Where STAC CLI generates JSON files (temporary)
);
