# Docs Migration From Change Notifier

# Docs Migration From Change Notifier
# Docs Migration From Change Notifier
**Riverpod**
[](https://riverpod.dev/docs/migration/from_change_notifier)
Search
  * From `ChangeNotifier`
# From `ChangeNotifier`
Within Riverpod, `ChangeNotifierProvider` is meant to be used to offer a smooth transition from pkg:provider.
If you've just started a migration to pkg:riverpod, make sure you read the dedicated guide (see Quickstart). This article is meant for folks that already transitioned to riverpod, but want to move away from `ChangeNotifier`.
All in all, migrating from `ChangeNotifier` to `AsyncNotifier` requires a paradigm shift, but it brings great simplification with the resulting migrated code.
Take this (faulty) example:
```
classMyChangeNotifierextendsChangeNotifier{  
MyChangeNotifier(){  
_init();  
}  
List todos =[];  
  bool isLoading =true;  
  bool hasError =false;  
Future_init()async{  
try{  
final json =await http.get('api/todos');  
      todos =[...json.map(Todo.fromJson)];  
}onException{  
      hasError =true;  
}finally{  
      isLoading =false;  
notifyListeners();  
}  
}  
FutureaddTodo(int id)async{  
    isLoading =true;  
notifyListeners();  
try{  
final json =await http.post('api/todos');  
      todos =[...json.map(Todo.fromJson)];  
      hasError =false;  
}onException{  
      hasError =true;  
}finally{  
      isLoading =false;  
notifyListeners();  
}  
}  
}  
final myChangeProvider =ChangeNotifierProvider((ref){  
returnMyChangeNotifier();  
});  
```
This implementation shows several weak design choices such as:
  * The usage of `isLoading` and `hasError` to handle different asynchronous cases
  * The need to carefully handle requests with tedious `try`/`catch`/`finally` expressions
  * The need to invoke `notifyListeners` at the right times to make this implementation work
  * The presence of inconsistent or possibly undesirable states, e.g. initialization with an empty list
Note how this example has been crafted to show how `ChangeNotifier` can lead to faulty design choices for newbie developers; also, another takeaway is that mutable state might be way harder than it initially promises.
`Notifier`/`AsyncNotifier`, in combination with immutable state, can lead to better design choices and less errors.
Let's see how to migrate the above snippet, one step at a time, towards the newest APIs.
## Start your migration​
First, we should declare the new provider / notifier: this requires some thought process which depends on your unique business logic.
Let's summarize the above requirements:
  * State is represented with `List`, which obtained via a network call, with no parameters
  * State should _also_ expose info about its `loading`, `error` and `data` state
  * State can be mutated via some exposed methods, thus a function isn't enough
The above thought process boils down to answering the following questions:
  1. Are some side effects required?
     * `y`: Use riverpod's class-based API
     * `n`: Use riverpod's function-based API
  2. Does state need to be loaded asynchronously?
     * `y`: Let `build` return a `Future`
     * `n`: Let `build` simply return `T`
  3. Are some parameters required?
     * `y`: Let `build` (or your function) accept them
     * `n`: Let `build` (or your function) accept no extra parameters
If you're using codegen, the above thought process is enough.  
There's no need to think about the right class names and their _specific_ APIs.  
`@riverpod` only asks you to write a class with its return type, and you're good to go.
Technically, the best fit here is to define a `AsyncNotifier>`, which meets all the above requirements. Let's write some pseudocode first.
  * riverpod
  * riverpod_generator
```
classMyNotifierextendsAsyncNotifier>{  
@override  
FutureOr>build(){  
// TODO ...  
return[];  
}  
FutureaddTodo(Todo todo)async{  
// TODO  
}  
}  
final myNotifierProvider =  
AsyncNotifierProvider.autoDispose>(MyNotifier.new);  
```
```
@riverpod  
classMyNotifierextends _$MyNotifier{  
@override  
FutureOr>build(){  
// TODO ...  
return[];  
}  
FutureaddTodo(Todo todo)async{  
// TODO  
}  
}  
```
Remember: use snippets in your IDE to get some guidance, or just to speed up your code writing. See Getting started.
With respect with `ChangeNotifier`'s implementation, we don't need to declare `todos` anymore; such variable is `state`, which is implicitly loaded with `build`.
Indeed, riverpod's notifiers can expose _one_ entity at a time.
Riverpod's API is meant to be granular; nonetheless, when migrating, you can still define a custom entity to hold multiple values. Consider using Dart 3's records to smooth out the migration at first.
### Initialization​
Initializing a notifier is easy: just write initialization logic inside `build`. We can now get rid of the old `_init` function.
  * riverpod
  * riverpod_generator
```
classMyNotifierextendsAsyncNotifier>{  
@override  
FutureOr>build()async{  
final json =await http.get('api/todos');  
return[...json.map(Todo.fromJson)];  
}  
}  
final myNotifierProvider =  
AsyncNotifierProvider.autoDispose>(MyNotifier.new);  
```
```
@riverpod  
classMyNotifierextends _$MyNotifier{  
@override  
FutureOr>build()async{  
final json =await http.get('api/todos');  
return[...json.map(Todo.fromJson)];  
}  
}  
```
With respect of the old `_init`, the new `build` isn't missing anything: there is no need to initialize variables such as `isLoading` or `hasError` anymore.
Riverpod will automatically translate any asynchronous provider, via exposing an `AsyncValue>` and handles the intricacies of asynchronous state way better than what two simple boolean flags can do.
Indeed, any `AsyncNotifier` effectively makes writing additional `try`/`catch`/`finally` an anti-pattern for handling asynchronous state.
### Mutations and Side Effects​
Just like initialization, when performing side effects there's no need to manipulate boolean flags such as `hasError`, or to write additional `try`/`catch`/`finally` blocks.
Below, we've cut down all the boilerplate and successfully fully migrated the above example:
  * riverpod
  * riverpod_generator
```
classMyNotifierextendsAsyncNotifier>{  
@override  
FutureOr>build()async{  
final json =await http.get('api/todos');  
return[...json.map(Todo.fromJson)];  
}  
FutureaddTodo(Todo todo)async{  
// optional: state = const AsyncLoading();  
final json =await http.post('api/todos');  
final newTodos =[...json.map(Todo.fromJson)];  
    state =AsyncData(newTodos);  
}  
}  
final myNotifierProvider =  
AsyncNotifierProvider.autoDispose>(MyNotifier.new);  
```
```
@riverpod  
classMyNotifierextends _$MyNotifier{  
@override  
FutureOr>build()async{  
final json =await http.get('api/todos');  
return[...json.map(Todo.fromJson)];  
}  
FutureaddTodo(Todo todo)async{  
// optional: state = const AsyncLoading();  
final json =await http.post('api/todos');  
final newTodos =[...json.map(Todo.fromJson)];  
    state =AsyncData(newTodos);  
}  
}  
```
Syntax and design choices may vary, but in the end we just need to write our request and update state afterwards. See Providers.
## Migration Process Summary​
Let's review the whole migration process applied above, from a operational point of view.
  1. We've moved the initialization, away from a custom method invoked in a constructor, to `build`
  2. We've removed `todos`, `isLoading` and `hasError` properties: internal `state` will suffice
  3. We've removed any `try`-`catch`-`finally` blocks: returning the future is enough
  4. We've applied the same simplification on the side effects (`addTodo`)
  5. We've applied the mutations, via simply reassign `state`
[](https://github.com/rrousselGit/riverpod/edit/master/website/docs/migration/from_change_notifier.mdx)
 ^0.14.0 to ^1.0.0
  * Start your migration
    * Mutations and Side Effects
  * Migration Process Summary
Docs