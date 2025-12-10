# Docs Concepts2 Scoping

# Docs Concepts2 Scoping
# Docs Concepts2 Scoping
**Riverpod**
[](https://riverpod.dev/docs/concepts2/scoping)
Search
  * Scoping providers
# Scoping providers
Scoping is the act of changing the behavior of a provider for only a small part of your application.
This is useful for:
  * Page/Widget-specific customization (e.g changing the theme of your app for one specific page)
  * Performance optimization (e.g rebuilding only the item that changes in a `ListView`)
  * Avoiding having to pass parameters around (such as for Family)
Scoping is achieved using Provider overrides, by overriding a provider in ProviderContainers/ProviderScopes that are _not_ the root of your application.
The scoping feature is highly complex and will likely be reworked in the future to be more ergonomic. 
Thread carefully.
## Defining a scoped provider​
By default, Riverpod will not allow you to scope a provider. You need to opt-in to this feature by specifying `dependencies` on the provider.
The first scoped provider in your app will typically specify `dependencies: []`.  
The following snippet defines a scoped provider that exposes the current item ID that is being displayed:
  * riverpod
  * riverpod_generator
```
final currentItemIdProvider =Provider(  
  dependencies:const[],  
(ref)=>null,  
);  
```
```
@Riverpod(dependencies:[])  
String?currentItemId(Ref ref)=>null;  
```
## Listening to a scoped provider​
To listen to a scoped provider, use the provider as usual by obtaining Refs, (such as with Consumers).
```
final currentItemId = ref.watch(currentItemIdProvider);  
```
If a provider is listening to a scoped provider, that scoped provider needs to be included in the `dependencies` of the provider that is listening to it:
  * riverpod
  * riverpod_generator
```
final currentItemProvider =FutureProvider(  
  dependencies:[currentItemIdProvider],  
(ref)async{  
final currentItemId = ref.watch(currentItemIdProvider);  
if(currentItemId ==null)returnnull;  
// Fetch the item from a database or API  
returnfetchItem(id: currentItemId);  
});  
```
```
@Riverpod(dependencies:[currentItemId])  
FuturecurrentItem(Ref ref)async{  
final currentItemId = ref.watch(currentItemIdProvider);  
if(currentItemId ==null)returnnull;  
// Fetch the item from a database or API  
returnfetchItem(id: currentItemId);  
}  
```
Inside `dependencies`, you only need to list scoped providers. You do not need to list providers that are not scoped.
## Setting the value of a scoped provider​
To set a scoped provider, you can use Provider overrides. A typical example is to specify `overrides` on ProviderScope like so:
```
classHomePageextendsStatelessWidget{  
constHomePage({super.key});  
@override  
Widgetbuild(BuildContext context){  
returnProviderScope(  
      overrides:[  
        currentItemIdProvider.overrideWithValue('123'),  
],  
// The detail page will rely on '123' as the current item ID, without  
// having to pass it explicitly.  
      child:constDetailPageView(),  
);  
}  
}  
```
[](https://github.com/rrousselGit/riverpod/edit/master/website/docs/concepts2/scoping.mdx)
 About code generation
  * Defining a scoped provider
  * Listening to a scoped provider
  * Setting the value of a scoped provider
Docs