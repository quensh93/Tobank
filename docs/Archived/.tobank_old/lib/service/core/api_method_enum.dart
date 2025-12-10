enum ApiMethod {
  get('GET'),
  put('PUT'),
  post('POST'),
  delete('DELETE'),
  head('HEAD');

  final String methodName;

  const ApiMethod(this.methodName);
}
