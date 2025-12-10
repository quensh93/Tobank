# Docs Concepts About Hooks

# Docs Concepts About Hooks
# Docs Concepts About Hooks
**Riverpod**
[](https://riverpod.dev/docs/concepts/about_hooks)
  * About hooks
# About hooks
This page explains what hooks are and how they are related to Riverpod.
"Hooks" are utilities common from a separate package, independent from Riverpod: flutter_hooks.  
Although flutter_hooks is a completely separate package and does not have anything to do with Riverpod (at least directly), it is common to pair Riverpod and flutter_hooks together.
## Should you use hooks?​
Hooks are a powerful tool, but they are not for everyone.  
If you are a newcomer to Riverpod, **avoid using hooks**.
Although useful, hooks are not necessary for Riverpod.  
You shouldn't start using hooks because of Riverpod. Rather, you should start using hooks because you want to use hooks.
Using hooks is a tradeoff. They can be great for producing robust and reusable code, but they are also a new concept to learn, and they can be confusing at first. Hooks aren't a core Flutter concept. As such, they will feel out of place in Flutter/Dart.
## What are hooks?​
Hooks are functions used inside widgets. They are designed as an alternative to StatefulWidgets, to make logic more reusable and composable.
Hooks are a concept coming from React, and flutter_hooks is merely a port of the React implementation to Flutter.  
As such, yes, hooks may feel a bit out of place in Flutter. Ideally, in the future we would have a solution to the problem that hooks solves, designed specifically for Flutter.
If Riverpod's providers are for "global" application state, hooks are for local widget state. Hooks are typically used for dealing with stateful UI objects, such as TextEditingController, AnimationController.  
They can also serve as a replacement to the "builder" pattern, replacing widgets such as FutureBuilder/TweenAnimatedBuilder by an alternative that does not involve "nesting" – drastically improving readability.
In general, hooks are helpful for:
  * Reacting to user events
  * etc.
As an example, we could use hooks to manually implement a fade-in animation, where a widget starts invisible and slowly appears.
If we were to use StatefulWidget, the code would look like this:
```
classFadeInextendsStatefulWidget{  
constFadeIn({Key? key, required this.child}):super(key: key);  
finalWidget child;  
@override  
StatecreateState()=>_FadeInState();  
}  
class _FadeInState extendsStatewithSingleTickerProviderStateMixin{  
  late finalAnimationController animationController =AnimationController(  
    vsync:this,  
    duration:constDuration(seconds:2),  
);  
@override  
voidinitState(){  
super.initState();  
    animationController.forward();  
}  
@override  
voiddispose(){  
    animationController.dispose();  
super.dispose();  
}  
@override  
Widgetbuild(BuildContext context){  
returnAnimatedBuilder(  
      animation: animationController,  
      builder:(context, child){  
returnOpacity(  
          opacity: animationController.value,  
          child: widget.child,  
);  
},  
);  
}  
}  
```
Using hooks, the equivalent would be:
```
classFadeInextendsHookWidget{  
constFadeIn({Key? key, required this.child}):super(key: key);  
finalWidget child;  
@override  
Widgetbuild(BuildContext context){  
// Create an AnimationController. The controller will automatically be  
// disposed when the widget is unmounted.  
final animationController =useAnimationController(  
      duration:constDuration(seconds:2),  
);  
// useEffect is the equivalent of initState + didUpdateWidget + dispose.  
// The callback passed to useEffect is executed the first time the hook is  
// invoked, and then whenever the list passed as second parameter changes.  
// Since we pass an empty const list here, that's strictly equivalent to `initState`.  
useEffect((){  
// start the animation when the widget is first rendered.  
      animationController.forward();  
// We could optionally return some "dispose" logic here  
returnnull;  
},const[]);  
// Tell Flutter to rebuild this widget when the animation updates.  
// This is equivalent to AnimatedBuilder  
useAnimation(animationController);  
returnOpacity(  
      opacity: animationController.value,  
      child: child,  
);  
}  
}  
```
There are a few interesting things to note in this code:
  * There is no memory leak. This code does not recreate a new `AnimationController` whenever the widget rebuilds, and the controller is correctly released when the widget is unmounted.
  * It is possible to use hooks as many time as we want within the same widget. As such, we can create multiple `AnimationController` if we want:
```
@override  
Widgetbuild(BuildContext context){  
final animationController =useAnimationController(  
    duration:constDuration(seconds:2),  
);  
final anotherController =useAnimationController(  
    duration:constDuration(seconds:2),  
);  
...  
}  
```
This creates two controllers, without any sort of negative consequence.
  * If we wanted, we could refactor this logic into a separate reusable function:
```
double useFadeIn(){  
final animationController =useAnimationController(  
    duration:constDuration(seconds:2),  
);  
useEffect((){  
    animationController.forward();  
returnnull;  
},const[]);  
useAnimation(animationController);  
return animationController.value;  
}  
```
We could then use this function inside our widgets, as long as that widget is a HookWidget:
```
classFadeInextendsHookWidget{  
constFadeIn({Key? key, required this.child}):super(key: key);  
finalWidget child;  
@override  
Widgetbuild(BuildContext context){  
final fade =useFadeIn();  
returnOpacity(opacity: fade, child: child);  
}  
}  
```
Note how our `useFadeIn` function is completely independent from our `FadeIn` widget.  
If we wanted, we could use that `useFadeIn` function in a completely different widget, and it would still work!
## The rules of hooks​
Hooks comes with unique constraints:
  * They can only be used within the `build` method of a widget that extends HookWidget:
**Good** :
```
classExampleextendsHookWidget{  
@override  
Widgetbuild(BuildContext context){  
final controller =useAnimationController();  
...  
}  
}  
```
**Bad** :
```
// Not a HookWidget  
classExampleextendsStatelessWidget{  
@override  
Widgetbuild(BuildContext context){  
final controller =useAnimationController();  
...  
}  
}  
```
**Bad** :
```
classExampleextendsHookWidget{  
@override  
Widgetbuild(BuildContext context){  
returnElevatedButton(  
      onPressed:(){  
// Not _actually_ inside the "build" method, but instead inside  
// a user interaction lifecycle (here "on pressed").  
final controller =useAnimationController();  
},  
      child:Text('click me'),  
);  
}  
}  
```
  * They cannot be used conditionally or in a loop.
**Bad** :
```
classExampleextendsHookWidget{  
constExample({required this.condition,super.key});  
final bool condition;  
@override  
Widgetbuild(BuildContext context){  
if(condition){  
// Hooks should not be used inside "if"s/"for"s, ...  
final controller =useAnimationController();  
}  
...  
}  
}  
```
For more information about hooks, see flutter_hooks.
## Hooks and Riverpod​
### Installation​
Since hooks are independent from Riverpod, it is necessary to install hooks separately. If you want to use them, installing hooks_riverpod is not enough. You will still need to add flutter_hooks to your dependencies. See Getting started) for more information.
### Usage​
In some cases, you may want to write a Widget that uses both hooks and Riverpod. But as you may have already noticed, both hooks and Riverpod provide their own custom widget base type: HookWidget and ConsumerWidget.  
But classes can only extend one superclass at a time.
To solve this problem, you can use the hooks_riverpod package. This package provides a HookConsumerWidget class that combines both HookWidget and ConsumerWidget into a single type.  
You can therefore subclass HookConsumerWidget instead of HookWidget:
```
// We extend HookConsumerWidget instead of HookWidget  
classExampleextendsHookConsumerWidget{  
@override  
Widgetbuild(BuildContext context,WidgetRef ref){  
// We can use both hooks and providers here  
final counter =useState(0);  
final value = ref.watch(myProvider);  
returnText('Hello $counter$value');  
}  
}  
```
Alternatively, you can use the "builders" provided by both packages.  
For example, we could stick to using `StatelessWidget`, and use both `HookBuilder` and `Consumer`.
```
classExampleextendsStatelessWidget{  
@override  
Widgetbuild(BuildContext context){  
// We can use the builders provided by both packages  
returnConsumer(  
      builder:(context, ref, child){  
returnHookBuilder(builder:(context){  
final counter =useState(0);  
final value = ref.watch(myProvider);  
returnText('Hello $counter$value');  
},);  
},  
);  
}  
}  
```
This approach would work without using hooks_riverpod. Only flutter_riverpod is needed.
If you like this approach, hooks_riverpod streamlines it by providing HookConsumer, which is the combination of both builders in one:
```
classExampleextendsStatelessWidget{  
@override  
Widgetbuild(BuildContext context){  
// Equivalent to using both Consumer and HookBuilder.  
returnHookConsumer(  
      builder:(context, ref, child){  
final counter =useState(0);  
final value = ref.watch(myProvider);  
returnText('Hello $counter$value');  
},  
);  
}  
}  
```
[](https://github.com/rrousselGit/riverpod/edit/master/website/docs/concepts/about_hooks.mdx)
 Testing your providers
  * Should you use hooks?
  * What are hooks?
  * The rules of hooks
  * Hooks and Riverpod
Docs