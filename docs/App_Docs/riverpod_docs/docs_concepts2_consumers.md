# Docs Concepts2 Consumers

# Docs Concepts2 Consumers
# Docs Concepts2 Consumers
**Riverpod**
[](https://riverpod.dev/docs/concepts2/consumers)
# Consumers
A "Consumer" is a type of widget that bridges the gap between the Widget tree and the Provider tree.
The only real difference between a Consumer and typical widgets is that Consumers get access to a Ref. This enables them to read providers and listen to their changes. See Refs for more information.
Consumers come in a few different flavors, mostly for personal preference. You will find:
  * Consumer, a "builder" widget (similar to FutureBuilder). It allows widgets to interact with providers without having to subclass something other than `StatelessWidget` or `StatefulWidget`.
```
// We subclass StatelessWidget as usual  
classMyWidgetextendsStatelessWidget{  
@override  
Widgetbuild(BuildContext context){  
// A FutureBuilder-like widget  
returnConsumer(  
// The "builder" callback gives us a "ref" parameter  
      builder:(context, ref, _){  
// We can use that "ref" to listen to providers  
final value = ref.watch(myProvider);  
returnText(value.toString());  
},  
);  
}  
}  
```
  * ConsumerWidget, a variant of `StatelessWidget` widget. Instead of subclassing `StatelessWidget`, you subclass `ConsumerWidget`. It will behave the same, besides the fact that `build` receives an extra WidgetRef parameter.
```
// We subclass ConsumerWidget instead of StatelessWidget  
classMyWidgetextendsConsumerWidget{  
// "build" receives an extra parameter  
@override  
Widgetbuild(BuildContext context,WidgetRef ref){  
// We can use that "ref" to listen to providers  
final value = ref.watch(myProvider);  
returnText(value.toString());  
}  
}  
```
  * ConsumerStatefulWidget, a variant of `StatefulWidget` widget.  
Again, instead of subclassing `StatefulWidget`, you subclass `ConsumerStatefulWidget`. And instead of `State`, you subclass ConsumerState. The unique part is that ConsumerState has a `ref` property.
```
// We subclass ConsumerStatefulWidget instead of StatefulWidget  
classMyWidgetextendsConsumerStatefulWidget{  
@override  
ConsumerStatecreateState()=>_MyWidgetState();  
}  
// We subclass ConsumerState instead of State  
class _MyWidgetState extendsConsumerState{  
// A "this.ref" property is available  
@override  
Widgetbuild(BuildContext context){  
// We can use that "ref" to listen to providers  
final value = ref.watch(myProvider);  
returnText(value.toString());  
}  
}  
```
Alternatively, you will find extra consumers in the hooks_riverpod package. Those combine Riverpod consumers with flutter_hooks. If you don't care about hooks, you can ignore them.
### Which one to use?​
The choice of which consumer to use is mostly a matter of personal preference. You could use Consumer for everything. It is a slightly more verbose option than the others. But this is a reasonable price to pay if you do not like how Riverpod hijacks `StatelessWidget` and `StatefulWidget`.
But if you do not have a strong opinion, we recommend using ConsumerWidget (or ConsumerStatefulWidget when you need a `State`).
### Why can't we use `StatelessWidget` + `context.watch`?​
In alternative packages like provider, you can use `context.watch` to listen to providers. This works inside any widget, as long as you have a `BuildContext`. So why isn't this the case in Riverpod?
The reason is that relying purely on `BuildContext` instead of a Ref would prevent the implementation of Riverpod's Automatic disposal in a reliable way. There _are_ tricks to make an implementation that "mostly works" with `BuildContext`. The problem is that there are lots of subtle edge-cases which could silently break the auto-dispose feature.
This would cause memory leaks, but that's not the real issue.  
Automatic disposal is more importantly about stopping the execution of code that is no longer needed. If auto-dispose fails to dispose a provider, then that provider may continuously perform network requests in the background.
Riverpod preferred to not compromise on reliability for the sake of a little convenience.
To alleviate the downsides of having to use ConsumerWidget/ConsumerStatefulWidget instead of `StatelessWidget`/`StatefulWidget`, Riverpod offers various refactors in IDEs like VSCode and Android Studio.
To enable them in your IDE, see Getting started
[](https://github.com/rrousselGit/riverpod/edit/master/website/docs/concepts2/consumers.mdx)
 ProviderContainers/ProviderScopes
  * Which one to use?
  * Why can't we use `StatelessWidget` + `context.watch`?
Docs