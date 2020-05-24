import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(GoogleMaps2());

class GoogleMaps2 extends StatefulWidget {
  static open(context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => GoogleMaps2()));

  @override
  _GoogleMaps2State createState() => _GoogleMaps2State();
}

class _GoogleMaps2State extends State<GoogleMaps2> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(17.9689, 79.5941);

  final Set<Marker> _markers = {};

  LatLng _lastMapPosition = _center;

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Your location',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  static final CameraPosition _position1 = CameraPosition(
    bearing: 192.833,
    target: _center,
    tilt: 59.440,
    zoom: 11
  );

  Future<void> _goToPosition1() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_position1));
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
        backgroundColor: Colors.green[700],
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            mapType: _currentMapType,
            markers: _markers,
            onCameraMove: _onCameraMove,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  FloatingActionButton(
                    heroTag: "btn1",
                    onPressed: _onMapTypeButtonPressed,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.green[700],
                    child: const Icon(Icons.map, size: 36.0),
                  ),
                  SizedBox(height: 16.0),
                  FloatingActionButton(
                    heroTag: "btn2",
                    onPressed: _onAddMarkerButtonPressed,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.green[700],
                    child: const Icon(Icons.add_location, size: 36.0),
                  ),
                  SizedBox(height: 16.0),
                  FloatingActionButton(
                    heroTag: "btn3",
                    onPressed: _goToPosition1,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.green[700],
                    child: const Icon(Icons.location_searching, size: 36.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
