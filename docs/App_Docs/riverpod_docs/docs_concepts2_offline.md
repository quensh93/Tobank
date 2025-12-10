# Docs Concepts2 Offline

# Docs Concepts2 Offline
# Docs Concepts2 Offline
**Riverpod**
[](https://riverpod.dev/docs/concepts2/offline)
  * Offline persistence (experimental)
# Offline persistence (experimental)
Offline persistence is the ability to store the state of Providers on the user's device, so that it can be accessed even when the user is offline or when the app is restarted.
Riverpod is independent from the underlying database or the protocol used to store the data. But by default, Riverpod provides riverpod_sqflite alongside basic JSON serialization.
Riverpod's offline persistence is designed to be a simple wrapper around databases. It is not designed to fully replace code for interacting with a database.
You may still need to manually interact with a database for:
  * Advanced Database migrations
  * More optimized storage strategies
  * Unusual use-cases
Offline persistence works using two parts:
  1. Storage, an interface to interact with your database. This is typically implemented by a package (such as riverpod_sqflite).
  2. AnyNotifier.persist, a function used inside notifiers to opt-in to persistence.
## Creating a Storage​
Before we start persisting notifiers, we need to instantiate an object that implements the Storage interface. This object will be responsible for connecting Riverpod with your database.
You need have to either:
  * Download a package that provides a way to connect Riverpod with your Database of choice.
  * Manually implement Storage
If using SQFlite, you can use riverpod_sqflite:
```
dart pub add riverpod_sqflite sqflite  
```
Then, you can create a Storage by instantiating JsonSqFliteStorage:
  * riverpod
  * riverpod_generator
```
import'package:flutter_riverpod/experimental/persist.dart';  
import'package:flutter_riverpod/flutter_riverpod.dart';  
import'package:path/path.dart';  
import'package:riverpod_sqflite/riverpod_sqflite.dart';  
import'package:sqflite/sqflite.dart';  
final storageProvider =FutureProvider>((ref)async{  
// Initialize SQFlite. We should share the Storage instance between providers.  
returnJsonSqFliteStorage.open(  
join(awaitgetDatabasesPath(),'riverpod.db'),  
);  
});  
```
```
import'package:flutter_riverpod/experimental/persist.dart';  
import'package:path/path.dart';  
import'package:riverpod_annotation/riverpod_annotation.dart';  
import'package:riverpod_sqflite/riverpod_sqflite.dart';  
import'package:sqflite/sqflite.dart';  
part'codegen.g.dart';  
@riverpod  
Future>storage(Ref ref)async{  
// Initialize SQFlite. We should share the Storage instance between providers.  
returnJsonSqFliteStorage.open(  
join(awaitgetDatabasesPath(),'riverpod.db'),  
);  
}  
```
## Persisting the state of a provider​
Once we've created a Storage, we can start persisting the state of providers.  
Currently, only "Notifiers" can be persisted. See Providers for more information about them.
To persist the state of a notifier, you will typically need to call AnyNotifier.persist inside the `build` method of your notifier.
  * riverpod
  * riverpod_generator
```
classTodo{  
Todo({required this.task});  
finalString task;  
}  
final todoListProvider =AsyncNotifierProvider>(  
TodoList.new,  
);  
classTodoListextendsAsyncNotifier>{  
@override  
Future>build()async{  
persist(  
// We pass in the previously created Storage.  
// Do not "await" this. Riverpod will handle it for you.  
      ref.watch(storageProvider.future),  
// A unique identifier for this state.  
// If your provider receives parameters, make sure to encode those  
// in the key as well.  
      key:'todo_list',  
// Encode/decode the state. Here, we're using a basic JSON encoding.  
// You can use any encoding you want, as long as your Storage supports it.  
      encode:(todos)=> todos.map((todo)=>{'task': todo.task}).toList(),  
      decode:(json)=>(json asList)  
.map((todo)=>Todo(task: todo['task']asString))  
.toList(),  
);  
// Regardless of whether some state was restored or not, we fetch the list of  
// todos from the server.  
returnfetchTodosFromServer();  
}  
}  
```
```
classTodo{  
Todo({required this.task});  
finalString task;  
}  
@riverpod  
classTodoListextends _$TodoList{  
@override  
Future>build()async{  
persist(  
// We pass in the previously created Storage.  
// Do not "await" this. Riverpod will handle it for you.  
      ref.watch(storageProvider.future),  
// A unique identifier for this state.  
// If your provider receives parameters, make sure to encode those  
// in the key as well.  
      key:'todo_list',  
// Encode/decode the state. Here, we're using a basic JSON encoding.  
// You can use any encoding you want, as long as your Storage supports it.  
      encode:(todos)=> todos.map((todo)=>{'task': todo.task}).toList(),  
      decode:(json)=>(json asList)  
.map((todo)=>Todo(task: todo['task']asString))  
.toList(),  
);  
// Regardless of whether some state was restored or not, we fetch the list of  
// todos from the server.  
returnfetchTodosFromServer();  
}  
}  
```
### Using simplified JSON serialization (code-generation)​")
If you are using riverpod_sqflite and code-generation, you can simplify the `persist` call by using the JsonPersist annotation:
```
// Using freezed or json_serializable to generate from/toJson for your objects  
@freezed  
abstractclassTodowith _$Todo{  
constfactoryTodo({required String task})= _Todo;  
factoryTodo.fromJson(Map json)=> _$TodoFromJson(json);  
}  
@riverpod  
// Specify @JsonPersist. This will provide a custom "persist" method for your notifier  
@JsonPersist()  
classTodoListextends _$TodoList{  
@override  
Future>build()async{  
persist(  
// We pass in the previously created Storage.  
// Do not "await" this. Riverpod will handle it for you.  
      ref.watch(storageProvider.future),  
// No need to specify key/encode/decode functions.  
);  
// Initialize the notifier as usual.  
returnfetchTodosFromServer();  
}  
}  
```
## Understanding persist keys​
In some of the previous snippets, we've passed a `key` parameter to AnyNotifier.persist. That key is there to enable your database to know where to store the state of a provider in the Database. Depending on the database, this key may be a unique row ID.
When specifying `key`, it is critical to ensure that:
  * The key is unique across all providers that you persist.  
Failing to do so could cause data corruption, as two providers could be trying to write to the same row in the database. If Riverpod detects two providers using the same key, an assertion will be thrown.
  * The key is stable across app restarts. If the key changes, Riverpod will not be able to restore the state of the provider when the app is restarted, and the provider will be initialized as if it was never persisted
  * The key needs to include any parameter that the provider takes. When using "families" (cf Family), the key needs to include the family parameter.
## Changing the cache duration​
By default, state is only cached for 2 days. This default ensures that no leak happens and deleted providers stay in the database indefinitely
This is generally safe, as Riverpod is designed to be used primarily as a cache for IO operations (network requests, database queries, etc). But such default will not be suitable for all use-cases, such as if you want to store user preferences.
To change this default, specify `options` like so:
```
@override  
Future>build()async{  
persist(  
    ref.watch(storageProvider.future),  
// We tell Riverpod to forever persist the state of this provider.  
    options:constStorageOptions(  
// Instead of "unsafe_forever", you can alternatively specify a Duration.  
      cacheTime:StorageCacheTime.unsafe_forever,  
),  
// ...  
);  
returnfetchTodosFromServer();  
}  
```
If you set the cache duration to infinite, make sure to manually delete the persisted state from the database if you ever delete the provider.
For this, refer to your database's documentation.
## Using "destroy key" for simple data-migration​
A common challenge when persisting data is handling when the data structure changes. If you change how an object is serialized, you may need to migrate the data stored in the database.
While Riverpod does not provide a way to do proper data migration, it does provide a way to easily replace the old persisted state with a brand new one: Destroy keys.
  * riverpod
  * riverpod_generator
```
classTodoListextendsAsyncNotifier>{  
@override  
Future>build()async{  
persist(  
      ref.watch(storageProvider.future),  
// We can optionally pass a "destroyKey". When a new version of the application  
// is release with a different destroyKey, the old persisted state will be  
// deleted, and a brand new state will be created.  
      options:constStorageOptions(destroyKey:'1.0'),  
// Persist as usual  
      key:'todo_list',  
      encode:(todos)=> todos.map((todo)=>{'task': todo.task}).toList(),  
      decode:(json)=>(json asList)  
.map((todo)=>Todo(task: todo['task']asString))  
.toList(),  
);  
returnfetchTodosFromServer();  
}  
}  
```
```
@riverpod  
@JsonPersist()  
classTodoListextends _$TodoList{  
@override  
Future>build()async{  
persist(  
      ref.watch(storageProvider.future),  
// We can optionally pass a "destroyKey". When a new version of the application  
// is release with a different destroyKey, the old persisted state will be  
// deleted, and a brand new state will be created.  
      options:constStorageOptions(destroyKey:'1.0'),  
);  
returnfetchTodosFromServer();  
}  
}  
```
Destroy keys help doing simple data migrations by enabling Riverpod to know when the old persisted state should be discarded. When a new version of the application is released with a different destroyKey, the old persisted state will be discarded, and the provider will be initialized as if it was never persisted.
## Waiting for persistence decoding​
Until now, we've never waited for AnyNotifier.persist to complete.  
This is voluntary, as this allows the provider to start its network requests as soon as possible. However, it means that the provider cannot easily access the persisted state right after calling `persist`.
In some cases, instead of initializing the provider with a network request, you may want to initialize it with the persisted state.
In that case, you can await the result of `persist` as follows:
```
awaitpersist(...).future;  
```
This enables accessing the persisted state within `build` using `this.state`:
```
@override  
Future>build()async{  
// Wait for decoding to complete  
awaitpersist(  
    ref.watch(storageProvider.future),  
// ...  
).future;  
// If any state has been decoded, initialize the provider with it.  
// Otherwise provide a default value.  
return state.value ??[];  
}  
```
## Testing persistence​
When testing your application, it may be inconvenient to use a real database. In particular, unit and widget tests will not have access to a device, and thus cannot use a database.
For this reason, Riverpod provides a way to use an in-memory database using Storage.inMemory.  
To have your test use this in-memory database, you can use Provider overrides:
```
testWidgets('Widget test example',(tester)async{  
await tester.pumpWidget(  
ProviderScope(  
      overrides:[  
// Override the `storageProvider` so that our application  
// uses an in-memory storage.  
        storageProvider.overrideWith((ref){  
// Create an in-memory storage.  
final storage =Storage.inMemory();  
// Initialize it with some data.  
          storage.write(  
'todo_list',  
'{"task": "Eat a cookie"}',  
constStorageOptions(),  
);  
return storage;  
}),  
],  
      child:constMyApp(),  
),  
);  
});  
test('Pure dart example',()async{  
final container =ProviderContainer.test(  
// Same as above, we override the `storageProvider`  
    overrides:[  
      storageProvider.overrideWith(  
(ref)=>Storage.inMemory(),  
),  
],  
);  
// TODO use container to interact with providers by hand.  
});  
```
[](https://github.com/rrousselGit/riverpod/edit/master/website/docs/concepts2/offline.mdx)
 Automatic retry
  * Creating a Storage
  * Persisting the state of a provider
    * Using simplified JSON serialization (code-generation)
  * Understanding persist keys
  * Changing the cache duration
  * Using "destroy key" for simple data-migration
  * Waiting for persistence decoding
  * Testing persistence
Docs