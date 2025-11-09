# Docs Migration 0.13.0 To 0.14.0

# Docs Migration 0.13.0 To 0.14.0
# Docs Migration 0.13.0 To 0.14.0
**Riverpod**
[](https://riverpod.dev/docs/migration/0.13.0_to_0.14.0)
Search
  * ^0.13.0 to ^0.14.0
# ^0.13.0 to ^0.14.0
With the release of version `0.14.0` of Riverpod, the syntax for using StateNotifierProvider changed (see  for the explanation).
For the entire article, consider the following StateNotifier:
```
classMyModel{}  
classMyStateNotifierextendsStateNotifier{  
MyStateNotifier():super(MyModel());  
}  
```
## The changes​
  * StateNotifierProvider takes an extra generic parameter, which should be the type of the state of your StateNotifier.
Before:
```
final provider =StateNotifierProvider((ref){  
returnMyStateNotifier();  
});  
```
After:
```
final provider =StateNotifierProvider((ref){  
returnMyStateNotifier();  
});  
```
  * to obtain the StateNotifier, you should now read `myProvider.notifier` instead of just `myProvider`:
Before:
```
Widgetbuild(BuildContext context,ScopedReader watch){  
MyStateNotifier notifier =watch(provider);  
}  
```
After:
```
Widgetbuild(BuildContext context,ScopedReader watch){  
MyStateNotifier notifier =watch(provider.notifier);  
}  
```
  * to listen to the state of the StateNotifier, you should now read `myProvider` instead of `myProvider.state`:
Before:
```
Widgetbuild(BuildContext context,ScopedReader watch){  
MyModel state =watch(provider.state);  
}  
```
After:
```
Widgetbuild(BuildContext context,ScopedReader watch){  
MyModel state =watch(provider);  
}  
```
## Using the migration tool to automatically upgrade your projects to the new syntax​
With version 0.14.0 came the release of a command line tool for Riverpod, which can help you migrate your projects.
### Installing the command line​
To install the migration tool, run:
```
dart pub global activate riverpod_cli  
```
You should now be able to run:
```
riverpod --help  
```
### Usage​
Now that the command line is installed, we can start using it.
  * First, open the project you want to migrate in your terminal.
  * **Do not** upgrade Riverpod.  
The migration tool will upgrade the version of Riverpod for you.
  * Make sure that your project does not contain errors.
  * Execute:
```
riverpod migrate  
```
The tool will then analyze your project and suggest changes. For example you may see:
```
Widget build(BuildContext context, ScopedReader watch) {  
-  MyModel state = watch(provider.state);  
+  MyModel state = watch(provider);  
}  
Accept change (y = yes, n = no [default], A = yes to all, q = quit)?   
```
To accept the change, simply press `y`. Otherwise to reject it, press `n`.
[](https://github.com/rrousselGit/riverpod/edit/master/website/docs/migration/0.13.0_to_0.14.0.mdx)
Previous ^0.14.0 to ^1.0.0
  * The changes
  * Using the migration tool to automatically upgrade your projects to the new syntax
    * Installing the command line
Docs