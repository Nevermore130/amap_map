//
//  AMapFlutterFactory.m
//  amap_map
//
//  Created by lly on 2020/10/29.
//

#import "AMapFlutterFactory.h"
#import <MAMapKit/MAMapKit.h>
#import "AMapViewController.h"

@implementation AMapFlutterFactory {
  NSObject<FlutterPluginRegistrar>* _registrar;
}

- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  self = [super init];
  if (self) {
    _registrar = registrar;
  }
  return self;
}

- (NSObject<FlutterMessageCodec>*)createArgsCodec {
  return [FlutterStandardMessageCodec sharedInstance];
}

- (NSObject<FlutterPlatformView>*)createWithFrame:(CGRect)frame
                                   viewIdentifier:(int64_t)viewId
                                        arguments:(id _Nullable)args {
    // 在地图创建前设置地形图开关（since 8.2.0）
    if ([args isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = args;
        NSNumber *terrainEnabled = dict[@"terrainEnabled"];
        if (terrainEnabled != nil && [terrainEnabled isKindOfClass:[NSNumber class]]) {
            [MAMapView setTerrainEnabled:[terrainEnabled boolValue]];
        }
    }

    return [[AMapViewController alloc] initWithFrame:frame
                                      viewIdentifier:viewId
                                           arguments:args
                                           registrar:_registrar];
}
@end
