# Docs Migration 0.14.0 To 1.0.0

# Docs Migration 0.14.0 To 1.0.0
# Docs Migration 0.14.0 To 1.0.0
**Riverpod**
[](https://riverpod.dev/docs/migration/0.14.0_to_1.0.0)
  * ^0.14.0 to ^1.0.0
# ^0.14.0 to ^1.0.0
After a long wait, the first stable version of Riverpod is finally released 👏
To see the full list of changes, consult the Changelog.  
In this page, we will focus on how to migrate an existing Riverpod application from version 0.14.x to version 1.0.0.
## Using the migration tool to automatically upgrade your project to the new syntax​
Before explaining the various changes, it is worth noting that Riverpod comes with a command-line tool to automatically migrate your project for you.
### Installing the command line tool​
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
Not upgrading Riverpod is important.  
The tool will not execute properly if you have already installed version 1.0.0. As such, make sure that you are properly using an older version before starting the tool.
  * Make sure that your project does not contain errors.
  * Execute:
```
riverpod migrate  
```
The tool will then analyze your project and suggest changes. For example you may see:
```
-Widget build(BuildContext context, ScopedReader watch) {  
+Widget build(BuildContext context, Widget ref) {  
-  MyModel state = watch(provider);  
+  MyModel state = ref.watch(provider);  
}  
Accept change (y = yes, n = no [default], A = yes to all, q = quit)?  
```
To accept the change, simply press `y`. Otherwise to reject it, press `n`.
## The changes​
Now that we've seen how to use the CLI to automatically upgrade your project, let's see in detail the changes necessary.
### Syntax unification​
Version 1.0.0 of Riverpod focused on the unification of the syntax for interacting with providers.  
Before, Riverpod had many similar yet different syntaxes for reading a provider, such as `ref.watch(provider)` vs `useProvider(provider)` vs `watch(provider)`.  
With version 1.0.0, only one syntax remains: `ref.watch(provider)`. The others were removed.
As such:
  * `useProvider` is removed in favor of `HookConsumerWidget`.
Before:
```
classExampleextendsHookWidget{  
@override  
Widgetbuild(BuildContext context){  
useState(...);  
    int count =useProvider(counterProvider);  
...  
}  
}  
```
After:
```
classExampleextendsHookConsumerWidget{  
@override  
Widgetbuild(BuildContext context,WidgetRef ref){  
useState(...);  
    int count = ref.watch(counterProvider);  
...  
}  
}  
```
  * The prototype of `ConsumerWidget`'s `build` and `Consumer`'s `builder` changed.
Before:
```
classExampleextendsConsumerWidget{  
@override  
Widgetbuild(BuildContext context,ScopedReader watch){  
    int count =watch(counterProvider);  
...  
}  
}  
Consumer(  
  builder:(context, watch, child){  
    int count =watch(counterProvider);  
...  
}  
)  
```
After:
```
classExampleextendsConsumerWidget{  
@override  
Widgetbuild(BuildContext context,WidgetRef ref){  
    int count = ref.watch(counterProvider);  
...  
}  
}  
Consumer(  
  builder:(context, ref, child){  
    int count = ref.watch(counterProvider);  
...  
}  
)  
```
  * `context.read` is removed in favor of `ref.read`.
Before:
```
classExampleextendsStatelessWidget{  
@override  
Widgetbuild(BuildContext context){  
SomeButton(  
      onPressed:()=> context.read(provider.notifier).doSomething(),  
);  
}  
}  
```
After:
```
classExampleextendsConsumerWidget{  
@override  
Widgetbuild(BuildContext context,WidgetRef ref){  
SomeButton(  
      onPressed:()=> ref.read(provider.notifier).doSomething(),  
);  
}  
}  
```
### StateProvider update​
StateProvider was updated to match StateNotifierProvider.
Before, doing `ref.watch(StateProvider)` returned a `StateController` instance. Now it only returns the state of the `StateController`.
To migrate you have a few solutions.  
If your code only obtained the state without modifying it, you can change from:
```
final provider =StateProvider(...);  
Consumer(  
  builder:(context, ref, child){  
StateController count = ref.watch(provider);  
returnText('${count.state}');  
}  
)  
```
to:
```
final provider =StateProvider(...);  
Consumer(  
  builder:(context, ref, child){  
    int count = ref.watch(provider);  
returnText('${count}');  
}  
)  
```
Alternatively you can use the new `StateProvider.state` to keep the old behavior.
```
final provider =StateProvider(...);  
Consumer(  
  builder:(context, ref, child){  
StateController count = ref.watch(provider.state);  
returnText('${count.state}');  
}  
)  
```
[](https://github.com/rrousselGit/riverpod/edit/master/website/docs/migration/0.14.0_to_1.0.0.mdx)
 ^0.13.0 to ^0.14.0
  * Using the migration tool to automatically upgrade your project to the new syntax
    * Installing the command line tool
  * The changes
    * Syntax unification
    * StateProvider update
Docs