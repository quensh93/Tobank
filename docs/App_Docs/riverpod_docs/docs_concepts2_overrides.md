# Docs Concepts2 Overrides

# Docs Concepts2 Overrides
# Docs Concepts2 Overrides
**Riverpod**
[](https://riverpod.dev/docs/concepts2/overrides)
  * Provider overrides
# Provider overrides
In Riverpod, _all_ providers can be overridden to change their behavior. This is useful for testing, debugging, or providing different implementations in different environments, or even Scoping providers.
Overriding a provider is done on ProviderContainers/ProviderScopes, using the `overrides` parameter. In it, you can specify a list of instructions on how to override a specific provider.
Such "instruction" is created using your provider, combined with value methods named `overrideWithSomething`.  
There are a bunch of these methods available, but all of them have their name starting with `overrideWith`. This includes:
  * overrideWith
  * overrideWithValue
  * overrideWithBuild
A typical override looks like this:
  * ProviderScope
  * ProviderContainer
```
voidmain(){  
runApp(  
ProviderScope(  
      overrides:[  
// Your overrides are defined here.  
// The following shows how to override a "counter provider"  
// to use a different initial value.  
        counterProvider.overrideWith((ref)=>42),  
]  
)  
);  
}  
```
```
final container =ProviderContainer(  
  overrides:[  
// Your overrides are defined here.  
// The following shows how to override a "counter provider"  
// to use a different initial value.  
    counterProvider.overrideWith((ref)=>42),  
]  
);  
```
[](https://github.com/rrousselGit/riverpod/edit/master/website/docs/concepts2/overrides.mdx)
 Scoping providers
Docs