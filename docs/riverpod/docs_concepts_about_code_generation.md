# Docs Concepts About Code Generation

# Docs Concepts About Code Generation
# Docs Concepts About Code Generation
**Riverpod**
[](https://riverpod.dev/docs/concepts/about_code_generation)
  * About code generation
# About code generation
Code generation is the idea of using a tool to generate code for us. In Dart, it comes with the downside of requiring an extra step to "compile" an application. Although this problem may be solved in the near future, as the Dart team is working on a potential solution to this problem.
In the context of Riverpod, code generation is about slightly changing the syntax for defining a "provider". For example, instead of:
```
final fetchUserProvider =FutureProvider.autoDispose.family((ref, userId)async{  
final json =await http.get('api/user/$userId');  
returnUser.fromJson(json);  
});  
```
Using code generation, we would write:
```
@riverpod  
FuturefetchUser(Ref ref,{required int userId})async{  
final json =await http.get('api/user/$userId');  
returnUser.fromJson(json);  
}  
```
When using Riverpod, code generation is completely optional. It is entirely possible to use Riverpod without. At the same time, Riverpod embraces code generation and recommends using it.
For information on how to install and use Riverpod's code generator, refer to the Getting started page. Make sure to enable code generation in the documentation's sidebar.
## Should I use code generation?​
Code generation is optional in Riverpod. With that in mind, you may wonder if you should use it or not.
The answer is: **Only if you already use code-generation for other things**. (cf Freezed, json_serializable, etc.)  
When the Dart team was working on a feature called "macros", using code generation was the recommended way to use Riverpod. Unfortunately, those have been cancelled.
While code-generation brings many benefits, it currently is still fairly slow. The Dart team is working on improving the performance of code generation, but it is unclear when that will be available and how much it will improve. As such, if you are not already using code generation in your project, it is probably not worth it to start using it just for Riverpod.
At the same time, many applications already use code generation with packages such as Freezed or json_serializable. In that case, your project probably is already set up for code generation, and using Riverpod should be simple.
## What are the benefits of using code generation?​
You may be wondering: "If code generation is optional in Riverpod, why use it?"
As always with packages: To make your life easier. This includes but is not limited to:
  * Better syntax, more readable/flexible, and with a reduced learning curve.
    * No need to worry about the type of provider. Write your logic, and Riverpod will pick the most suitable provider for you.
    * The syntax no longer looks like we're defining a "dirty global variable". Instead we are defining a custom function/class.
    * Passing parameters to providers is now unrestricted. Instead of being limited to using Family and passing a single positional parameter, you can now pass any parameter. This includes named parameters, optional ones, and even default values.
  * **Stateful hot-reload** of the code written in Riverpod.
  * Better debugging, through the generation of extra metadata that the debugger then picks up.
## The Syntax​
### Defining a provider:​
When defining a provider using code generation, it is helpful to keep in mind the following points:
  * Providers can be defined either as an annotated function or as an annotated class. They are pretty much the same, but Class-based provider has the advantage of including public methods that enable external objects to modify the state of the provider (side-effects). Functional providers are syntax sugar for writing a Class-based provider with nothing but a `build` method, and as such cannot be modified by the UI.
  * All Dart async primitives (Future, FutureOr, and Stream) are supported.
  * When a function is marked as async, the provider automatically handles errors/loading states and exposes an AsyncValue.
|  Functional  
(Can’t perform side-effects  
using public methods) |  Class-Based  
(Can perform side-effects  
using public methods)  
---|---|---  
Sync | ```
@riverpod  
Stringexample(Ref ref){  
return'foo';  
}  
```
| ```
@riverpod  
classExampleextends _$Example{  
@override  
Stringbuild(){  
return'foo';  
}  
// Add methods to mutate the state  
}  
```
Async - Future | ```
@riverpod  
Futureexample(Ref ref)async{  
returnFuture.value('foo');  
}  
```
| ```
@riverpod  
classExampleextends _$Example{  
@override  
Futurebuild()async{  
returnFuture.value('foo');  
}  
// Add methods to mutate the state  
}  
```
Async - Stream | ```
@riverpod  
Streamexample(Ref ref)async*{  
yield'foo';  
}  
```
| ```
@riverpod  
classExampleextends _$Example{  
@override  
Streambuild()async*{  
yield'foo';  
}  
// Add methods to mutate the state  
}  
```
### Enabling/disable autoDispose:​
When using code generation, providers are autoDispose by default. That means that they will automatically dispose of themselves when there are no listeners attached to them (ref.watch/ref.listen).  
This default setting better aligns with Riverpod's philosophy. Initially with the non-code generation variant, autoDispose was off by default to accommodate users migrating from `package:provider`.
If you want to disable autoDispose, you can do so by passing `keepAlive: true` to the annotation.
```
// AutoDispose provider (keepAlive is false by default)  
@riverpod  
Stringexample1(Ref ref)=>'foo';  
// Non autoDispose provider  
@Riverpod(keepAlive:true)  
Stringexample2(Ref ref)=>'foo';  
```
### Passing parameters to a provider (family):​:")
When using code generation, we no-longer need to rely on the `family` modifier to pass parameters to a provider. Instead, the main function of our provider can accept any number of parameters, including named, optional, or default values.  
Do note however that these parameters should still have a consistent ==. Meaning either the values should be cached, or the parameters should override ==.
Functional | Class-Based  
---|---  
```
@riverpod  
Stringexample(  
Ref ref,  
  int param1,{  
String param2 ='foo',  
}){  
return'Hello $param1 & $param2';  
}  
```
| ```
@riverpod  
classExampleextends _$Example{  
@override  
Stringbuild(  
    int param1,{  
String param2 ='foo',  
}){  
return'Hello $param1 & $param2';  
}  
// Add methods to mutate the state  
}  
```
## Migrate from non-code-generation variant:​
When using non-code-generation variant, it is necessary to manually determine the type of your provider. The following are the corresponding options for transitioning into code-generation variant:
Provider  
---  
Before | ```
final exampleProvider =Provider.autoDispose(  
(ref){  
return'foo';  
},  
);  
```
After | ```
@riverpod  
Stringexample(Ref ref){  
return'foo';  
}  
```
NotifierProvider  
Before | ```
final exampleProvider =NotifierProvider.autoDispose(  
ExampleNotifier.new,  
);  
classExampleNotifierextendsNotifier{  
@override  
Stringbuild(){  
return'foo';  
}  
// Add methods to mutate the state  
}  
```
After | ```
@riverpod  
classExampleextends _$Example{  
@override  
Stringbuild(){  
return'foo';  
}  
// Add methods to mutate the state  
}  
```
FutureProvider  
Before | ```
final exampleProvider =  
FutureProvider.autoDispose((ref)async{  
returnFuture.value('foo');  
});  
```
After | ```
@riverpod  
Futureexample(Ref ref)async{  
returnFuture.value('foo');  
}  
```
StreamProvider  
Before | ```
final exampleProvider =  
StreamProvider.autoDispose((ref)async*{  
yield'foo';  
});  
```
After | ```
@riverpod  
Streamexample(Ref ref)async*{  
yield'foo';  
}  
```
AsyncNotifierProvider  
Before | ```
final exampleProvider =  
AsyncNotifierProvider.autoDispose(  
ExampleNotifier.new,  
);  
classExampleNotifierextendsAsyncNotifier{  
@override  
Futurebuild()async{  
returnFuture.value('foo');  
}  
// Add methods to mutate the state  
}  
```
After | ```
@riverpod  
classExampleextends _$Example{  
@override  
Futurebuild()async{  
returnFuture.value('foo');  
}  
// Add methods to mutate the state  
}  
```
StreamNotifierProvider  
Before | ```
final exampleProvider =  
StreamNotifierProvider.autoDispose((){  
returnExampleNotifier();  
});  
classExampleNotifierextendsStreamNotifier{  
@override  
Streambuild()async*{  
yield'foo';  
}  
// Add methods to mutate the state  
}  
```
After | ```
@riverpod  
classExampleextends _$Example{  
@override  
Streambuild()async*{  
yield'foo';  
}  
// Add methods to mutate the state  
}  
```
[](https://github.com/rrousselGit/riverpod/edit/master/website/docs/concepts/about_code_generation.mdx)
 About hooks
  * Should I use code generation?
  * What are the benefits of using code generation?
  * The Syntax
    * Defining a provider:
    * Enabling/disable autoDispose:
    * Passing parameters to a provider (family):
  * Migrate from non-code-generation variant:
Docs