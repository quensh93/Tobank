import 'package:stac/stac.dart';
import 'core/bootstrap/bootstrap.dart';

void main() async {
  // Initialize STAC framework
  await Stac.initialize();
  
  // Use bootstrap for app initialization
  await bootstrap();
}

