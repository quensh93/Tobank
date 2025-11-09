# Docs Concepts2 Retry

# Docs Concepts2 Retry
# Docs Concepts2 Retry
**Riverpod**
[](https://riverpod.dev/docs/concepts2/retry)
Search
  * Automatic retry
# Automatic retry
In Riverpod, Providers are automatically retried when they fail.
A retry is attempted when an exception is thrown during the provider's computation. The retry logic can be customized either on a per-provider basis or globally for all providers.
By default, a provider can be retried up to 10 times, with an exponential backoff going from 200ms to 6.4 seconds. For the full details about the default retry logic, see retry.
## Customizing retry logic​
A custom retry logic can be provided either for the full application or for a specific provider.
The implementation is the same for both cases: Custom retry logic is a function that is expected to return a `Duration?` value ; which indicates the delay before the next retry (or `null` to stop retrying).
The following implements a custom retry function, which will retry up to 5 times, with an exponential backoff starting at 200ms, and ignores ProviderExceptions
```
Duration?myRetry(int retryCount,Object error){  
// Stop retrying on ProviderException  
if(retryCount >=5)returnnull;  
// Ignore ProviderException  
if(error isProviderException)returnnull;  
returnDuration(milliseconds:200*(1(  
    retry: myRetry,  
(ref)=>0,  
);  
```
```
@Riverpod(retry: myRetry)  
int myProvider(MyProviderRef ref){  
return0;  
}  
```
Or globally by passing it to ProviderContainers/ProviderScopes:
```
// For pure Dart code  
final container =ProviderContainer(  
  retry: myRetry,  
);  
...  
// For Flutter code  
runApp(  
ProviderScope(  
    retry: myRetry,  
    child:MyApp(),  
),  
);  
```
### Disabling retry​
Disabling retry is as simple as always retuning `null` in the retry function. If you wish to disable retry for all your application, do:
```
runApp(  
ProviderScope(  
    retry:(retryCount, error)=>null,  
    child:MyApp(),  
),  
);  
```
## About the default retry logic​
The default retry logic is designed to be a more more clever than a naive "if fail, retry". In particular, it will not retry Errors and ProviderExceptions.
Errors are not retried, because they are not recoverable. They indicate a bug in the code, and retrying would not help. Retrying in those cases would just pollute the logs with useless retry attempts.
As for ProviderExceptions, those are not retried because they indicate that a provider did not fail, but instead rethrow an exception from a failed provider. Consider:
  * riverpod
  * riverpod_generator
```
final failedProvider =Provider(  
(ref)=>throwException('This provider always fails'),  
);  
final myProvider =Provider(  
// This provider depends on a failed provider,  
// and will therefore throw a ProviderException  
(ref)=> ref.watch(failedProvider),  
);  
```
```
@riverpod  
int failed(MyProviderRef ref){  
throwException('This provider always fails');  
}  
@riverpod  
int myProvider(MyProviderRef ref){  
// This provider depends on a failed provider,  
// and will therefore throw a ProviderException  
return ref.watch(failedProvider);  
}  
```
In this example, although `myProvider` fails, it is not responsible for the failure. Retrying it would not help. Instead, it is `failedProvider` that should be retried.
This implies that if you disable retry for `failedProvider`, then `myProvider` will also not be retried.
## Awaiting for retries to complete​
You may be aware that you can await for asynchronous providers to complete, by using FutureProvider.future:
```
final value =await ref.watch(myProvider.future);  
```
But you may wonder how automatic retry interacts with this.
In short, when an asynchronous provider fails and is retried, the associated future will keep waiting until either:
  * all retries are exhausted, or
  * the provider succeeds.
This ensures that `await ref.watch(myProvider.future)` skips the intermediate failures.
[](https://github.com/rrousselGit/riverpod/edit/master/website/docs/concepts2/retry.mdx)
 ProviderObservers
  * Customizing retry logic
    * Disabling retry
  * About the default retry logic
  * Awaiting for retries to complete
Docs