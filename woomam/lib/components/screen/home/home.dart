import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../components.dart';
import 'home_search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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

  @override
  void initState() {
    super.initState();
    _mapController = Completer<GoogleMapController>();
    location = Location();

    /// first check if the service is enabled and if the user has checked the permission
    _checkLocationServiceIsEnabled();
  }

  /// builds under the [Scaffold's body]
  @override
  Widget build(BuildContext context) {
    return Stack(
      /// display search bar at the top
      /// and then display map at the behind of search bar
      children: [
        /// map
        SizedBox.expand(
            child: FutureBuilder<LocationData>(
                future: _getCurrentLocation(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error'));
                  }

                  /// use variable with data
                  final _locationData = snapshot.data;

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
                    onMapCreated: (controller) =>
                        _mapController.complete(controller),
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
}
