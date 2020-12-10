import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    // Determining the screen width & height
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // Initial location of the Map view

    var latitude = 49.178963521477726;
    var longitude =  -0.3571967751886644;

// For controlling the view of the Map
    GoogleMapController mapController;


     final CameraPosition _restaurant = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng( latitude,longitude),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);

    Set<Marker> markers = {};
    Marker startMarker = Marker(
      markerId: MarkerId('A'),
      position: LatLng(
        latitude,
        longitude,
      ),
      infoWindow: InfoWindow(
        title: 'Restaurant Bayon',
        snippet: "164 rue saint jean",
      ),
      icon: BitmapDescriptor.defaultMarker,
    );
    markers.add(startMarker);

// Destination Location Marker


    return Container(
      height: height,
      width: width,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
              markers: markers,
              initialCameraPosition: _restaurant,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            ),

          ],
        ),
      ),
    );
  }
}
