# Docs Concepts2 Family

# Docs Concepts2 Family
# Docs Concepts2 Family
**Riverpod**
[](https://riverpod.dev/docs/concepts2/family)
# Family
One of Riverpod's most powerful feature is called "Families".  
In short, it allows a provider to be associated with multiple independent states, based on a unique parameter combination.
A typical use-case is to fetch data from a remote API, where the response depends on some parameters (such as a user ID or a search query or a page number). It enables defining a single provider that can be used to fetch and cache any possible parameter combination.
If normal providers can be assimilated to a variable, then "family" providers can be assimilated to a Map.
## Creating a Family​
Defining a family is done by slightly modifying the provider definition to receive a parameter.
For functional providers, the syntax is as follows:
  * riverpod
  * riverpod_generator
```
// When not using code-generation, providers can use ".family".  
// This adds one generic parameter corresponding to the type of the parameter.  
// The initialization function then receives the parameter.  
final userProvider =FutureProvider.autoDispose.family((ref, id)async{  
final dio =Dio();  
final response =await dio.get('https://api.example.com/users/$id');  
returnUser.fromJson(response.data);  
});  
```
```
@riverpod  
Futureuser(  
Ref ref,  
// When using code-generation, providers can receive any number of parameters.  
// They can be both positional/named and required/optional.  
String id,  
)async{  
final dio =Dio();  
final response =await dio.get('https://api.example.com/users/$id');  
returnUser.fromJson(response.data);  
}  
```
And for notifier providers, the syntax is:
  * riverpod
  * riverpod_generator
```
// With notifiers providers, we also use ".family" and receive and extra  
// generic argument.  
// The main difference is that the associated Notifier needs to define  
// a constructor+field to accept the argument.  
final userProvider =AsyncNotifierProvider.autoDispose.family(  
UserNotifier.new,  
);  
classUserNotifierextendsAsyncNotifier{  
// We store the argument in a field, so that we can use it  
UserNotifier(this.id);  
finalString id;  
@override  
Futurebuild()async{  
final dio =Dio();  
final response =await dio.get('https://api.example.com/users/$id');  
returnUser.fromJson(response.data);  
}  
}  
```
```
@riverpod  
classUserNotifierextends _$UserNotifier{  
@override  
Futurebuild(  
// When using code-generation, Notifiers can define parameters on their  
// "build" method. Any number of parameter can be defined.  
String id,  
)async{  
final dio =Dio();  
final response =await dio.get('https://api.example.com/users/$id');  
// The generated class will naturally have access to the parameters  
// passed to the "build" method in "this":  
print(this.id);  
returnUser.fromJson(response.data);  
}  
}  
```
Although not strictly required, it is highly advised to enable Automatic disposal when using families.
This avoids memory leaks in case the parameter changes and the previous state is no longer needed.
## Using a Family​
Providers that receive parameters see their usage slightly modified too.
Long story short, you need to pass the parameters that your provider expects, as follows:
```
final user = ref.watch(userProvider('123'));  
```
Parameters passed need to have a consistent `==`/`hashCode`.
View "family" as a Map, where the parameters are the key and the provider's state is the value. As such, if the `==`/`hashCode` of a parameter changes, the value obtained will be different.
Therefore code such as the following is incorrect:
```
// Incorrect parameter, as `[1, 2, 3] != [1, 2, 3]`  
ref.watch(myProvider([1,2,3]));  
```
To help spot this mistake, it is recommended to use the riverpod_lint and enable the provider_parameters lint rule. Then, the previous snippet would show a warning. See Getting started for installation steps.
You can read as many "family" providers as you want, and they will all be independent. As such, it is legal to do:
```
classExampleextendsConsumerWidget{  
@override  
Widgetbuild(BuildContext context,WidgetRef ref){  
final user1 = ref.watch(userProvider('123'));  
final user2 = ref.watch(userProvider('456'));  
// user1 and user2 are independent.  
}  
}  
```
## Overriding families​
When trying to mock a provider in tests, you may want to override a family provider. 
In that scenario, you have two options:
  * Override only a specific parameter combination:
```
await tester.pumpWidget(  
ProviderScope(  
    overrides:[  
userProvider('123').overrideWith((ref)=>User(name:'User 123')),  
],  
    child:constMyApp(),  
),  
);  
```
  * Override all parameter combinations:
```
await tester.pumpWidget(  
ProviderScope(  
    overrides:[  
      userProvider.overrideWith((ref, arg)=>User(name:'User $arg')),  
],  
    child:constMyApp(),  
),  
);  
```
[](https://github.com/rrousselGit/riverpod/edit/master/website/docs/concepts2/family.mdx)
 Mutations (experimental)
  * Creating a Family
  * Using a Family
  * Overriding families
Docs