# Docs How To Pull To Refresh

# Docs How To Pull To Refresh
# Docs How To Pull To Refresh
**Riverpod**
[](https://riverpod.dev/docs/how_to/pull_to_refresh)
Search
  * Implementing pull-to-refresh
# Implementing pull-to-refresh
Riverpod natively supports pull-to-refresh thanks to its declarative nature.
In general, pull-to-refreshes can be complex due as there are multiple problems to solve:
  * Upon first entering a page, we want to show a spinner. But during refresh, we want to show the refresh indicator instead. We shouldn't show both the refresh indicator _and_ spinner.
  * While a refresh is pending, we want to show the previous data/error.
  * We need to show the refresh indicator for as long as the refresh is happening.
Let's see how to solve this using Riverpod.  
For this, we will make a simple example which recommends a random activity to users.  
And doing a pull-to-refresh will trigger a new suggestion:
## Making a bare-bones application.​
Before implement a pull-to-refresh, we first need something to refresh.  
We can make a simple application which uses Bored API to suggests a random activity to users.
First, let's define an `Activity` class:
  * riverpod
  * riverpod_generator
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
```
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
```
That class will be responsible for representing a suggested activity in a type-safe manner, and handle JSON encoding/decoding.  
Using Freezed/json_serializable is not required, but it is recommended.
Now, we'll want to define a provider making a HTTP GET request to fetch a single activity:
  * riverpod
  * riverpod_generator
```
final activityProvider =FutureProvider.autoDispose((ref)async{  
final response =await http.get(  
Uri.https('www.boredapi.com','/api/activity'),  
);  
final json =jsonDecode(response.body)asMap;  
returnActivity.fromJson(json);  
});  
```
```
@riverpod  
Futureactivity(Ref ref)async{  
final response =await http.get(  
Uri.https('www.boredapi.com','/api/activity'),  
);  
final json =jsonDecode(response.body)asMap;  
returnActivity.fromJson(Map.from(json));  
}  
```
We can now use this provider to display a random activity.  
For now, we will not handle the loading/error state, and simply display the activity when available:
```
classActivityViewextendsConsumerWidget{  
@override  
Widgetbuild(BuildContext context,WidgetRef ref){  
final activity = ref.watch(activityProvider);  
returnScaffold(  
      appBar:AppBar(title:constText('Pull to refresh')),  
      body:Center(  
// If we have an activity, display it, otherwise wait  
        child:Text(activity.value?.activity ??''),  
),  
);  
}  
}  
```
## Adding `RefreshIndicator`​
Now that we have a simple application, we can add a `RefreshIndicator` to it.  
That widget is an official Material widget responsible for displaying a refresh indicator when the user pulls down the screen.
Using `RefreshIndicator` requires a scrollable surface. But so far, we don't have any. We can fix that by using a `ListView`/`GridView`/`SingleChildScrollView`/etc:
```
classActivityViewextendsConsumerWidget{  
@override  
Widgetbuild(BuildContext context,WidgetRef ref){  
final activity = ref.watch(activityProvider);  
returnScaffold(  
      appBar:AppBar(title:constText('Pull to refresh')),  
      body:RefreshIndicator(  
        onRefresh:()async=>print('refresh'),  
        child:ListView(  
          children:[  
Text(activity.value?.activity ??''),  
],  
),  
),  
);  
}  
}  
```
Users can now pull down the screen. But our data isn't refreshed yet.
## Adding the refresh logic​
When users pull down the screen, `RefreshIndicator` will invoke the `onRefresh` callback. We can use that callback to refresh our data. In there, we can use `ref.refresh` to refresh the provider of our choice.
**Note** : `onRefresh` is expected to return a `Future`. And it is important for that future to complete when the refresh is done.
To obtain such a future, we can read our provider's `.future` property. This will return a future which completes when our provider has resolved.
We can therefore update our `RefreshIndicator` to look like this:
```
classActivityViewextendsConsumerWidget{  
@override  
Widgetbuild(BuildContext context,WidgetRef ref){  
final activity = ref.watch(activityProvider);  
returnScaffold(  
      appBar:AppBar(title:constText('Pull to refresh')),  
      body:RefreshIndicator(  
// By refreshing "activityProvider.future", and returning that result,  
// the refresh indicator will keep showing until the new activity is  
// fetched.  
        onRefresh:()=> ref.refresh(activityProvider.future),  
        child:ListView(  
          children:[  
Text(activity.value?.activity ??''),  
],  
),  
),  
);  
}  
}  
```
## Showing a spinner only during initial load and handling errors.​
At the moment, our UI does not handle the error/loading states.  
Instead the data magically pops up when the loading/refresh is done.
Let's change this by gracefully handling those states. There are two cases:
  * During the initial load, we want to show a full-screen spinner.
  * During a refresh, we want to show the refresh indicator and the previous data/error.
Fortunately, when listening to an asynchronous provider in Riverpod, Riverpod gives us an `AsyncValue`, which offers everything we need.
That `AsyncValue` can then be combined with Dart 3.0's pattern matching as follows:
```
classActivityViewextendsConsumerWidget{  
@override  
Widgetbuild(BuildContext context,WidgetRef ref){  
final activity = ref.watch(activityProvider);  
returnScaffold(  
      appBar:AppBar(title:constText('Pull to refresh')),  
      body:RefreshIndicator(  
        onRefresh:()=> ref.refresh(activityProvider.future),  
        child:ListView(  
          children:[  
switch(activity){  
// If some data is available, we display it.  
// Note that data will still be available during a refresh.  
AsyncValue(:final value?)=>Text(value.activity),  
// An error is available, so we render it.  
AsyncValue(:final error?)=>Text('Error: $error'),  
// No data/error, so we're in loading state.  
              _ =>constCircularProgressIndicator(),  
},  
],  
),  
),  
);  
}  
}  
```
We use `valueOrNull` here, as currently, using `value` throws if in error/loading state.
Riverpod 3.0 will change this to have `value` behave like `valueOrNull`. But for now, let's stick to `valueOrNull`.
Notice the usage of the `:final valueOrNull?` syntax in our pattern matching. This syntax can be used only because `activityProvider` returns a non-nullable `Activity`.
If your data can be `null`, you can instead use `AsyncValue(hasData: true, :final valueOrNull)`. This will correctly handle cases where the data is `null`, at the cost of a few extra characters.
## Wrapping up: full application​
Here is the combined source of everything we've covered so far:
  * riverpod
  * riverpod_generator
```
import'dart:convert';  
import'package:flutter/material.dart';  
import'package:flutter_riverpod/flutter_riverpod.dart';  
import'package:http/http.dart'as http;  
voidmain()=>runApp(ProviderScope(child:MyApp()));  
classMyAppextendsStatelessWidget{  
@override  
Widgetbuild(BuildContext context){  
returnMaterialApp(home:ActivityView());  
}  
}  
classActivityViewextendsConsumerWidget{  
@override  
Widgetbuild(BuildContext context,WidgetRef ref){  
final activity = ref.watch(activityProvider);  
returnScaffold(  
      appBar:AppBar(title:constText('Pull to refresh')),  
      body:RefreshIndicator(  
        onRefresh:()=> ref.refresh(activityProvider.future),  
        child:ListView(  
          children:[  
switch(activity){  
AsyncValue(:final value?)=>Text(value.activity),  
AsyncValue(:final error?)=>Text('Error: $error'),  
              _ =>constCircularProgressIndicator(),  
},  
],  
),  
),  
);  
}  
}  
final activityProvider =FutureProvider.autoDispose((ref)async{  
final response =await http.get(  
Uri.https('www.boredapi.com','/api/activity'),  
);  
final json =jsonDecode(response.body)asMap;  
returnActivity.fromJson(json);  
});  
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
```
```
import'dart:convert';  
import'package:flutter/material.dart';  
import'package:flutter_riverpod/flutter_riverpod.dart';  
import'package:freezed_annotation/freezed_annotation.dart';  
import'package:http/http.dart'as http;  
import'package:riverpod_annotation/riverpod_annotation.dart';  
part'codegen.g.dart';  
part'codegen.freezed.dart';  
voidmain()=>runApp(ProviderScope(child:MyApp()));  
classMyAppextendsStatelessWidget{  
@override  
Widgetbuild(BuildContext context){  
returnMaterialApp(home:ActivityView());  
}  
}  
classActivityViewextendsConsumerWidget{  
@override  
Widgetbuild(BuildContext context,WidgetRef ref){  
final activity = ref.watch(activityProvider);  
returnScaffold(  
      appBar:AppBar(title:constText('Pull to refresh')),  
      body:RefreshIndicator(  
        onRefresh:()=> ref.refresh(activityProvider.future),  
        child:ListView(  
          children:[  
switch(activity){  
AsyncValue(:final value?)=>Text(value.activity),  
AsyncValue(:final error?)=>Text('Error: $error'),  
              _ =>constCircularProgressIndicator(),  
},  
],  
),  
),  
);  
}  
}  
@riverpod  
Futureactivity(Ref ref)async{  
final response =await http.get(  
Uri.https('www.boredapi.com','/api/activity'),  
);  
final json =jsonDecode(response.body)asMap;  
returnActivity.fromJson(Map.from(json));  
}  
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
```
[](https://github.com/rrousselGit/riverpod/edit/master/website/docs/how_to/pull_to_refresh.mdx)
 How to debounce/cancel network requests
  * Making a bare-bones application.
  * Adding `RefreshIndicator`
  * Adding the refresh logic
  * Showing a spinner only during initial load and handling errors.
  * Wrapping up: full application
Docs