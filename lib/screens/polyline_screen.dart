import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:tripmap/screens/loadingscreen.dart';
import 'package:tripmap/globals.dart' as globals;

class PolylineScreen extends StatefulWidget {
  const PolylineScreen({Key? key}) : super(key: key);

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  LatLng sourceLocation = const LatLng(41.015137, 28.979530);
  bool isFetched = false;
  late Position currentLocation;
  LatLng destination = const LatLng(41.008469, 28.980261);
  //List<LatLng> polyLineCoordinates = [];

  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polyLineCoordinates = [];
  late PolylinePoints polylinePoints;

  void getCurrentLocation() async {
    currentLocation = await globals.deviceLocation;
    setState(() {
      isFetched = true;
      hideLoadingOverlay();
    });
  }

  void getPolyPoints() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyB3Wa2VPWoLEPCvCyomq23hsRtaz8RH8sQ",
        PointLatLng(isFetched ? currentLocation.longitude : 41.015137,
            isFetched ? currentLocation.latitude : 28.979530),
        PointLatLng(destination.longitude, destination.latitude),
        travelMode: TravelMode.driving);
    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {
        _polylines.add(Polyline(
            width: 10,
            polylineId: PolylineId('polyLine'),
            color: Color(0xFF08A5CB),
            points: polyLineCoordinates));
      });
    }
  }

  OverlayEntry? entry;

  void showLoadingOverlay() {
    final overlay = Overlay.of(context)!;

    entry = OverlayEntry(
      builder: (context) => buildLoadingOverlay(),
    );

    overlay.insert(entry!);
  }

  void hideLoadingOverlay() {
    entry!.remove();
    entry = null;
  }

  Widget buildLoadingOverlay() => const Material(
        color: Colors.transparent,
        elevation: 8,
        child: Center(
          child: CircularProgressIndicator(
              color: Color.fromARGB(255, 163, 171, 192)),
        ),
      );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => showLoadingOverlay());
    getCurrentLocation();
    getPolyPoints();
    polylinePoints = PolylinePoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(41.015137, 28.979530), zoom: 14.5),
        polylines: _polylines,
        markers: {
          Marker(markerId: MarkerId("destination"), position: destination),
          Marker(
              markerId: MarkerId("currentLocation"),
              position: LatLng(isFetched ? currentLocation.latitude : 41.015137,
                  isFetched ? currentLocation.longitude : 28.979530))
        },
        onMapCreated: (controller) =>
            {_controller.complete(controller), getPolyPoints()},
      ),
    );
  }
}
