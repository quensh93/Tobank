sealed class ApiResult<S, E extends Exception> {
  const ApiResult();
}

final class Success<S, E extends Exception> extends ApiResult<S, E> {
  const Success(this.value);
  final S value;
}

final class Failure<S, E extends Exception> extends ApiResult<S, E> {
  const Failure(this.exception);
  final E exception;
}
