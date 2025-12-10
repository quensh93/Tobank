# مستند خطاهای سرویس

connection time out -> 2000 -> StringConstants.timeoutMessage
recieve timeout -> 2001 -> StringConstants.timeoutMessage
send timeout -> 2002 -> StringConstants.timeoutMessage
connection error (wifi or data available but no internet data) -> 2003 -> StringConstants.noInternetMessage
connection error (wifi or data not available) -> 2004 -> StringConstants.noInternetMessage
type error -> 2005 -> StringConstants.exceptionMessage
decyption error or html content -> 2006 -> StringConstants.exceptionMessage
vpn connected -> 2007 -> StringConstants.vpnForbiddenMessage
vpn connected status code 403 -> 2008 -> StringConstants.vpnForbiddenMessage
unknown exception happend -> 2009 -> StringConstants.exceptionMessage
device is not secured -> 2010 -> StringConstants.deviceIsNotSecured
sign is not valid -> 2011 -> StringConstants.deviceIsNotSecured

bad request(status code == 400) -> 3400 -> api error message ?? StringConstants.nullErrorMessage

unhandled status code -> 3000 + status code -> StringConstants.exceptionMessage
