# Docs Introduction Getting Started

# Getting started
## ​
To get a feel of Riverpod, try it online on Dartpad or on Zapp:
## Installing the package​
Riverpod comes as a main "riverpod" package that’s self-sufficient, complemented by optional packages for using code generation (About code generation) and hooks (About hooks).
Once you know what package(s) you want to install, proceed to add the dependency to your app in a single line like this:
  * Dart only
  * riverpod
  * riverpod + flutter_hooks
  * riverpod_generator
  * riverpod_generator + flutter_hooks
```
flutter pub add flutter_riverpod  
flutter pub add dev:custom_lint  
flutter pub add dev:riverpod_lint  
```
```
flutter pub add hooks_riverpod  
flutter pub add flutter_hooks  
flutter pub add dev:custom_lint  
flutter pub add dev:riverpod_lint  
```
```
flutter pub add flutter_riverpod  
flutter pub add riverpod_annotation  
flutter pub add dev:riverpod_generator  
flutter pub add dev:build_runner  
flutter pub add dev:custom_lint  
flutter pub add dev:riverpod_lint  
```
```
flutter pub add hooks_riverpod  
flutter pub add flutter_hooks  
flutter pub add riverpod_annotation  
flutter pub add dev:riverpod_generator  
flutter pub add dev:build_runner  
flutter pub add dev:custom_lint  
flutter pub add dev:riverpod_lint  
```
  * riverpod
  * riverpod_generator
```
dart pub add riverpod  
dart pub add dev:custom_lint  
dart pub add dev:riverpod_lint  
```
```
dart pub add riverpod  
dart pub add riverpod_annotation  
dart pub add dev:riverpod_generator  
dart pub add dev:build_runner  
dart pub add dev:custom_lint  
dart pub add dev:riverpod_lint  
```
Alternatively, you can manually add the dependency to your app from within your `pubspec.yaml`:
  * Dart only
  * riverpod
  * riverpod + flutter_hooks
  * riverpod_generator
  * riverpod_generator + flutter_hooks
pubspec.yaml
```
name: my_app_name  
environment:  
sdk: ^3.7.0  
flutter:">=3.0.0"  
dependencies:  
flutter:  
sdk: flutter  
flutter_riverpod: ^3.0.3  
dev_dependencies:  
custom_lint:  
riverpod_lint: ^3.0.3  
```
pubspec.yaml
```
name: my_app_name  
environment:  
sdk: ^3.7.0  
flutter:">=3.0.0"  
dependencies:  
flutter:  
sdk: flutter  
hooks_riverpod: ^3.0.3  
flutter_hooks:  
dev_dependencies:  
custom_lint:  
riverpod_lint: ^3.0.3  
```
pubspec.yaml
```
name: my_app_name  
environment:  
sdk: ^3.7.0  
flutter:">=3.0.0"  
dependencies:  
flutter:  
sdk: flutter  
flutter_riverpod: ^3.0.3  
riverpod_annotation: ^3.0.3  
dev_dependencies:  
build_runner:  
custom_lint:  
riverpod_generator: ^3.0.3  
riverpod_lint: ^3.0.3  
```
pubspec.yaml
```
name: my_app_name  
environment:  
sdk: ^3.7.0  
flutter:">=3.0.0"  
dependencies:  
flutter:  
sdk: flutter  
hooks_riverpod: ^3.0.3  
flutter_hooks:  
riverpod_annotation: ^3.0.3  
dev_dependencies:  
build_runner:  
custom_lint:  
riverpod_generator: ^3.0.3  
riverpod_lint: ^3.0.3  
```
Then, install packages with `flutter pub get`.
  * riverpod
  * riverpod_generator
pubspec.yaml
```
name: my_app_name  
environment:  
sdk: ^3.7.0  
dependencies:  
riverpod: ^3.0.3  
dev_dependencies:  
custom_lint:  
riverpod_lint: ^3.0.3  
```
pubspec.yaml
```
name: my_app_name  
environment:  
sdk: ^3.7.0  
dependencies:  
riverpod: ^3.0.3  
riverpod_annotation: ^3.0.3  
dev_dependencies:  
build_runner:  
custom_lint:  
riverpod_generator: ^3.0.3  
riverpod_lint: ^3.0.3  
```
Then, install packages with `dart pub get`.
If using code-generation, you can now run the code-generator with:
```
dart run build_runner watch -d  
```
That's it. You've added Riverpod to your app!
## Enabling riverpod_lint/custom_lint​
Riverpod comes with an optional riverpod_lint package that provides lint rules to help you write better code, and provide custom refactoring options.
The package should already be installed if you followed the previous steps, but a separate step is necessary to enable it.
To enable riverpod_lint, you need add an `analysis_options.yaml` placed next to your `pubspec.yaml` and include the following:
analysis_options.yaml
```
analyzer:  
plugins:  
- custom_lint  
```
You should now see warnings in your IDE if you made mistakes when using Riverpod in your codebase.
To see the full list of warnings and refactorings, head to the riverpod_lint page.
Those warnings will not show-up in the `dart analyze` command.  
If you want to check those warnings in the CI/terminal, you can run the following:
```
dart run custom_lint  
```
## Usage example: Hello world​
Now that we have installed Riverpod, we can start using it.
The following snippets showcase how to use our new dependency to make a "Hello world":
  * Dart only
  * riverpod
  * riverpod + flutter_hooks
  * riverpod_generator
  * riverpod_generator + flutter_hooks
lib/main.dart
```
import'package:flutter/material.dart';  
import'package:flutter_riverpod/flutter_riverpod.dart';  
// We create a "provider", which will store a value (here "Hello world").  
// By using a provider, this allows us to mock/override the value exposed.  
final helloWorldProvider =Provider((_)=>'Hello world');  
voidmain(){  
runApp(  
// For widgets to be able to read providers, we need to wrap the entire  
// application in a "ProviderScope" widget.  
// This is where the state of our providers will be stored.  
ProviderScope(  
      child:MyApp(),  
),  
);  
}  
// Extend ConsumerWidget instead of StatelessWidget, which is exposed by Riverpod  
classMyAppextendsConsumerWidget{  
@override  
Widgetbuild(BuildContext context,WidgetRef ref){  
finalString value = ref.watch(helloWorldProvider);  
returnMaterialApp(  
      home:Scaffold(  
        appBar:AppBar(title:constText('Example')),  
        body:Center(  
          child:Text(value),  
),  
),  
);  
}  
}  
```
lib/main.dart
```
import'package:flutter/material.dart';  
import'package:flutter_hooks/flutter_hooks.dart';  
import'package:hooks_riverpod/hooks_riverpod.dart';  
// We create a "provider", which will store a value (here "Hello world").  
// By using a provider, this allows us to mock/override the value exposed.  
final helloWorldProvider =Provider((_)=>'Hello world');  
voidmain(){  
runApp(  
// For widgets to be able to read providers, we need to wrap the entire  
// application in a "ProviderScope" widget.  
// This is where the state of our providers will be stored.  
ProviderScope(  
      child:MyApp(),  
),  
);  
}  
// Extend HookConsumerWidget instead of HookWidget, which is exposed by Riverpod  
classMyAppextendsHookConsumerWidget{  
@override  
Widgetbuild(BuildContext context,WidgetRef ref){  
// We can use hooks inside HookConsumerWidget  
final counter =useState(0);  
finalString value = ref.watch(helloWorldProvider);  
returnMaterialApp(  
      home:Scaffold(  
        appBar:AppBar(title:constText('Example')),  
        body:Center(  
          child:Text('$value${counter.value}'),  
),  
),  
);  
}  
}  
```
lib/main.dart
```
import'package:flutter/material.dart';  
import'package:flutter_riverpod/flutter_riverpod.dart';  
import'package:riverpod_annotation/riverpod_annotation.dart';  
part'main.g.dart';  
// We create a "provider", which will store a value (here "Hello world").  
// By using a provider, this allows us to mock/override the value exposed.  
@riverpod  
StringhelloWorld(Ref ref){  
return'Hello world';  
}  
voidmain(){  
runApp(  
// For widgets to be able to read providers, we need to wrap the entire  
// application in a "ProviderScope" widget.  
// This is where the state of our providers will be stored.  
ProviderScope(  
      child:MyApp(),  
),  
);  
}  
// Extend ConsumerWidget instead of StatelessWidget, which is exposed by Riverpod  
classMyAppextendsConsumerWidget{  
@override  
Widgetbuild(BuildContext context,WidgetRef ref){  
finalString value = ref.watch(helloWorldProvider);  
returnMaterialApp(  
      home:Scaffold(  
        appBar:AppBar(title:constText('Example')),  
        body:Center(  
          child:Text(value),  
),  
),  
);  
}  
}  
```
lib/main.dart
```
import'package:flutter/material.dart';  
import'package:flutter_hooks/flutter_hooks.dart';  
import'package:hooks_riverpod/hooks_riverpod.dart';  
import'package:riverpod_annotation/riverpod_annotation.dart';  
part'main.g.dart';  
// We create a "provider", which will store a value (here "Hello world").  
// By using a provider, this allows us to mock/override the value exposed.  
@riverpod  
StringhelloWorld(Ref ref){  
return'Hello world';  
}  
voidmain(){  
runApp(  
// For widgets to be able to read providers, we need to wrap the entire  
// application in a "ProviderScope" widget.  
// This is where the state of our providers will be stored.  
ProviderScope(  
      child:MyApp(),  
),  
);  
}  
// Extend HookConsumerWidget instead of HookWidget, which is exposed by Riverpod  
classMyAppextendsHookConsumerWidget{  
@override  
Widgetbuild(BuildContext context,WidgetRef ref){  
// We can use hooks inside HookConsumerWidget  
final counter =useState(0);  
finalString value = ref.watch(helloWorldProvider);  
returnMaterialApp(  
      home:Scaffold(  
        appBar:AppBar(title:constText('Example')),  
        body:Center(  
          child:Text('$value${counter.value}'),  
),  
),  
);  
}  
}  
```
Then, start the application with `flutter run`.  
This will render "Hello world" on your device.
  * riverpod
  * riverpod_generator
lib/main.dart
```
import'package:riverpod/riverpod.dart';  
// We create a "provider", which will store a value (here "Hello world").  
// By using a provider, this allows us to mock/override the value exposed.  
final helloWorldProvider =Provider((_)=>'Hello world');  
voidmain(){  
// This object is where the state of our providers will be stored.  
final container =ProviderContainer();  
// Thanks to "container", we can read our provider.  
final value = container.read(helloWorldProvider);  
print(value);// Hello world  
}  
```
lib/main.dart
```
import'package:riverpod_annotation/riverpod_annotation.dart';  
part'main.g.dart';  
// We create a "provider", which will store a value (here "Hello world").  
// By using a provider, this allows us to mock/override the value exposed.  
@riverpod  
StringhelloWorld(Ref ref){  
return'Hello world';  
}  
voidmain(){  
// This object is where the state of our providers will be stored.  
final container =ProviderContainer();  
// Thanks to "container", we can read our provider.  
final value = container.read(helloWorldProvider);  
print(value);// Hello world  
}  
```
Then, start the application with `dart lib/main.dart`.  
This will print "Hello world" in the console.
## ​
If you are using `Flutter` and `VS Code` , consider using Flutter Riverpod Snippets
If you are using `Flutter` and `Android Studio` or `IntelliJ`, consider using Flutter Riverpod Snippets
[](https://github.com/rrousselGit/riverpod/edit/master/website/docs/introduction/getting_started.mdx)
 Your first Riverpod app
  * Installing the package
  * Enabling riverpod_lint/custom_lint
  * Usage example: Hello world
Docs