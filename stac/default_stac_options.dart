import 'package:stac/stac.dart';

/// Default STAC options for the project
/// This file is required for STAC to work properly
final defaultStacOptions = StacOptions(
  projectName: 'tobank_sdui',
  projectId: 'tobank_sdui_demo',
  baseUrl: 'https://api.stac.dev',
  apiKey: 'demo_key', // For local development
);
