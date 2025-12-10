enum ApiExceptionType {
  unknown,
  noConnection,
  badRequest,
  vpnConnected,
  unhandledStatusCode,
  connectionTimeout,
  responseDecryping,
  responseDecoding,
  deviceIsNotSecured,
  signIsNotValid;
}
