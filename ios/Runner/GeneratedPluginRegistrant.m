//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<http_interceptor/HttpInterceptorPlugin.h>)
#import <http_interceptor/HttpInterceptorPlugin.h>
#else
@import http_interceptor;
#endif

#if __has_include(<sqflite/SqflitePlugin.h>)
#import <sqflite/SqflitePlugin.h>
#else
@import sqflite;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [HttpInterceptorPlugin registerWithRegistrar:[registry registrarForPlugin:@"HttpInterceptorPlugin"]];
  [SqflitePlugin registerWithRegistrar:[registry registrarForPlugin:@"SqflitePlugin"]];
}

@end
