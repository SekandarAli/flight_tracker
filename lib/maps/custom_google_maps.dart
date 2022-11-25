// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMaps extends StatefulWidget {
   CustomGoogleMaps({super.key,required this.departureLng,required this.departureLat,required this.arrivalLat,required this.arrivalLng,});

  double departureLat;
  double departureLng;
  double arrivalLat;
  double arrivalLng;

  @override
  _CustomGoogleMapsState createState() => _CustomGoogleMapsState();
}

class _CustomGoogleMapsState extends State<CustomGoogleMaps> {
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};
  late BitmapDescriptor customIcon;
  GoogleMapController? controller;

  List<LatLng> latLngList = [];
  late LatLng lat1 = LatLng(widget.departureLat, widget.departureLng);
  late LatLng lat2 = LatLng(widget.arrivalLat, widget.arrivalLng);
  // static final LatLng _lat2 = LatLng(31.5204, 74.3587);
  late final LatLng _lastMapPosition = lat1;

  @override
  void initState() {
    super.initState();
    latLngList.add(lat1);
    latLngList.add(lat2);
    customMarker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        polylines: _polyline,
        markers: _markers,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _lastMapPosition,
          zoom: 5.0,
        ),
        mapType: MapType.normal,
      ),
    );
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
      _markers.add(Marker(
        icon: customIcon,
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Flight Track',
          snippet: 'Starting from this position',
        ),
      ));

      _polyline.add(Polyline(
        polylineId: PolylineId('line1'),
        visible: true,
        points: latLngList,
        width: 5,
        color: Colors.red,
      ));
    });
  }

  void customMarker() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(), 'assets/images/flight.jpg',)
        .then((value) => {
          customIcon = value
        });
  }
}
