# Docs Concepts2 Refs

# Docs Concepts2 Refs
# Docs Concepts2 Refs
**Riverpod**
[](https://riverpod.dev/docs/concepts2/refs)
# Refs
Refs are the primary way to interact with Providers.  
Refs are fairly similar to the `BuildContext` in Flutter, but for providers instead of widgets. A non-exhaustive list of things you can do with a ref:
  * read/observe the state of a provider
  * check if a provider currently is loaded or
  * reset the state of a provider
On top of that, Ref also enables a provider to observe life-cycles about its own state. Think "initState" and "dispose", but for providers. This includes methods such as:
  * onDispose
  * onCancel
  * etc.
## How to obtain a Ref​
Obtaining a Ref depends on where you are in your app.
Providers naturally have access to a Ref. You can find it as parameter of the initializer function, or as a property of Notifier classes.
  * riverpod
  * riverpod_generator
```
final myProvider =Provider((ref){  
// ref is available here  
...  
});  
final myNotifierProvider =NotifierProvider(MyNotifier.new);  
classMyNotifierextendsNotifier{  
@override  
  int build(){  
// this.ref is available anywhere inside notifiers  
    ref.watch(someProvider);  
...  
}  
}  
```
```
@riverpod  
int myProvider(Ref ref){  
// ref is available here  
...  
}  
@riverpod  
classMyNotifierextends _$MyNotifier{  
@override  
  int build(){  
// this.ref is available anywhere inside notifiers  
    ref.watch(someProvider);  
...  
}  
}  
```
To obtain a Ref inside widgets, you need Consumers.
```
Consumer(  
  builder:(context, ref, _){  
// ref is available here  
final value = ref.watch(myProvider);  
returnText('$value');  
},  
);  
```
**I am never inside a widget, nor a provider. How do I get a Ref then?**  
If you are neither inside widgets nor providers, chances are whatever you are using is still loosely connected to a widget/provider.
In that case, simply pass the ref you obtained from your widget/provider to your function/object of choice:
```
voidmyFunction(WidgetRef ref){  
// You can pass the ref around!  
}  
...  
Consumer(  
  builder:(context, ref, _){  
returnElevatedButton(  
      onPressed:()=>myFunction(ref),// Pass the ref to your function  
      child:Text('Click me'),  
);  
},  
);  
```
## Using Refs to interact with providers​
Interactions with providers generally fall under two categories:
  * Listening to a provider's state
  * Modifying a provider's state (e.g., resetting it, updating it, etc.)
### Listening to a provider's state​
Riverpod offers two ways to listen to a provider's state:
  * Ref.watch - This is a "declarative" way of listening to providers.  
It is the most common way to listen to providers, and should be your go to choice.
  * Ref.listen - This is a "manual" way of listening to providers.  
It uses a typical "addListener" style of listening. Powerful, but more complex.
For the following examples, consider a provider that updates every second:
  * riverpod
  * riverpod_generator
```
final tickProvider =NotifierProvider(Tick.new);  
classTickextendsNotifier{  
@override  
  int build(){  
final timer =Timer.periodic(Duration(seconds:1),(_)=> state++);  
    ref.onDispose(timer.cancel);  
return0;  
}  
}  
```
```
@riverpod  
classTickextends _$Tick{  
@override  
  int build(){  
final timer =Timer.periodic(Duration(seconds:1),(_)=> state++);  
    ref.onDispose(timer.cancel);  
return0;  
}  
}  
```
#### Ref.watch​
Ref.watch is Riverpod's defining feature. It enables combining providers together seamlessly, and easily have your UI update when a provider's state changes.
Using Ref.watch is similar to using an `InheritedWidget` in Flutter. In Flutter, when you call `Theme.of(context)`, your widget subscribes to the `Theme` and will rebuild whenever the `Theme` changes. Similarly, when you call `ref.watch(myProvider)`, your widget/provider subscribes to `myProvider`, and will rebuild whenever `myProvider` changes.
The following code shows a Consumers that automatically updates whenever our `Tick` provider updates:
```
Consumer(  
  builder:(context, ref, _){  
final tick = ref.watch(tickProvider);  
returnText('Tick: $tick');  
},  
);  
```
The most interesting part of Ref.watch is that providers can use it too!  
For example, we could create a provider that returns "is tick divisible by 4?":
  * riverpod
  * riverpod_generator
```
final isDivisibleBy4 =Provider((ref){  
final tick = ref.watch(tickProvider);  
return tick %4==0;  
});  
```
```
@riverpod  
bool isDivisibleBy4(Ref ref){  
final tick = ref.watch(tickProvider);  
return tick %4==0;  
}  
```
Then, we could listen to this new provider in our UI instead:
```
Consumer(  
  builder:(context, ref, _){  
final isDivisibleBy4 = ref.watch(isDivisibleBy4Provider);  
returnText('Can tick be divided by 4? ${isDivisibleBy4}');  
},  
);  
```
Now, instead of updating every second, our UI will only update when the boolean value changes. 
#### Ref.listen​
Ref.listen is a more manual way of listening to providers. It is similar to the `addListener` method of `ChangeNotifier`, or the `Stream.listen` method.
This method is useful when you want to perform a side-effect when a provider's state changes, such as
  * Showing a dialog
  * Navigating to a new screen
  * Logging a message
  * etc.
  * riverpod
  * riverpod_generator
```
final exampleProvider =Provider((ref){  
  ref.listen(tickProvider,(previous, next){  
// This is called whenever tickProvider changes  
print('Tick changed from $previous to $next');  
});  
return0;  
});  
```
```
@riverpod  
int example(Ref ref){  
  ref.listen(tickProvider,(previous, next){  
// This is called whenever tickProvider changes  
print('Tick changed from $previous to $next');  
});  
return0;  
}  
```
```
Consumer(  
  builder:(context, ref, _){  
    ref.listen(tickProvider,(previous, next){  
// This is called whenever tickProvider changes  
print('Tick changed from $previous to $next');  
});  
returnText('Listening to tick changes');  
},  
);  
```
It is safe to use WidgetRef.listen inside the `build` method of a widget. This is how the method is designed to be used.  
If you want to listen to providers outside of `build` (such as `State.initState`), use WidgetRef.listenManual instead.
### Resetting a provider's state​
Using Ref.invalidate, you can reset a provider's state.  
This will tell Riverpod to discard the current state and re-evaluate the provider the next time it is read.
The following example will reset the tick to `0`:
```
Consumer(  
  builder:(context, ref, _){  
returnElevatedButton(  
      onPressed:(){  
// Reset the tick provider  
// This will restart the tick from 0  
        ref.invalidate(tickProvider);  
},  
      child:Text('Reset Tick'),  
);  
},  
);  
```
If you need to obtain the new state right after resetting it, you can call Ref.read:
```
ref.invalidate(tickProvider);  
final newTick = ref.read(tickProvider);  
```
Alternatively, you can use Ref.refresh to reset the provider and read its new state in one go:
```
final newTick = ref.refresh(tickProvider);  
```
Both codes are strictly equivalent. Ref.refresh is syntax sugar for Ref.invalidate followed by Ref.read.
### Interacting with the provider's state inside user interactions​
A last use-case is to interact with a provider's state inside button clicks. In this scenario, we do not want to "listen" to the state. For this case, Ref.read exists.
You can safely call Ref.read button clicks to perform work. The following example will print the current tick value when the button is clicked:
```
Consumer(  
  builder:(context, ref, _){  
returnElevatedButton(  
      onPressed:(){  
// Read the current tick value  
final tick = ref.read(tickProvider);  
print('Current tick: $tick');  
},  
      child:Text('Print Tick'),  
);  
},  
);  
```
Do not use Ref.read as a mean to "optimize" your code by avoiding Ref.watch. This will make your code more brittle, as changes in your provider's behavior could cause your UI to be out of sync with the provider's state.
Either use Ref.watch anyway (as the difference is negligible) or use select:
```
Consumer(  
  builder:(context, ref, _){  
// ❌ Don't use "read" as a mean to ignore changes  
final tick = ref.read(tickProvider);  
// ✅ Use "watch" to listen to changes.  
// This shouldn't be a bottle-neck in your apps. Do not over-optimize.  
final tick = ref.watch(tickProvider);  
// ✅ Use "select" to only listen to the specific part of the state you care about  
final isEven = ref.watch(  
      tickProvider.select((tick)=> tick.isEven),  
);  
...  
},  
);  
```
### Listening to life-cycle events​
A provider-specific feature of Ref is the ability to listen to life-cycle events. These events are similar to the `initState`, `dispose`, and other life-cycle methods in Flutter widgets.
Life-cycles listeners are registered using an "addListener" style API. Listeners are methods with a name that starts with `on`, such as onDispose or onCancel.
  * riverpod
  * riverpod_generator
```
final counterProvider =Provider((ref){  
  ref.onDispose((){  
// This is called when the provider is disposed  
print('Counter provider is being disposed');  
});  
return0;  
});  
```
```
@riverpod  
int counter(Ref ref){  
  ref.onDispose((){  
// This is called when the provider is disposed  
print('Counter provider is being disposed');  
});  
return0;  
}  
```
You do not need to "unregister" these listeners.  
Riverpod automatically cleans them up when the provider is reset.
Although if you wish to unregister them manually, you can do so by using the return value of the listener method.
```
final unregister = ref.onDispose((){  
print('This will never be called');  
});  
// This will unregister the "onDispose" listener  
unregister();  
```
[](https://github.com/rrousselGit/riverpod/edit/master/website/docs/concepts2/refs.mdx)
 Automatic disposal
  * How to obtain a Ref
  * Using Refs to interact with providers
    * Listening to a provider's state
    * Resetting a provider's state
    * Interacting with the provider's state inside user interactions
    * Listening to life-cycle events
Docs