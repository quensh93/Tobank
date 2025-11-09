# Docs Whats New

# What's new in Riverpod 3.0
Welcome to Riverpod 3.0!  
This update includes many long-due features, bug fixes, and simplifications of the API.
This version is a transition period toward a simpler, unified Riverpod. 
This version contains a few life-cycle changes. Those could break your app in subtle ways. Upgrade carefully.  
For the migration guide, please refer to the migration page.
Some of the key highlights include:
  * Offline persistence (experimental) - Providers can now opt-in to be persisted to a database
  * Mutations (experimental) - A new mechanism to enable interfaces to react to side-effects
  * Automatic retry - Providers now refresh when they fail, with exponential backoff
  * `Ref.mounted` - Similar to `BuildContext.mounted`, but for `Ref`.
  * Generic support (code-generation) - Generated providers can now define type parameters
  * Pause/Resume support - Temporarily pause a listener when using `ref.listen`
  * Unification of the Public APIs - Behaviors are unified and duplicate interfaces are fused
  * Provider life-cycle changes - Slight tweaks to how providers behave, to better fit modern code
  * New testing utilities:
    * `ProviderContainer.test` - A test util that creates a container and automatically disposes it after the test ends.
    * `NotifierProvider.overrideWithBuild` - A way to mock only `Notifier.build`, without mocking the whole notifier.
    * `Future/StreamProvider.overrideWithValue` - The old utilities are back
    * `WidgetTester.container` - A helper method to obtain the `ProviderContainer` inside widget tests
  * Statically safe scoping - New lint rules are added to detect when an override is missing
## Offline persistence (experimental)​")
This feature is experimental and not yet stable. It is usable, but the API may change in breaking ways without a major version bump.
Offline persistence is a new feature that enables caching a provider locally on the device. Then, when the application is closed and reopened, the provider can be restored from the cache.  
Offline persistence is opt-in, and supported by all "Notifier" providers, and regardless of if you use code generation or not.
Riverpod only includes interfaces to interact with a database. It does not include a database itself. You can use any database you want, as long as it implements the interfaces.  
An official package for SQLite is maintained: riverpod_sqflite.
As a short demo, here's how you can use offline persistence: 
  * riverpod
  * riverpod_generator
```
// A example showcasing JsonSqFliteStorage without code generation.  
final storageProvider =FutureProvider((ref)async{  
// Initialize SQFlite. We should share the Storage instance between providers.  
returnJsonSqFliteStorage.open(  
join(awaitgetDatabasesPath(),'riverpod.db'),  
);  
});  
/// A serializable Todo class.  
classTodo{  
constTodo({  
    required this.id,  
    required this.description,  
    required this.completed,  
});  
Todo.fromJson(Map json)  
: id = json['id']as int,  
        description = json['description']asString,  
        completed = json['completed']as bool;  
final int id;  
finalString description;  
final bool completed;  
MaptoJson(){  
return{  
'id': id,  
'description': description,  
'completed': completed,  
};  
}  
}  
final todosProvider =  
AsyncNotifierProvider>(TodosNotifier.new);  
classTodosNotifierextendsAsyncNotifier>{  
@override  
FutureOr>build()async{  
// We call persist at the start of our 'build' method.  
// This will:  
// - Read the DB and update the state with the persisted value the first  
//   time this method executes.  
// - Listen to changes on this provider and write those changes to the DB.  
persist(  
// We pass our JsonSqFliteStorage instance. No need to "await" the Future.  
// Riverpod will take care of that.  
      ref.watch(storageProvider.future),  
// A unique key for this state.  
// No other provider should use the same key.  
      key:'todos',  
// By default, state is cached offline only for 2 days.  
// We can optionally uncomment the following line to change cache duration.  
// options: const StorageOptions(cacheTime: StorageCacheTime.unsafe_forever),  
      encode: jsonEncode,  
      decode:(json){  
final decoded =jsonDecode(json)asList;  
return decoded  
.map((e)=>Todo.fromJson(e asMap))  
.toList();  
},  
);  
// We asynchronously fetch todos from the server.  
// During the await, the persisted todo list will be available.  
// After the network request completes, the server state will take precedence  
// over the persisted state.  
final todos =awaitfetchTodos();  
return todos;  
}  
Futureadd(Todo todo)async{  
// When modifying the state, no need for any extra logic to persist the change.  
// Riverpod will automatically cache the new state and write it to the DB.  
    state =AsyncData([...await future, todo]);  
}  
}  
```
```
@riverpod  
Futurestorage(Ref ref)async{  
// Initialize SQFlite. We should share the Storage instance between providers.  
returnJsonSqFliteStorage.open(  
join(awaitgetDatabasesPath(),'riverpod.db'),  
);  
}  
/// A serializable Todo class. We're using Freezed for simple serialization.  
@freezed  
abstractclassTodowith _$Todo{  
constfactoryTodo({  
    required int id,  
    required String description,  
    required bool completed,  
})= _Todo;  
factoryTodo.fromJson(Map json)=> _$TodoFromJson(json);  
}  
@riverpod  
@JsonPersist()  
classTodosNotifierextends _$TodosNotifier{  
@override  
FutureOr>build()async{  
// We call persist at the start of our 'build' method.  
// This will:  
// - Read the DB and update the state with the persisted value the first  
//   time this method executes.  
// - Listen to changes on this provider and write those changes to the DB.  
persist(  
// We pass our JsonSqFliteStorage instance. No need to "await" the Future.  
// Riverpod will take care of that.  
      ref.watch(storageProvider.future),  
// By default, state is cached offline only for 2 days.  
// We can optionally uncomment the following line to change cache duration.  
// options: const StorageOptions(cacheTime: StorageCacheTime.unsafe_forever),  
);  
// We asynchronously fetch todos from the server.  
// During the await, the persisted todo list will be available.  
// After the network request completes, the server state will take precedence  
// over the persisted state.  
final todos =awaitfetchTodos();  
return todos;  
}  
Futureadd(Todo todo)async{  
// When modifying the state, no need for any extra logic to persist the change.  
// Riverpod will automatically cache the new state and write it to the DB.  
    state =AsyncData([...await future, todo]);  
}  
}  
```
## Mutations (experimental)​")
This feature is experimental and not yet stable. It is usable, but the API may change in breaking ways without a major version bump.
A new feature called "mutations" is introduced in Riverpod 3.0.  
This feature solves two problems:
  * It empowers the UI to react to "side-effects" (such as form submissions, button clicks, etc), to enable it to show loading/success/error messages. Think "Show a toast when a form is submitted successfully".
  * It solves an issue where `onPressed` callbacks combined with Ref.read and Automatic disposal could cause providers to be disposed while a side-effect is still in progress.
The TL;DR is, a new Mutation object is added. It is declared as a top-level final variable, like providers:
```
final addTodoMutation =Mutation();  
```
After that, your UI can use `ref.listen`/`ref.watch` to listen to the state of mutations:
```
classAddTodoButtonextendsConsumerWidget{  
@override  
Widgetbuild(BuildContext context,WidgetRef ref){  
// Listen to the status of the "addTodo" side-effect  
final addTodo = ref.watch(addTodoMutation);  
returnswitch(addTodo){  
// No side-effect is in progress  
// Let's show a submit button  
MutationIdle()=>ElevatedButton(  
// Trigger the side-effect on click  
        onPressed:(){  
// TODO see explanation after the code snippet  
},  
        child:constText('Submit'),  
),  
// The side-effect is in progress. We show a spinner  
MutationPending()=>constCircularProgressIndicator(),  
// The side-effect failed. We show a retry button  
MutationError()=>ElevatedButton(  
        onPressed:(){  
// TODO see explanation after the code snippet  
},  
        child:constText('Retry'),  
),  
// The side-effect was successful. We show a success message  
MutationSuccess()=>constText('Todo added!'),  
};  
}  
}  
```
Last but not least, inside our `onPressed` callback, we can trigger our side-effect as followed:
```
onPressed:(){  
  addTodoMutation.run(ref,(tsx)async{  
// This is where we run our side-effect.  
// Here, we typically obtain a Notifier and call a method on it.  
await tsx.get(todoListProvider.notifier).addTodo('New Todo');  
});  
}  
```
Note how we called tsx.get here instead of Ref.read.  
This is a feature unique to mutations. That tsx.get obtains the state of a provider, but keep it alive until the mutation is completed.
## Automatic retry​
Starting 3.0, providers that fail during initialization will automatically retry. The retry is done with an exponential backoff, and the provider will be retried until it succeeds or is disposed. This helps when an operation fails due to a temporary issue, such as a lack of network connection.
The default behavior retries any error, and starts with a 200ms delay that doubles after each retry up to 6.4 seconds.  
This can be customized for all providers on ProviderContainer/ProviderScope by passing a `retry` parameter:
  * ProviderScope
  * ProviderContainer
```
voidmain(){  
runApp(  
ProviderScope(  
// You can customize the retry logic, such as to skip  
// specific errors or add a limit to the number of retries  
// or change the delay  
      retry:(retryCount, error){  
if(error isSomeSpecificError)returnnull;  
if(retryCount >5)returnnull;  
returnDuration(seconds: retryCount *2);  
},  
      child:MyApp(),  
),  
);  
}  
```
```
voidmain(){  
final container =ProviderContainer(  
// You can customize the retry logic, such as to skip  
// specific errors or add a limit to the number of retries  
// or change the delay  
    retry:(retryCount, error){  
if(error isSomeSpecificError)returnnull;  
if(retryCount >5)returnnull;  
returnDuration(seconds: retryCount *2);  
},  
);  
}  
```
Alternatively, this can be configured on a per-provider basis by passing a `retry` parameter to the provider constructor:
  * riverpod
  * riverpod_generator
```
final todoListProvider =NotifierProvider>(  
TodoList.new,  
  retry:(retryCount, error){  
if(error isSomeSpecificError)returnnull;  
if(retryCount >5)returnnull;  
returnDuration(seconds: retryCount *2);  
},  
);  
```
```
Durationretry(int retryCount,Object error){  
if(error isSomeSpecificError)returnnull;  
if(retryCount >5)returnnull;  
returnDuration(seconds: retryCount *2);  
}  
@Riverpod(retry: retry)  
classTodoListextends _$TodoList{  
@override  
Listbuild()=>[];  
}  
```
##  `Ref.mounted`​
The long-awaited `Ref.mounted` is finally here! It is similar to `BuildContext.mounted`, but for `Ref`.
You can use it to check if a provider is still mounted after an async operation:
  * riverpod
  * riverpod_generator
```
classTodoListextendsNotifier>{  
@override  
Listbuild()=>[];  
FutureaddTodo(String title)async{  
// Post the new todo to the server  
final newTodo =await api.addTodo(title);  
// Check if the provider is still mounted  
// after the async operation  
if(!ref.mounted)return;  
// If it is, update the state  
    state =[...state, newTodo];  
}  
}  
```
```
@riverpod  
classTodoListextends _$TodoList{  
@override  
Listbuild()=>[];  
FutureaddTodo(String title)async{  
// Post the new todo to the server  
final newTodo =await api.addTodo(title);  
// Check if the provider is still mounted  
// after the async operation  
if(!ref.mounted)return;  
// If it is, update the state  
    state =[...state, newTodo];  
}  
}  
```
For this to work, quite a few life-cycle changes were necessary.  
Make sure to read the life-cycle changes section.
## Generic support (code-generation)​")
When using code generation, you can now define type parameters for your generated providers. Type parameters work like any other provider parameter, and need to be passed when watching the provider.
```
@riverpod  
T multiply(T a,T b){  
return a * b;  
}  
// ...  
int integer = ref.watch(multiplyProvider(2,3));  
double decimal = ref.watch(multiplyProvider(2.5,3.5));  
```
## Pause/Resume support​
In 2.0, Riverpod already had some form of pause/resume support, but it was fairly limited. With 3.0, all `ref.listen` listeners can be manually paused/resumed on demand:
```
final subscription = ref.listen(  
  todoListProvider,  
(previous, next){  
// Do something with the new value  
},  
);  
subscription.pause();  
subscription.resume();  
```
At the same time, Riverpod now pauses providers in various situations:
  * When a provider is no-longer visible, it is paused (Based off TickerMode).
  * When a provider rebuilds, its subscriptions are paused until the rebuild completes.
  * When a provider is paused, all of its subscriptions are paused too.
See the life-cycle changes section for more details.
## Unification of the Public APIs​
One goal of Riverpod 3.0 is to simplify the API. This includes:
  * Highlighting what is recommended and what is not
  * Removing needless interface duplicates
  * Making sure all functionalities function in a consistent way
For this sake, a few changes were made:
### [StateProvider]/[StateNotifierProvider] and [ChangeNotifierProvider] are discouraged and moved to a different import​
Those providers are not removed, but simply moved to a different import. Instead of:
```
import'package:riverpod/riverpod.dart';  
```
You should now use:
```
import'package:riverpod/legacy.dart';  
```
This is to highlight that those providers are not recommended anymore.  
At the same time, those are preserved for backward compatibility.
### AutoDispose interfaces are removed​
No, the "auto-dispose" feature isn't removed. This only concerns the interfaces. In 2.0, all providers, Refs and Notifiers were duplicated for the sake of auto-dispose ( `Ref` vs `AutoDisposeRef`, `Notifier` vs `AutoDisposeNotifier`, etc). This was done for the sake of having a compilation error in some edge-cases, but came at the cost of a worse API.
In 3.0, the interfaces are unified, and the previous compilation error is now implemented as a lint rule (using riverpod_lint). What this means concretely is that you can replace all references to `AutoDisposeNotifier` with `Notifier`. The behavior of your code should not change.
```
final provider = NotifierProvider.autoDispose(  
 MyNotifier.new,  
);  
- class MyNotifier extends AutoDisposeNotifier {  
+ class MyNotifier extends Notifier {  
}  
```
### "FamilyNotifier" and "Notifier" are fused​
Similarly to the previous point, the `FamilyNotifier` and `Notifier` interfaces are now fused.
Long story short, instead of:
```
final provider =NotifierProvider.family(  
MyNotifier.new,  
);  
classCounterNotifierextendsFamilyNotifier{  
@override  
  int build(Argument arg)=>0;  
}  
```
We now do:
```
final provider =NotifierProvider.family(  
CounterNotifier.new,  
);  
classCounterNotifierextendsNotifier{  
CounterNotifier(this.arg);  
finalArgument arg;  
@override  
  int build()=>0;  
}  
```
This means that instead of `Notifier`+`FamilyNotifier`+`AutoDisposeNotifier`+`AutoDisposeFamilyNotifier`, we always use the `Notifier` class.
This change has no impact on code-generation.
### One `Ref` to rule them all​
In Riverpod 2.0, each provider came with its own Ref subclass (`FutureProviderRef`, `StreamProviderRef`, etc).  
Some `Ref` had `state` property, some a `future`, or a `notifier`, etc. Although useful, this was a lot of complexity for not much gain. One of the reasons for that is because Notifiers already have the extra properties it had, so the interfaces were redundant.
In 3.0, `Ref` is unified. No more generic parameter such as `Ref`, no more `FutureProviderRef`. We only have one thing: `Ref`. What this means in practice is, the syntax for generated providers is simplified:
```
-Example example(ExampleRef ref) {  
+Example example(Ref ref) {  
 return Example();  
}  
```
This does not concern WidgetRef, which is intact.  
Ref and WidgetRef are two different things.
### All `updateShouldNotify` now use `==`​
`updateShouldNotify` is a method that is used to determine if a provider should notify its listeners when a state change occurs. But in 2.0, the implementation of this method varied quite a bit between providers. Some providers used `==`, some `identical`, and some more complex logic.
Starting 3.0, all providers use `==` to filter notifications.
This can impact you in a few ways:
  * Some of your providers may not notify their listeners anymore in certain situations.
  * Some listeners may be notified more often than before.
  * If you have a large data class that overrides `==`, you may see a small performance impact.
The most common case where you will be impacted is when using StreamProvider/StreamNotifier, as events of the stream are now filtered using `==`.
If you are impacted by those changes, you can override `updateShouldNotify` to use a custom implementation:
  * riverpod
  * riverpod_generator
```
classTodoListextendsStreamNotifier{  
@override  
Streambuild()=>Stream(...);  
@override  
  bool updateShouldNotify(AsyncValue previous,AsyncValue next){  
// Custom implementation  
returntrue;  
}  
}  
```
```
@riverpod  
classTodoListextends _$TodoList{  
@override  
Streambuild()=>Stream(...);  
@override  
  bool updateShouldNotify(AsyncValue previous,AsyncValue next){  
// Custom implementation  
returntrue;  
}  
}  
```
## Provider life-cycle changes​
### Refs and Notifiers can no-longer be interacted with after they have been disposed​
In 2.0, in some edge-cases you could still interact with things like Ref or Notifier after they were disposed. This was not intended and caused various severe bugs.
In 3.0, Riverpod will throw an error if you try to interact with a disposed Ref/Notifier.
You can use Ref.mounted to check if a Ref/Notifier is still usable.
```
final provider =FutureProvider((ref)async{  
awaitFuture.delayed(Duration(seconds:1));  
// Abort the provider if it has been disposed during the await.  
// You can throw whatever you want and ignore this exception in your error reporting tools.  
if(!ref.mounted)throwMyException();  
return42;  
});  
```
### When reading a provider results in an exception, the error is now wrapped in a ProviderException​
Before, if a provider threw an error, Riverpod would sometimes rethrow that error directly:
  * riverpod
  * riverpod_generator
```
final exampleProvider =FutureProvider((ref)async{  
throwStateError('Error');  
});  
// ...  
ElevatedButton(  
  onPressed:()async{  
// This will rethrow the StateError  
    ref.read(exampleProvider).requireValue;  
// This also rethrows the StateError  
await ref.read(exampleProvider.future);  
},  
  child:Text('Click me'),  
);  
```
```
@riverpod  
Futureexample(Ref ref)async{  
throwStateError('Error');  
}  
// ...  
ElevatedButton(  
  onPressed:()async{  
// This will rethrow the StateError  
    ref.read(exampleProvider).requireValue;  
// This also rethrows the StateError  
await ref.read(exampleProvider.future);  
},  
  child:Text('Click me'),  
);  
```
In 3.0, this is changed. Instead, the error will be encapsulated in a `ProviderException` that contains both the original error and its stack trace.
`AsyncValue.error`, `ref.listen(..., onError: ...)` and ProviderObservers are unaffected by this change, and will still receive the unaltered error.
This has multiple benefits:
  * Debugging is improved, as we have a much better stack trace
  * It is now possible to determine if a provider failed, or if it is in error state because it depends on another provider that failed.
For example, a ProviderObserver can use this to avoid logging the same error twice:
```
classMyObserverextendsProviderObserver{  
@override  
voidproviderDidFail(ProviderObserverContext context,Object error,StackTrace stackTrace){  
if(error isProviderException){  
// The provider didn't fail directly, but instead depends on a failed provider.  
// The error was therefore already logged.  
return;  
}  
// Log the error  
print('Provider failed: $error');  
}  
}  
```
This is used internally by Riverpod in its automatic retry mechanism. The default automatic retry ignores `ProviderException`s:
```
ProviderContainer(  
// Example of the default retry behavior  
  retry:(retryCount, error){  
if(error isProviderException)returnnull;  
// ...  
},  
);  
```
### Listeners inside widgets that are not visible are now paused​
Now that Riverpod has a way to pause listeners, Riverpod uses that to natively pauses listeners when the widget is not visible. In practice what this means is: Providers that are not used by the visible widget tree are paused.
As a concrete example, consider an application with two routes:
  * A home page, listening to a websocket using a provider
  * A settings page, which does not rely on that websocket
In typical applications, a user first opens the home page _and then_ opens the settings page. This means that while the settings page is open, the homepage is also open, but not visible.
In 2.0, the homepage would actively keep listening to the websocket.  
In 3.0, the websocket provider will instead be paused, possibly saving resources.
**How it works:**  
Riverpod relies on TickerMode to determine if a widget is visible or not. And when false, all listeners of a Consumer are paused.
It also means that you can rely on TickerMode yourself to manually control the pause behavior of your consumers. You can voluntarily set the value to true/false to forcibly resume/pause listeners:
```
classMyWidgetextendsStatelessWidget{  
@override  
Widgetbuild(BuildContext context){  
returnTickerMode(  
      enabled:false,// This will pause the listeners  
      child:Consumer(  
        builder:(context, ref, child){  
// This "watch" will be paused  
// until TickerMode is set to true  
final value = ref.watch(myProvider);  
returnText(value.toString());  
},  
),  
);  
}  
}  
```
### If a provider is only used by paused providers, it is paused too​
Riverpod 2.0 already had some form of pause/resume support. But it was limited and failed to cover some edge-cases.  
Consider:
  * riverpod
  * riverpod_generator
```
final exampleProvider =Provider((ref){  
  ref.onCancel(()=>print('paused'));  
  ref.onResume(()=>print('resumed'));  
return0;  
});  
```
```
@riverpod  
int example(Ref ref){  
  ref.keepAlive();  
  ref.onCancel(()=>print('paused'));  
  ref.onResume(()=>print('resumed'));  
return0;  
}  
```
In 2.0, if you were to call `ref.read` once on this provider, the state of the provider would be maintained, but 'paused' will be printed. This is because calling `ref.read` does not "listen" to the provider. And since the provider is not "listened" to, it is paused.
This is useful to pause providers that are currently not used! The problem is that in many cases, this optimization does not work.  
For example, your provider could be used indirectly through another provider.
  * riverpod
  * riverpod_generator
```
final anotherProvider =Provider((ref){  
return ref.watch(exampleProvider);  
});  
classMyWidgetextendsConsumerWidget{  
@override  
Widgetbuild(BuildContext context,WidgetRef ref){  
returnButton(  
      onPressed:(){  
        ref.read(anotherProvider);  
},  
      child:Text('Click me'),  
);  
}  
}  
```
```
@riverpod  
int another(Ref ref){  
  ref.keepAlive();  
return ref.watch(exampleProvider);  
}  
classMyWidgetextendsConsumerWidget{  
@override  
Widgetbuild(BuildContext context,WidgetRef ref){  
returnButton(  
      onPressed:(){  
        ref.read(anotherProvider);  
},  
      child:Text('Click me'),  
);  
}  
}  
```
In this scenario, if we click on the button once, then `anotherProvider` will start listening to our `exampleProvider`. But `anotherProvider` is no-longer used and will be paused. Yet `exampleProvider` will not be paused, because it thinks that it is still being used.  
As such, clicking on the button will not print 'paused' anymore. 
In 3.0, this is fixed. If a provider is only used by paused providers, it is paused too.
### When a provider rebuilds, its previous subscriptions now are kept until the rebuild completes​
In 2.0, there was a known inconvenience when using asynchronous providers combined with 'auto-dispose'.
Specifically, when an asynchronous provider watches an auto-dispose provider after an `await`, the "auto dispose" could be triggered unexpectedly.
Consider: 
  * riverpod
  * riverpod_generator
```
final autoDisposeProvider =StreamProvider.autoDispose((ref){  
  ref.onDispose(()=>print('disposed'));  
  ref.onCancel(()=>print('paused'));  
  ref.onResume(()=>print('resumed'));  
// A stream that emits a value every second  
returnStream.periodic(Duration(seconds:1),(i)=> i);  
});  
final asynchronousExampleProvider =FutureProvider((ref)async{  
print('Before async gap');  
// An async gap inside a provider ; typically an API call.  
// This will dispose the "autoDispose" provider  
// before the async operation is completed  
awaitnull;  
print('after async gap');  
// We listen to our auto-dispose provider  
// after the async operation  
return ref.watch(autoDisposeProvider.future);  
});  
voidmain(){  
final container =ProviderContainer();  
// This will print 'disposed' every second,  
// and will constantly print 0  
  container.listen(asynchronousExampleProvider,(_, value){  
if(value isAsyncData)print('${value.value}\n----');  
});  
}  
```
```
@riverpod  
StreamautoDispose(Ref ref){  
  ref.onDispose(()=>print('disposed'));  
  ref.onCancel(()=>print('paused'));  
  ref.onResume(()=>print('resumed'));  
// A stream that emits a value every second  
returnStream.periodic(Duration(seconds:1),(i)=> i);  
}  
@riverpod  
FutureasynchronousExample(Ref ref)async{  
print('Before async gap');  
// An async gap inside a provider ; typically an API call.  
// This will dispose the "autoDispose" provider  
// before the async operation is completed  
awaitnull;  
print('after async gap');  
// We listen to our auto-dispose provider  
// after the async operation  
return ref.watch(autoDisposeProvider.future);  
}  
voidmain(){  
final container =ProviderContainer();  
// This will print 'disposed' every second,  
// and will constantly print 0  
  container.listen(asynchronousExampleProvider,(_, value){  
if(value isAsyncData)print('${value.value}\n----');  
});  
}  
```
In you run this on Dartpad, you will see that its prints:
```
// First print  
Beforeasync gap  
after async gap  
0  
----// Second and after prints  
paused  
Beforeasync gap  
disposed // The 'autoDispose' provider was disposed during the async gap!  
after async gap  
0  
----  
paused  
Beforeasync gap  
disposed  
after async gap  
0  
----  
...// And so on every second  
```
As you can see, this consistently prints `0` every second, because the `autoDispose` provider repeatedly gets disposed during the async gap. A workaround was to move the `ref.watch` call before the `await` statement. But this is error prone, not very intuitive, and not always possible.
In 3.0, this is fixed by delaying the disposal of listeners.  
When a provider rebuilds, instead of immediately removing all of its listeners, it pauses them.
The exact same code will now instead print:
```
// First print  
Beforeasync gap  
after async gap  
0  
----  
paused  
Beforeasync gap  
after async gap  
resumed  
1  
----  
paused  
Beforeasync gap  
after async gap  
resumed  
2  
----  
...// And so on every second  
```
### Exceptions in providers are rethrown as a `ProviderException`.​
For the sake of differentiating between "a provider failed" from "a provider is depending on a failed provider", Riverpod 3.0 now wraps exceptions in a `ProviderException` that contains the original.
This means that if you catch errors in your providers, you will need to update your try/catch to inspect the content of `ProviderException`:
```
try{  
  ref.watch(failingProvider);  
}onProviderExceptioncatch(e){  
switch(e.exception){  
caseSomeSpecificError():  
// Handle the specific error  
default:  
// Handle other errors  
rethrow;  
}  
}  
```
## New testing utilities​
###  `ProviderContainer.test`​
In 2.0, typical testing code would rely on a custom-made utility called `createContainer`.  
In 3.0, this utility is now part of Riverpod, and is called `ProviderContainer.test`. It creates a new container, and automatically disposes it after the test ends.
```
voidmain(){  
test('My test',(){  
final container =ProviderContainer.test();  
// Use the container  
// ...  
// The container is automatically disposed after the test ends  
});  
}  
```
You can safely do a global search-and-replace for `createContainer` to `ProviderContainer.test`.
###  `NotifierProvider.overrideWithBuild`​
It is now possible to mock only the `Notifier.build` method, without mocking the whole notifier. This is useful when you want to initialize your notifier with a specific state, but still want to use the original implementation of the notifier.
  * riverpod
  * riverpod_generator
```
classMyNotifierextendsNotifier{  
@override  
  int build()=>0;  
voidincrement(){  
    state++;  
}  
}  
final myProvider =NotifierProvider(MyNotifier.new);  
voidmain(){  
final container =ProviderContainer.test(  
    overrides:[  
      myProvider.overrideWithBuild((ref){  
// Mock the build method to start at 42.  
// The "increment" method is unaffected.  
return42;  
}),  
],  
);  
}  
```
```
@riverpod  
classMyNotifierextends _$MyNotifier{  
@override  
  int build()=>0;  
voidincrement(){  
    state++;  
}  
}  
voidmain(){  
final container =ProviderContainer.test(  
    overrides:[  
      myProvider.overrideWithBuild((ref){  
// Mock the build method to start at 42.  
// The "increment" method is unaffected.  
return42;  
}),  
],  
);  
}  
```
###  `Future/StreamProvider.overrideWithValue`​
A while back, `FutureProvider.overrideWithValue` and `StreamProvider.overrideWithValue` were removed "temporarily" from Riverpod.  
They are finally back!
  * riverpod
  * riverpod_generator
```
final myFutureProvider =FutureProvider((ref)async{  
return42;  
});  
voidmain(){  
final container =ProviderContainer.test(  
    overrides:[  
// Initializes the provider with a value.  
// Changing the override will update the value.  
      myFutureProvider.overrideWithValue(AsyncValue.data(42)),  
],  
);  
}  
```
```
@riverpod  
FuturemyFutureProvider()async{  
return42;  
}  
voidmain(){  
final container =ProviderContainer.test(  
    overrides:[  
// Initializes the provider with a value.  
// Changing the override will update the value.  
      myFutureProvider.overrideWithValue(AsyncValue.data(42)),  
],  
);  
}  
```
###  `WidgetTester.container`​
A simple way to access the `ProviderContainer` in your widget tree.
```
voidmain(){  
testWidgets('can access a ProviderContainer',(tester)async{  
await tester.pumpWidget(constProviderScope(child:MyWidget()));  
ProviderContainer container = tester.container();  
});  
}  
```
See the WidgetTester.container extension for more information.
## Custom ProviderListenables​
It is now possible to create custom ProviderListenables in Riverpod 3.0. This is doable using SyncProviderTransformerMixin.
The following example implements a variable of `provider.select`, where the callback returns a boolean instead of the selected value.
```
finalclassWherewithSyncProviderTransformerMixin{  
Where(this.source,this.where);  
@override  
finalProviderListenable source;  
final bool Function(T previous,T value) where;  
@override  
ProviderTransformertransform(  
ProviderTransformerContext context,  
){  
returnProviderTransformer(  
       initState:(_)=> context.sourceState.requireValue,  
       listener:(self, previous, next){  
if(where(previous, next))  
           self.state = next;  
},  
);  
}  
}  
extensiononProviderListenable{  
ProviderListenablewhere(  
    bool Function(T previous,T value) where,  
)=>Where(this, where);  
}  
```
Used as `ref.watch(provider.where((previous, value) => value > 0))`.
## Statically safe scoping (code-generation only)​")
Through riverpod_lint, Riverpod now includes a way to detect when scoping is used incorrectly. This lints detects when an override is missing, to avoid runtime errors.
Consider:
```
// A typical "scoped provider"  
@Riverpod(dependencies:[])  
FuturemyFutureProvider()=>throwUnimplementedError();  
```
To use this provider, you have two options.  
If neither of the following options are used, the provider will throw an error at runtime.
  * Override the provider using `ProviderScope` before using it:
```
classMyWidgetextendsStatelessWidget{  
@override  
Widgetbuild(BuildContext context){  
returnProviderScope(  
      overrides:[  
        myFutureProvider.overrideWithValue(AsyncValue.data(42)),  
],  
// A consumer is necessary to access the overridden provider  
      child:Consumer(  
        builder:(context, ref, child){  
// Use the provider  
final value = ref.watch(myFutureProvider);  
returnText(value.toString());  
},  
),  
);  
}  
}  
```
  * Specify `@Dependencies` on whatever uses the scoped provider to indicate that it depends on it.
```
@Dependencies([myFuture])  
classMyWidgetextendsConsumerWidget{  
@override  
Widgetbuild(BuildContext context,WidgetRef ref){  
// Use the provider  
final value = ref.watch(myFutureProvider);  
returnText(value.toString());  
}  
}  
```
After specifying `@Dependencies`, all usages of `MyWidget` will require the same two options as above:
    * Either override the provider using `ProviderScope` before using `MyWidget`
```
voidmain(){  
runApp(  
ProviderScope(  
      overrides:[  
        myFutureProvider.overrideWithValue(AsyncValue.data(42)),  
],  
      child:MyWidget(),  
),  
);  
}  
```
    * Or specify `@Dependencies` on whatever uses `MyWidget` to indicate that it depends on it.
```
@Dependencies([myFuture])  
classMyAppextendsConsumerWidget{  
@override  
Widgetbuild(BuildContext context,WidgetRef ref){  
// MyApp indirectly uses scoped providers through MyWidget  
returnMyWidget();  
}  
}  
```
## Other changes​
### AsyncValue​
AsyncValue received various changes.
  * It is now "sealed". This enables exhaustive pattern matching:
```
AsyncValue value;  
switch(value){  
caseAsyncData():  
print('data');  
caseAsyncError():  
print('error');  
caseAsyncLoading():  
print('loading');  
// No default case needed  
}  
```
  * `valueOrNull` has been renamed to `value`. The old `value` is removed, as its behavior related to errors was odd. To migrate, do a global search-and-replace of `valueOrNull` -> `value`.
  * `AsyncValue.isFromCache` has been added.  
This flag is set when a value is obtained through offline persistence. It enables your UI to differentiate state coming from the database and state from the server.
  * An optional `progress` property is available on `AsyncLoading`. This enables your providers to define the current progress for a request:
    * riverpod
    * riverpod_generator
```
classMyNotifierextendsAsyncNotifier{  
@override  
Futurebuild()async{  
// You can optionally pass a "progress" to AsyncLoading  
    state =AsyncLoading(progress:.0);  
awaitfetchSomething();  
    state =AsyncLoading(progress:0.5);  
returnUser();  
}  
}  
```
```
@riverpod  
classMyNotifierextends _$MyNotifier{  
@override  
Futurebuild()async{  
// You can optionally pass a "progress" to AsyncLoading  
    state =AsyncLoading(progress:.0);  
awaitfetchSomething();  
    state =AsyncLoading(progress:0.5);  
returnUser();  
}  
}  
```
### All Ref listeners now return a way to remove the listener​
It is now possible to "unsubscribe" to the various life-cycles listeners:
  * riverpod
  * riverpod_generator
```
final exampleProvider =FutureProvider((ref){  
// onDispose and other life-cycle listeners return a function  
// to remove the listener.  
final removeListener = ref.onDispose(()=>print('dispose));  
// Simply call the function to remove the listener:  
removeListener();  
// ...  
});  
```
```
@riverpod  
Futureexample(Ref ref){  
// onDispose and other life-cycle listeners return a function  
// to remove the listener.  
final removeListener = ref.onDispose(()=>print('dispose));  
// Simply call the function to remove the listener:  
removeListener();  
// ...  
}  
```
### Weak listeners - listen to a provider without preventing auto-dispose.​
When using `Ref.listen`, you can optionally specify `weak: true`:
  * riverpod
  * riverpod_generator
```
final exampleProvider =FutureProvider((ref){  
  ref.listen(  
    anotherProvider,  
// Specify the flag  
    weak:true,  
(previous, next){},  
);  
// ...  
});  
```
```
@riverpod  
Futureexample(Ref ref){  
  ref.listen(  
    anotherProvider,  
// Specify the flag  
    weak:true,  
(previous, next){},  
);  
// ...  
}  
```
Specifying this flag will tell Riverpod that it can still dispose the listened provider if it stops being used.
This flag is an advanced feature to help with some niche use-cases regarding combining multiple "sources of truth" in a single provider.
[](https://github.com/rrousselGit/riverpod/edit/master/website/docs/whats_new.mdx)
Next Migrating from 2.0 to 3.0
  * Offline persistence (experimental)
  * Mutations (experimental)
  * Automatic retry
  * `Ref.mounted`
  * Generic support (code-generation)
  * Pause/Resume support
  * Unification of the Public APIs
    * StateProvider/StateNotifierProvider and ChangeNotifierProvider are discouraged and moved to a different import
    * AutoDispose interfaces are removed
    * "FamilyNotifier" and "Notifier" are fused
    * One `Ref` to rule them all
    * All `updateShouldNotify` now use `==`
  * Provider life-cycle changes
    * Refs and Notifiers can no-longer be interacted with after they have been disposed
    * When reading a provider results in an exception, the error is now wrapped in a ProviderException
    * Listeners inside widgets that are not visible are now paused
    * If a provider is only used by paused providers, it is paused too
    * When a provider rebuilds, its previous subscriptions now are kept until the rebuild completes
    * Exceptions in providers are rethrown as a `ProviderException`.
  * New testing utilities
    * `ProviderContainer.test`
    * `NotifierProvider.overrideWithBuild`
    * `Future/StreamProvider.overrideWithValue`
    * `WidgetTester.container`
  * Custom ProviderListenables
  * Statically safe scoping (code-generation only)
  * Other changes
    * AsyncValue
    * All Ref listeners now return a way to remove the listener
    * Weak listeners - listen to a provider without preventing auto-dispose.
Docs