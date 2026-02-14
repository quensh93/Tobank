#import "SecurePlugin.h"
#if __has_include(<secure_plugin/secure_plugin-Swift.h>)
#import <secure_plugin/secure_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "secure_plugin-Swift.h"
#endif

@implementation SecurePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSecurePlugin registerWithRegistrar:registrar];
}
@end
