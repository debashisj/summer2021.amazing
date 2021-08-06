//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"

#if __has_include(<flutter_inappwebview/InAppWebViewFlutterPlugin.h>)
#import <flutter_inappwebview/InAppWebViewFlutterPlugin.h>
#else
@import flutter_inappwebview;
#endif

#if __has_include(<flutter_statusbarcolor_ns/FlutterStatusbarcolorPlugin.h>)
#import <flutter_statusbarcolor_ns/FlutterStatusbarcolorPlugin.h>
#else
@import flutter_statusbarcolor_ns;
#endif

#if __has_include(<flutter_voice_processor/FlutterVoiceProcessorPlugin.h>)
#import <flutter_voice_processor/FlutterVoiceProcessorPlugin.h>
#else
@import flutter_voice_processor;
#endif

#if __has_include(<path_provider/FLTPathProviderPlugin.h>)
#import <path_provider/FLTPathProviderPlugin.h>
#else
@import path_provider;
#endif

#if __has_include(<porcupine/PorcupinePlugin.h>)
#import <porcupine/PorcupinePlugin.h>
#else
@import porcupine;
#endif

#if __has_include(<shared_preferences/FLTSharedPreferencesPlugin.h>)
#import <shared_preferences/FLTSharedPreferencesPlugin.h>
#else
@import shared_preferences;
#endif

#if __has_include(<soundpool/SoundpoolPlugin.h>)
#import <soundpool/SoundpoolPlugin.h>
#else
@import soundpool;
#endif

#if __has_include(<url_launcher/FLTURLLauncherPlugin.h>)
#import <url_launcher/FLTURLLauncherPlugin.h>
#else
@import url_launcher;
#endif

#if __has_include(<wakelock/WakelockPlugin.h>)
#import <wakelock/WakelockPlugin.h>
#else
@import wakelock;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [InAppWebViewFlutterPlugin registerWithRegistrar:[registry registrarForPlugin:@"InAppWebViewFlutterPlugin"]];
  [FlutterStatusbarcolorPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterStatusbarcolorPlugin"]];
  [FlutterVoiceProcessorPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterVoiceProcessorPlugin"]];
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
  [PorcupinePlugin registerWithRegistrar:[registry registrarForPlugin:@"PorcupinePlugin"]];
  [FLTSharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharedPreferencesPlugin"]];
  [SoundpoolPlugin registerWithRegistrar:[registry registrarForPlugin:@"SoundpoolPlugin"]];
  [FLTURLLauncherPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTURLLauncherPlugin"]];
  [WakelockPlugin registerWithRegistrar:[registry registrarForPlugin:@"WakelockPlugin"]];
}

@end
