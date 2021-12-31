import 'package:bristol_app/features/shops/domain/bloc/shops_map_cubit.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uikit/friflex_utils.dart';

import 'shop_map_controller.dart';

class ShopsMap extends StatefulWidget {
  const ShopsMap(this.cubit, {Key? key}) : super(key: key);

  final ShopsMapCubit cubit;

  @override
  _ShopsMapState createState() => _ShopsMapState();
}

class _ShopsMapState extends State<ShopsMap> {
  ShopMapController? _clusterManager;
  bool myLocationEnabled = false;

  @override
  void dispose() {
    _clusterManager?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _clusterManager = ShopMapController(
      widget.cubit,
      context,
      onMarkersUpdated: () {
        runWithDelay(action: () {
          setState(() {});
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      onMapCreated: (GoogleMapController controller) {
        _clusterManager?.controllerCompleter.complete(controller);
        // нужно для того что бы диалог доступа к локации
        // показывался только после завершения загрузки карты
        // и окончания анимации
        runWithDelay(
            action: () {
              setState(() {
                myLocationEnabled = true;
              });
            },
            duration: const Duration(seconds: 1));
      },
      zoomControlsEnabled: false,
      markers: _clusterManager?.markers ?? {},
      onCameraMove: _clusterManager?.manager?.onCameraMove,
      onCameraIdle: () {
        _clusterManager?.manager?.updateMap.call();
      },
      myLocationButtonEnabled: false,
      myLocationEnabled: myLocationEnabled,
      initialCameraPosition:
          CameraPosition(target: _clusterManager!.initialPosition, zoom: 12),
    );
  }
}
