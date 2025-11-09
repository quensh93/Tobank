# Docs Root Do Dont

# Docs Root Do Dont
# Docs Root Do Dont
**Riverpod**
[](https://riverpod.dev/docs/root/do_dont)
Search
  * DO/DON'T
# DO/DON'T
To ensure good maintainability of your code, here is a list of good practices you should follow when using Riverpod.
This list is not exhaustive, and is subject to change.  
If you have any suggestions, feel free to open an issue.
Items in this list are not in any particular order.
A good portion of these recommendations can be enforced with riverpod_lint. See Getting started for installation instructions.
## AVOID initializing providers in a widget​
Providers should initialize themselves.  
They should not be initialized by an external element such as a widget.
Failing to do so could cause possible race conditions and unexpected behaviors.
**DON'T**
```
classWidgetStateextendsState{  
@override  
voidinitState(){  
super.initState();  
// Bad: the provider should initialize itself  
    ref.read(provider).init();  
}  
}  
```
**CONSIDER**
There is no "one-size fits all" solution to this problem.  
If your initialization logic depends on factors external to the provider, often the correct place to put such logic is in the `onPressed` method of a button triggering navigation:
```
ElevatedButton(  
  onPressed:(){  
    ref.read(provider).init();  
Navigator.of(context).push(...);  
},  
  child:Text('Navigate'),  
)  
```
## AVOID using providers for Ephemeral state.​
Providers are designed to be for shared business state. They are not meant to be used for Ephemeral state, such as for:
  * The currently selected item.
  * Form state/ Because leaving and re-entering the form should typically reset the form state. This includes pressing the back button during a multi-page forms.
  * Animations.
  * Generally everything that Flutter deals with a "controller" (e.g. `TextEditingController`)
If you are looking for a way to handle local widget state, consider using flutter_hooks instead.
One reason why this is discouraged is that such state is often scoped to a route.  
Failing to do so could break your app's back button, due to a new page overriding the state of a previous page.
For instance say we were to store the currently selected `book` in a provider:
```
final selectedBookProvider =StateProvider((ref)=>null);  
```
One challenge we could face is, the navigation history could look like:
```
/books  
/books/42  
/books/21  
```
In this scenario, when pressing the back button, we should expect to go back to `/books/42`. But if we were to use `selectedBookProvider` to store the selected book, the selected ID would not reset to its previous value, and we would keep seeing `/books/21`.
## DON'T perform side effects during the initialization of a provider​
Providers should generally be used to represent a "read" operation. You should not use them for "write" operations, such as submitting a form.
Using providers for such operations could have unexpected behaviors, such as skipping a side-effect if a previous one was performed.
If you are looking at a way to handle loading/error states of a side-effect, see Mutations (experimental).
**DON'T** :
```
final submitProvider =FutureProvider((ref)async{  
final formState = ref.watch(formState);  
// Bad: Providers should not be used for "write" operations.  
return http.post('https://my-api.com', body: formState.toJson());  
});  
```
## PREFER ref.watch/read/listen (and similar APIs) with statically known providers​ with statically known providers")
Riverpod strongly recommends enabling lint rules (via `riverpod_lint`).  
But for lints to be effective, your code should be written in a way that is statically analysable.
Failing to do so could make it harder to spot bugs or cause false positives with lints.
**Do** :
```
final provider =Provider((ref)=>42);  
...  
// OK because the provider is known statically  
ref.watch(provider);  
```
**Don't** :
```
classExampleextendsConsumerWidget{  
Example({required this.provider});  
finalProvider provider;  
@override  
Widgetbuild(context, ref){  
// Bad because static analysis cannot know what `provider` is  
    ref.watch(provider);  
}  
}  
```
## AVOID dynamically creating providers​
Providers should exclusively be top-level final variables.
**Do** :
```
final provider =Provider((ref)=>'Hello world');  
```
**Don't** :
```
classExample{  
// Unsupported operation. Could cause memory leaks and unexpected behaviors.  
final provider =Provider((ref)=>'Hello world');  
}  
```
Creating providers as static final variables is allowed, but not supported by the code-generator.
[](https://github.com/rrousselGit/riverpod/edit/master/website/docs/root/do_dont.mdx)
 Getting started
  * AVOID initializing providers in a widget
  * AVOID using providers for Ephemeral state.
  * DON'T perform side effects during the initialization of a provider
  * PREFER ref.watch/read/listen (and similar APIs) with statically known providers
  * AVOID dynamically creating providers
Docs