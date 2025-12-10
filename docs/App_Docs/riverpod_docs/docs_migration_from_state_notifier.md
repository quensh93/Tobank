# Docs Migration From State Notifier

# Docs Migration From State Notifier
# Docs Migration From State Notifier
**Riverpod**
[](https://riverpod.dev/docs/migration/from_state_notifier)
Search
  * From `StateNotifier`
# From `StateNotifier`
Along with Riverpod 2.0, new classes were introduced: `Notifier` / `AsyncNotifier`. `StateNotifier` is now discouraged in favor of those new APIs.
This page shows how to migrate from the deprecated `StateNotifier` to the new APIs.
The main benefit introduced by `AsyncNotifier` is a better `async` support; indeed, `AsyncNotifier` can be thought as a `FutureProvider` which can expose ways to be modified from the UI.
Furthermore, the new `(Async)Notifier`s:
  * Expose a `Ref` object inside its class
  * Offer similar syntax between codegen and non-codegen approaches
  * Offer similar syntax between their sync and async versions
  * Move away logic from Providers and centralize it into the Notifiers themselves
Let's see how to define a `Notifier`, how it compares with `StateNotifier` and how to migrate the new `AsyncNotifier` for asynchronous state.
## New syntax comparison​
Be sure to know how to define a `Notifier` before diving into this comparison. See Providers.
Let's write an example, using the old `StateNotifier` syntax:
```
classCounterNotifierextendsStateNotifier{  
CounterNotifier():super(0);  
voidincrement()=> state++;  
voiddecrement()=> state--;  
}  
final counterNotifierProvider =  
StateNotifierProvider((ref){  
returnCounterNotifier();  
});  
```