# Docs Concepts2 Mutations

# Docs Concepts2 Mutations
# Docs Concepts2 Mutations
**Riverpod**
[](https://riverpod.dev/docs/concepts2/mutations)
  * Mutations (experimental)
# Mutations (experimental)
Mutations are experimental, and the API may change in a breaking way without a major version bump.
Mutations, in Riverpod, are objects which enable the user interface to react to state changes. A common use-case is displaying a loading indicator while a form is being submitted
In short, mutations are to achieve effects such as this: !
Without mutations, you would have to store the progress of the form submission directly inside the state of a provider. This is not ideal as it pollutes the state of your provider with UI concerns ; and it involves a lot of boilerplate code to handle the loading state, error state, and success state.
Mutations are designed to handle these concerns in a more elegant way.
## Defining a mutation​
Mutations are instances of the Mutation object, stored in a final variable somewhere.
```
// A mutation to track the "add todo" operation.  
// The generic type is optional and can be specified to enable the UI to interact  
// with the result of the mutation.  
final addTodo =Mutation();  
```
Typically, this variable will either be global or as a `static final` variable on a Notifier.
## Listening to a mutation​
Once we've defined a mutation, we can start using it inside Consumers or Providers.  
For this, we will need a Refs and pick a listening method of our choice (typically Ref.watch).
A typical example would be:
```
classExampleextendsConsumerWidget{  
constExample({super.key});  
@override  
Widgetbuild(BuildContext context,WidgetRef ref){  
// We listen to the current state of the "addTodo" mutation.  
// Listening to this will not perform any side effects by itself.  
final addTodoState = ref.watch(addTodo);  
returnRow(  
      children:[  
ElevatedButton(  
          style:ButtonStyle(  
// If there is an error, we show the button in red  
            backgroundColor:switch(addTodoState){  
MutationError()=>constWidgetStatePropertyAll(Colors.red),  
              _ =>null,  
},  
),  
          onPressed:(){  
            addTodo.run(ref,(tsx)async{  
// todo  
});  
},  
          child:constText('Add todo'),  
),  
// The operation is pending, let's show a progress indicator  
if(addTodoState isMutationPending)...[  
constSizedBox(width:8),  
constCircularProgressIndicator(),  
],  
],  
);  
}  
}  
```
### Scoping a mutation​
Sometimes, you may want to have multiple instances of the same mutation.
This can include things like an id, or any other parameter that makes the mutation unique.
This is useful if you want to have multiple instances of the same mutation, such as deleting a specific item in a list
Simply call the mutation with the unique key:
```
final removeTodo =Mutation();  
final removeTodoWithId =removeTodo(todo.id);  
```
Sometimes, these mutations have a generic return type, such as if an api response may have different response types based on the input parameters, such as with deserialization.
```
final create =Mutation();  
final createTodo = create>('create_todo');  
FutureexecuteCreateTodo(MutationTarget ref)async{  
await createTodo.run(ref,(tsx)async{  
final client = tsx.get(apiProvider);  
final response = client.post('/todos', data:{'title':'Eat a cookie'});  
returnCreatedResponse.fromJson(response.data,Todo.fromJson);  
});  
}  
```
### Triggering a mutation​
So far, we've listened to the state of a mutation, but nothing actually happens yet.
To trigger a mutation, we can use Mutation.run, pass our mutation, and provide an asynchronous callback that updates whatever state we want. Lastly, we'll need to return a value matching the generic type of the mutation.
```
returnElevatedButton(  
  onPressed:(){  
// Trigger the mutation, and run the callback.  
// During the callback, we obtain a MutationTransaction (tsx) object  
// which we can use to access providers and perform operations.  
    addTodo.run(ref,(tsx)async{  
// We use tsx.get to access providers within mutations.  
// This will keep the provider alive for the duration of the operation.  
final todoNotifier = tsx.get(todoNotifierProvider.notifier);  
// We perform a request using a Notifier.  
final createdTodo =await todoNotifier.addTodo('Eat a cookie');  
// We return the created todo. This enables our UI to show information  
// about the created todo, such as its ID/creation date/etc.  
return createdTodo;  
});  
},  
  child:constText('Add todo'),  
);  
```
### The different mutation states and their meaning​
Mutations can be in one of the following states:
  * MutationPending: The mutation has started and is currently loading.
  * MutationError: The mutation has failed, and an error is available.
  * MutationSuccess: The mutation has succeeded, and the result is available.
  * MutationIdle: The mutation has not been called yet, or has been reset.
You can switch over the different states using a `switch` statement:
```
switch(addTodoState){  
caseMutationIdle():  
// Show a button to add a todo  
caseMutationPending():  
// Show a loading indicator  
caseMutationError():  
// Show an error message  
caseMutationSuccess():  
// Show the created todo  
}  
```
### After a mutation has been started once, how to reset it to its idle state?​
Mutations naturally reset themselves to MutationIdle if:
  * They have completed (either successfully or with an error).
  * All listeners have been removed (e.g. the spinner widget has been removed)
This is similar to how Automatic disposal works, but for mutations.
Alternatively, you can manually reset a mutation to its idle state by calling the Mutation.reset method:
```
returnElevatedButton(  
  onPressed:(){  
// Reset the mutation to its idle state.  
    addTodo.reset(ref);  
},  
  child:constText('Reset mutation'),  
);  
```
[](https://github.com/rrousselGit/riverpod/edit/master/website/docs/concepts2/mutations.mdx)
 Offline persistence (experimental)
  * Defining a mutation
  * Listening to a mutation
    * Scoping a mutation
    * Triggering a mutation
    * The different mutation states and their meaning
    * After a mutation has been started once, how to reset it to its idle state?
Docs