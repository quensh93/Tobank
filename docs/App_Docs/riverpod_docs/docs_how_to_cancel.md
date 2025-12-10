# Docs How To Cancel

# Docs How To Cancel
# Docs How To Cancel
**Riverpod**
[](https://riverpod.dev/docs/how_to/cancel)
Search
  * How to debounce/cancel network requests
# How to debounce/cancel network requests
As applications grow in complexity, it's common to have multiple network requests in flight at the same time. For example, a user might be typing in a search box and triggering a new request for each keystroke. If the user types quickly, the application might have many requests in flight at the same time.
Alternatively, a user might trigger a request, then navigate to a different page before the request completes. In this case, the application might have a request in flight that is no longer needed.
To optimize performance in those situations, there are a few techniques you can use:
  * "Debouncing" requests. This means that you wait until the user has stopped typing for a certain amount of time before sending the request. This ensures that you only send one request for a given input, even if the user types quickly.
  * "Cancelling" requests. This means that you cancel a request if the user navigates away from the page before the request completes. This ensures that you don't waste time processing a response that the user will never see.
In Riverpod, both of these techniques can be implemented in a similar way. The key is to use `ref.onDispose` combined with "automatic disposal" or `ref.watch` to achieve the desired behavior.
To showcase this, we will make a simple application with two pages:
  * A home screen, with a button which opens a new page
  * A detail page, which displays a random activity from the Bored API, with the ability to refresh the activity.  
See Implementing pull-to-refresh for information on how to implement pull-to-refresh.
We will then implement the following behaviors:
  * If the user opens the detail page and then navigates back immediately, we will cancel the request for the activity.
  * If the user refreshes the activity multiple times in a row, we will debounce the requests so that we only send one request after the user stops refreshing.
## The application​
First, let's create the application, without any debouncing or cancelling.  
We won't use anything fancy here, and stick to a plain `FloatingActionButton` with a `Navigator.push` to open the detail page.
First, let's start with defining our home screen. As usual, let's not forget to specify a `ProviderScope` at the root of our application.
lib/src/main.dart
```
voidmain()=>runApp(constProviderScope(child:MyApp()));  
classMyAppextendsStatelessWidget{  
constMyApp({super.key});  
@override  
Widgetbuild(BuildContext context){  
returnMaterialApp(  
      routes:{  
'/detail-page':(_)=>constDetailPageView(),  
},  
      home:constActivityView(),  
);  
}  
}  
classActivityViewextendsConsumerWidget{  
constActivityView({super.key});  
@override  
Widgetbuild(BuildContext context,WidgetRef ref){  
returnScaffold(  
      appBar:AppBar(title:constText('Home screen')),  
      body:constCenter(  
        child:Text('Click the button to open the detail page'),  
),  
      floatingActionButton:FloatingActionButton(  
        onPressed:()=>Navigator.of(context).pushNamed('/detail-page'),  
        child:constIcon(Icons.add),  
),  
);  
}  
}  
```
Then, let's define our detail page. To fetch the activity and implement pull-to-refresh, refer to the Implementing pull-to-refresh case study.
  * riverpod
  * riverpod_generator
lib/src/detail_screen.dart
```
classActivity{  
Activity({  
    required this.activity,  
    required this.type,  
    required this.participants,  
    required this.price,  
});  
factoryActivity.fromJson(Map json){  
returnActivity(  
      activity: json['activity']!asString,  
      type: json['type']!asString,  
      participants: json['participants']!as int,  
      price: json['price']!as double,  
);  
}  
finalString activity;  
finalString type;  
final int participants;  
final double price;  
}  
final activityProvider =FutureProvider.autoDispose((ref)async{  
final response =await http.get(  
Uri.https('www.boredapi.com','/api/activity'),  
);  
final json =jsonDecode(response.body)asMap;  
returnActivity.fromJson(json);  
});  
classDetailPageViewextendsConsumerWidget{  
constDetailPageView({super.key});  
@override  
Widgetbuild(BuildContext context,WidgetRef ref){  
final activity = ref.watch(activityProvider);  
returnScaffold(  
      appBar:AppBar(  
        title:constText('Detail page'),  
),  
      body:RefreshIndicator(  
        onRefresh:()=> ref.refresh(activityProvider.future),  
        child:ListView(  
          children:[  
switch(activity){  
AsyncValue(:final value?)=>Text(value.activity),  
AsyncValue(:final error?)=>Text('Error: $error'),  
              _ =>constCenter(child:CircularProgressIndicator()),  
},  
],  
),  
),  
);  
}  
}  
```
lib/src/detail_screen.dart
```
@freezed  
sealed classActivitywith _$Activity{  
factoryActivity({  
    required String activity,  
    required String type,  
    required int participants,  
    required double price,  
})= _Activity;  
factoryActivity.fromJson(Map json)=>  
      _$ActivityFromJson(json);  
}  
@riverpod  
Futureactivity(Ref ref)async{  
final response =await http.get(  
Uri.https('www.boredapi.com','/api/activity'),  
);  
final json =jsonDecode(response.body)asMap;  
returnActivity.fromJson(Map.from(json));  
}  
classDetailPageViewextendsConsumerWidget{  
constDetailPageView({super.key});  
@override  
Widgetbuild(BuildContext context,WidgetRef ref){  
final activity = ref.watch(activityProvider);  
returnScaffold(  
      appBar:AppBar(  
        title:constText('Detail page'),  
),  
      body:RefreshIndicator(  
        onRefresh:()=> ref.refresh(activityProvider.future),  
        child:ListView(  
          children:[  
switch(activity){  
AsyncValue(:final value?)=>Text(value.activity),  
AsyncValue(:final error?)=>Text('Error: $error'),  
              _ =>constCenter(child:CircularProgressIndicator()),  
},  
],  
),  
),  
);  
}  
}  
```
## Cancelling requests​
Now that we have a working application, let's implement the cancellation logic.
To do so, we will use `ref.onDispose` to cancel the request when the user navigates away from the page. For this to work, it is important that the automatic disposal of providers is enabled.
The exact code needed to cancel the request will depend on the HTTP client. In this example, we will use `package:http`, but the same principle applies to other clients.
The key here is that `ref.onDispose` will be called when the user navigates away. That is because our provider is no-longer used, and therefore disposed thanks to automatic disposal.  
We can therefore use this callback to cancel the request. When using `package:http`, this can be done by closing our HTTP client.
  * riverpod
  * riverpod_generator
```
final activityProvider =FutureProvider.autoDispose((ref)async{  
// We create an HTTP client using package:http  
final client =http.Client();  
// On dispose, we close the client.  
// This will cancel any pending request that the client might have.  
  ref.onDispose(client.close);  
// We now use the client to make the request instead of the "get" function.  
final response =await client.get(  
Uri.https('www.boredapi.com','/api/activity'),  
);  
// The rest of the code is the same as before  
final json =jsonDecode(response.body)asMap;  
returnActivity.fromJson(Map.from(json));  
});  
```
```
@riverpod  
Futureactivity(Ref ref)async{  
// We create an HTTP client using package:http  
final client =http.Client();  
// On dispose, we close the client.  
// This will cancel any pending request that the client might have.  
  ref.onDispose(client.close);  
// We now use the client to make the request instead of the "get" function.  
final response =await client.get(  
Uri.https('www.boredapi.com','/api/activity'),  
);  
// The rest of the code is the same as before  
final json =jsonDecode(response.body)asMap;  
returnActivity.fromJson(Map.from(json));  
}  
```
## Debouncing requests​
Now that we have implemented cancellation, let's implement debouncing.  
At the moment, if the user refreshes the activity multiple times in a row, we will send a request for each refresh.
Technically speaking, now that we have implemented cancellation, this is not a problem. If the user refreshes the activity multiple times in a row, the previous request will be cancelled, when a new request is made.
However, this is not ideal. We are still sending multiple requests, and wasting bandwidth and server resources.  
What we could instead do is delay our requests until the user stops refreshing the activity for a fixed amount of time.
The logic here is very similar to the cancellation logic. We will again use `ref.onDispose`. However, the idea here is that instead of closing an HTTP client, we will rely on `onDispose` to abort the request before it starts.  
We will then arbitrarily wait for 500ms before sending the request. Then, if the user refreshes the activity again before the 500ms have elapsed, `onDispose` will be invoked, aborting the request.
To abort requests, a common practice is to voluntarily throw.  
It is safe to throw inside providers after the provider has been disposed. The exception will naturally be caught by Riverpod and be ignored.
  * riverpod
  * riverpod_generator
```
final activityProvider =FutureProvider.autoDispose((ref)async{  
// We capture whether the provider is currently disposed or not.  
var didDispose =false;  
  ref.onDispose(()=> didDispose =true);  
// We delay the request by 500ms, to wait for the user to stop refreshing.  
awaitFuture.delayed(constDuration(milliseconds:500));  
// If the provider was disposed during the delay, it means that the user  
// refreshed again. We throw an exception to cancel the request.  
// It is safe to use an exception here, as it will be caught by Riverpod.  
if(didDispose){  
throwException('Cancelled');  
}  
// The following code is unchanged from the previous snippet  
final client =http.Client();  
  ref.onDispose(client.close);  
final response =await client.get(  
Uri.https('www.boredapi.com','/api/activity'),  
);  
final json =jsonDecode(response.body)asMap;  
returnActivity.fromJson(Map.from(json));  
});  
```
```
@riverpod  
Futureactivity(Ref ref)async{  
// We capture whether the provider is currently disposed or not.  
var didDispose =false;  
  ref.onDispose(()=> didDispose =true);  
// We delay the request by 500ms, to wait for the user to stop refreshing.  
awaitFuture.delayed(constDuration(milliseconds:500));  
// If the provider was disposed during the delay, it means that the user  
// refreshed again. We throw an exception to cancel the request.  
// It is safe to use an exception here, as it will be caught by Riverpod.  
if(didDispose){  
throwException('Cancelled');  
}  
// The following code is unchanged from the previous snippet  
final client =http.Client();  
  ref.onDispose(client.close);  
final response =await client.get(  
Uri.https('www.boredapi.com','/api/activity'),  
);  
final json =jsonDecode(response.body)asMap;  
returnActivity.fromJson(Map.from(json));  
}  
```
## Going further: Doing both at once​
We now know how to debounce and cancel requests.  
But currently, if we want to do another request, we need to copy-paste the same logic in multiple places. This is not ideal.
However, we can go further and implement a reusable utility to do both at once.
The idea here is to implement an extension method on `Ref` that will handle both cancellation and debouncing in a single method.
```
extensionDebounceAndCancelExtensiononRef{  
/// Wait for [duration] (defaults to 500ms), and then return a [http.Client]  
/// which can be used to make a request.  
///  
/// That client will automatically be closed when the provider is disposed.  
FuturegetDebouncedHttpClient([Duration? duration])async{  
// First, we handle debouncing.  
var didDispose =false;  
onDispose(()=> didDispose =true);  
// We delay the request by 500ms, to wait for the user to stop refreshing.  
awaitFuture.delayed(duration ??constDuration(milliseconds:500));  
// If the provider was disposed during the delay, it means that the user  
// refreshed again. We throw an exception to cancel the request.  
// It is safe to use an exception here, as it will be caught by Riverpod.  
if(didDispose){  
throwException('Cancelled');  
}  
// We now create the client and close it when the provider is disposed.  
final client =http.Client();  
onDispose(client.close);  
// Finally, we return the client to allow our provider to make the request.  
return client;  
}  
}  
```
We can then use this extension method in our providers as followed:
  * riverpod
  * riverpod_generator
```
final activityProvider =FutureProvider.autoDispose((ref)async{  
// We obtain an HTTP client using the extension we created earlier.  
final client =await ref.getDebouncedHttpClient();  
// We now use the client to make the request instead of the "get" function.  
// Our request will naturally be debounced and be cancelled if the user  
// leaves the page.  
final response =await client.get(  
Uri.https('www.boredapi.com','/api/activity'),  
);  
final json =jsonDecode(response.body)asMap;  
returnActivity.fromJson(Map.from(json));  
});  
```
```
@riverpod  
Futureactivity(Ref ref)async{  
// We obtain an HTTP client using the extension we created earlier.  
final client =await ref.getDebouncedHttpClient();  
// We now use the client to make the request instead of the "get" function.  
// Our request will naturally be debounced and be cancelled if the user  
// leaves the page.  
final response =await client.get(  
Uri.https('www.boredapi.com','/api/activity'),  
);  
final json =jsonDecode(response.body)asMap;  
returnActivity.fromJson(Map.from(json));  
}  
```
[](https://github.com/rrousselGit/riverpod/edit/master/website/docs/how_to/cancel.mdx)
 Quickstart
  * The application
  * Cancelling requests
  * Debouncing requests
  * Going further: Doing both at once
Docs