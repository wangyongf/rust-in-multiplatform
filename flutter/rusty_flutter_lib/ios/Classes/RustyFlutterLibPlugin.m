#import "RustyFlutterLibPlugin.h"
#if __has_include(<rusty_flutter_lib/rusty_flutter_lib-Swift.h>)
#import <rusty_flutter_lib/rusty_flutter_lib-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "rusty_flutter_lib-Swift.h"
#endif

@implementation RustyFlutterLibPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftRustyFlutterLibPlugin registerWithRegistrar:registrar];
}
@end
