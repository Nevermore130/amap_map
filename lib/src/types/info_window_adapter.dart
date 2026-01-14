import 'package:amap_map/amap_map.dart';
import 'package:flutter/widgets.dart';

abstract class InfoWindowAdapter {
  Widget? getInfoWindow(BuildContext context, Marker marker);
}

abstract class BaseInfoWindowAdapter implements InfoWindowAdapter {
  final AMapController? controller;

  BaseInfoWindowAdapter(this.controller);

  @override
  Widget? getInfoWindow(BuildContext context, Marker marker) {
    final Widget? contentView = buildInfoWindowContent(context, marker);
    return FutureBuilder<ScreenCoordinate>(
            future: controller?.toScreenCoordinate(marker.position),
            builder: (BuildContext context,
                AsyncSnapshot<ScreenCoordinate> snapshot) {
              if (snapshot.hasData) {
                return Positioned(
                  left: snapshot.data!.x.toDouble() - 23 ,
                  top: snapshot.data!.y.toDouble() -70 ,
                  child: contentView ?? Container(),
                );
              } else {
                return Container();
              }
            },
          );
  }

  Widget? buildInfoWindowContent(BuildContext context, Marker marker);
}
