import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// map
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

/// bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:woomam/bloc/bloc.dart';
import 'package:woomam/components/screen/home/store_bottom_sheet.dart';
import 'package:woomam/model/model.dart';

/// components
import '../../components.dart';
import 'home_search_bar.dart';

class HomeScreen extends StatefulWidget {
  final String phoneNumber;
  const HomeScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// google map controller
  late final Completer<GoogleMapController> _mapController;
  late final Location location;
  late final bool _serviceEnabled;
  late final PermissionStatus _permissionGranted;

  Future<bool> _checkLocationServiceIsEnabled() async {
    /// check if the service is enabled
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }

    /// check if the user-permission is enabled
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Future<LocationData> _getCurrentLocation() async =>
      await location.getLocation();

  /// convert asset to bytes
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  /// initialize pin markers with data of stores received
  Future<Set<Marker>> _createPinMarkersWithStores(List<Store> stores) async {
    Set<Marker> result = {};

    /// make pin icon
    final Uint8List _pinIcon =
        await getBytesFromAsset('images/washing-machine.png', 140);

    for (var store in stores) {
      result.add(
        /// add marker
        Marker(
          markerId: MarkerId(store.storeUID),
          position: LatLng(
            double.parse(store.latitude),
            double.parse(store.longitude),
          ),
          icon: BitmapDescriptor.fromBytes(_pinIcon),
          onTap: () =>

              /// show modal after fetching data of washing machine
              showBarModalBottomSheet(
            context: context,
            builder: (_) => ReservationBottomSheet(
              store: store,
              userPhoneNumber: widget.phoneNumber,
            ),
          ),
        ),
      );
    }
    return result;
  }

  @override
  void initState() {
    super.initState();
    _mapController = Completer<GoogleMapController>();
    location = Location();

    /// first check if the service is enabled and if the user has checked the permission
    _checkLocationServiceIsEnabled();

    /// add event to fetch the data
    BlocProvider.of<StoreBloc>(context).add(GetStoresEvent());
  }

  /// builds under the [Scaffold's body]
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreBloc, StoreState>(builder: (_, state) {
      if (state is StoreEmpty) {
        return emptyWidget;
      } else if (state is StoreLoading) {
        return loadingWidget;
      } else if (state is StoreError) {
        return errorWidget;
      } else if (state is StoresLoaded) {
        /// display markers with saved stores
        List<Store> _stores = state.stores;

        return Stack(
          /// display search bar at the top
          /// and then display map at the behind of search bar
          children: [
            /// map
            SizedBox.expand(
                child: FutureBuilder<dynamic>(
                    future: Future.wait([
                      _getCurrentLocation(),
                      _createPinMarkersWithStores(_stores)
                    ]),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return loadingWidget;
                      } else if (snapshot.hasError) {
                        return errorWidget;
                      }

                      /// use variable with data
                      final _locationData = snapshot.data[0];
                      Set<Marker> _pinStores = snapshot.data[1];

                      /// build map
                      return GoogleMap(
                        /// style
                        mapType: MapType.normal,

                        /// functions in map
                        myLocationEnabled: true,
                        zoomGesturesEnabled: true,

                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            _locationData?.latitude ?? 37.123,
                            _locationData?.longitude ?? 127.123,
                          ),
                          zoom: 16.0,
                        ),

                        /// map visualization
                        onMapCreated: (controller) =>
                            _mapController.complete(controller),
                        markers: _pinStores,
                      );
                    })),

            /// search bar
            Padding(
              padding: paddingHV(16, 8),
              child: HomeSearchBar(
                onSeachButtonTapped: () {},
              ),
            ),
          ],
        );
      }

      /// this widget should not be shown to users
      return blankBoxH();
    });
  }
}
