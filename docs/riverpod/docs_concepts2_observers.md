# Docs Concepts2 Observers

# Docs Concepts2 Observers
# Docs Concepts2 Observers
**Riverpod**
[](https://riverpod.dev/docs/concepts2/observers)
  * ProviderObservers
# ProviderObservers
A ProviderObserver is an object used to observe provider lifecycle events in the application. They are generally used for logging, analytics, or debugging purposes. 
## Usage​
To use a ProviderObserver, you need to extend the class and override the life-cycles you want to observe. There are many methods available. It is recommended to check its documentation for more details.
## Example: Logger​
The following observer logs all state changes of any provider in the application:
```
// A basic logger, which logs any state changes.  
finalclassLoggerextendsProviderObserver{  
@override  
voiddidUpdateProvider(  
ProviderObserverContext context,  
Object? previousValue,  
Object? newValue,  
){  
print('''  
{  
  "provider": "${context.provider}",  
  "newValue": "$newValue",  
  "mutation": "${context.mutation}"  
}''');  
}  
}  
voidmain(){  
runApp(  
ProviderScope(  
// ProviderObservers are used by passing them to ProviderScope/ProviderContainer  
      observers:[  
// Adding ProviderScope enables Riverpod for the entire project  
// Adding our Logger to the list of observers  
Logger(),  
],  
      child:constMyApp(),  
),  
);  
}  
// After this, implement a typical Flutter application  
```
Now, every time the value of our provider is updated, the logger will log it:
```
{  
"provider":"Provider",  
"newValue":"1"  
}  
```
To improve debugging, you can optionally give your providers a name: 
```
final myProvider =Provider((ref)=>0, name:'MyProvider');  
```
With this change, the log becomes:
```
{  
"provider":"MyProvider",  
"newValue":"1"  
}  
```
When using code-generation, a name is automatically assigned to providers.
If the state of a provider is mutated, (typically Lists, combined with Ref.notifyListeners), it is likely that `didUpdateProvider` will receive `previousValue` and `newValue` as the same value.
This happens because Dart updates objects by "reference". If you want to change this, you will have to clone your objects before mutating them.
[](https://github.com/rrousselGit/riverpod/edit/master/website/docs/concepts2/observers.mdx)
 Provider overrides
  * Example: Logger
Docs