# Docs Concepts2 Auto Dispose

# Docs Concepts2 Auto Dispose
# Docs Concepts2 Auto Dispose
**Riverpod**
[](https://riverpod.dev/docs/concepts2/auto_dispose)
Search
  * Automatic disposal
# Automatic disposal
In Riverpod, it is possible to tell the framework to automatically destroy resources associated with a provider when it is no longer used.
## Enabling/disabling automatic disposal​
If you're using code-generation, this is enabled by default, and can be opted out in the annotation:
```
// Disable automatic disposal  
@Riverpod(keepAlive:true)  
StringhelloWorld(Ref ref)=>'Hello world!';  
```
If you're not using code-generation, you can enable it by using `isAutoDispose: true` when creating the provider:
```
final helloWorldProvider =Provider(  
// Opt-in to automatic disposal  
  isAutoDispose:true,  
(ref)=>'Hello world!',  
);  
```
Enabling/disabling automatic disposal has no impact on whether or not the state is destroyed when the provider is recomputed.  
The state will always be destroyed when the provider is recomputed.
When providers receive parameters, it is recommended to enable automatic disposal. That is because otherwise, one state per parameter combination will be created, which can lead to memory leaks.
## When is automatic disposal triggered?​
When automatic disposal is enabled, Riverpod will track whether a provider has listeners or not. This happens by tracking Ref.watch/Ref.listen calls (and a few others). 
When that counter reaches zero, the provider is considered "not used", and Ref.onCancel is triggered. At that point, Riverpod waits for one frame (cf. `await null`). If, after that frame, the provider is still not used, then the provider is destroyed and Ref.onDispose will be triggered.
## Reacting to state disposal​
In Riverpod, there are a few built-in ways for state to be destroyed:
  * The provider is no longer used and is in "auto dispose" mode (more on that later). In this case, all associated state with the provider is destroyed.
  * The provider is recomputed, such as with `ref.watch`. In that case, the previous state is disposed, and a new state is created.
In both cases, you may want to execute some logic when that happens.  
This can be achieved with `ref.onDispose`. This method enables registering a listener for whenever the state is destroyed.
For example, you may want to use it to close any active `StreamController`:
  * riverpod
  * riverpod_generator
```
final provider =StreamProvider((ref){  
final controller =StreamController();  
// When the state is destroyed, we close the StreamController.  
  ref.onDispose(controller.close);  
// TO-DO: Push some values in the StreamController  
return controller.stream;  
});  
```
```
@riverpod  
Streamexample(Ref ref){  
final controller =StreamController();  
// When the state is destroyed, we close the StreamController.  
  ref.onDispose(controller.close);  
// TO-DO: Push some values in the StreamController  
return controller.stream;  
}  
```
The callback of `ref.onDispose` must not trigger side-effects. Modifying providers inside `onDispose` could lead to unexpected behavior.
There are other useful life-cycles such as:
  * `ref.onCancel` which is called when the last listener of a provider is removed.
  * `ref.onResume` which is called when a new listener is added after `onCancel` was invoked.
You can call `ref.onDispose` as many times as you wish. Feel free to call it once per disposable object in your provider. This practice makes it easier to spot when we forget to dispose of something.
## Manually forcing the destruction of a provider, using `ref.invalidate`​
Sometimes, you may want to force the destruction of a provider. This can be done by using `ref.invalidate`, which can be called from another provider or a widget.
Using `ref.invalidate` will destroy the current provider state. There are then two possible outcomes:
  * If the provider is listened to, a new state will be created.
  * If the provider is not listened to, the provider will be fully destroyed.
```
classMyWidgetextendsConsumerWidget{  
@override  
Widgetbuild(BuildContext context,WidgetRef ref){  
returnElevatedButton(  
      onPressed:(){  
// On click, destroy the provider.  
        ref.invalidate(someProvider);  
},  
      child:constText('dispose a provider'),  
);  
}  
}  
```
It is possible for providers to invalidate themselves by using `ref.invalidateSelf`. Although in this case, this will always result in a new state being created.
When trying to invalidate a provider which receives parameters, it is possible to either invalidate one specific parameter combination, or all parameter combinations at once:
  * riverpod
  * riverpod_generator
```
final provider =Provider.autoDispose.family((ref, name){  
return'Hello $name';  
});  
// ...  
voidonTap(){  
// Invalidate all possible parameter combinations of this provider.  
  ref.invalidate(provider);  
// Invalidate a specific combination only  
  ref.invalidate(provider('John'));  
}  
```
```
@riverpod  
Stringlabel(Ref ref,String userName){  
return'Hello $userName';  
}  
// ...  
voidonTap(){  
// Invalidate all possible parameter combinations of this provider.  
  ref.invalidate(labelProvider);  
// Invalidate a specific combination only  
  ref.invalidate(labelProvider('John'));  
}  
```
## Fine-tuned disposal with `ref.keepAlive`​
As mentioned above, when automatic disposal is enabled, the state is destroyed when the provider has no listeners for a full frame.
But you may want to have more control over this behavior. For instance, you may want to keep the state of successful network requests, but not cache failed requests.
This can be achieved with `ref.keepAlive`, after enabling automatic disposal. Using it, you can decide _when_ the state stops being automatically disposed.
  * riverpod
  * riverpod_generator
```
final provider =FutureProvider.autoDispose((ref)async{  
final response =await http.get(Uri.parse('https://example.com'));  
// We keep the provider alive only after the request has successfully completed.  
// If the request failed (and threw an exception), then when the provider stops being  
// listened to, the state will be destroyed.  
final link = ref.keepAlive();  
// We can use the `link` to restore the auto-dispose behavior with:  
// link.close();  
return response.body;  
});  
```
```
@riverpod  
Futureexample(Ref ref)async{  
final response =await http.get(Uri.parse('https://example.com'));  
// We keep the provider alive only after the request has successfully completed.  
// If the request failed (and threw an exception), then when the provider stops being  
// listened to, the state will be destroyed.  
  ref.keepAlive();  
// We can use the `link` to restore the auto-dispose behavior with:  
// link.close();  
return response.body;  
}  
```
If the provider is recomputed, automatic disposal will be re-enabled.
It is also possible to use the return value of `ref.keepAlive` to revert to automatic disposal.
## Example: keeping state alive for a specific amount of time​
Currently, Riverpod does not offer a built-in way to keep state alive for a specific amount of time.  
But implementing such a feature is easy and reusable with the tools we've seen so far.
By using a `Timer` + `ref.keepAlive`, we can keep the state alive for a specific amount of time. To make this logic reusable, we could implement it in an extension method:
```
extensionCacheForExtensiononRef{  
/// Keeps the provider alive for [duration].  
voidcacheFor(Duration duration){  
// Immediately prevent the state from getting destroyed.  
final link =keepAlive();  
// After duration has elapsed, we re-enable automatic disposal.  
final timer =Timer(duration, link.close);  
// Optional: when the provider is recomputed (such as with ref.watch),  
// we cancel the pending timer.  
onDispose(timer.cancel);  
}  
}  
```
Then, we can use it like so:
  * riverpod
  * riverpod_generator
```
final provider =FutureProvider.autoDispose((ref)async{  
/// Keeps the state alive for 5 minutes  
  ref.cacheFor(constDuration(minutes:5));  
return http.get(Uri.https('example.com'));  
});  
```
```
@riverpod  
Futureexample(Ref ref)async{  
/// Keeps the state alive for 5 minutes  
  ref.cacheFor(constDuration(minutes:5));  
return http.get(Uri.https('example.com'));  
}  
```
This logic can be tweaked to fit your needs. For example, you could use `ref.onCancel`/`ref.onResume` to destroy the state only if a provider hasn't been listened to for a specific amount of time.
[](https://github.com/rrousselGit/riverpod/edit/master/website/docs/concepts2/auto_dispose.mdx)
 Family
  * Enabling/disabling automatic disposal
  * When is automatic disposal triggered?
  * Reacting to state disposal
  * Manually forcing the destruction of a provider, using `ref.invalidate`
  * Fine-tuned disposal with `ref.keepAlive`
  * Example: keeping state alive for a specific amount of time
Docs