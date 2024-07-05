import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_map_app/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({super.key});

  @override
  State<OrderTrackingPage> createState() => OrderTrackingPageState();
}

class OrderTrackingPageState extends State<OrderTrackingPage> {
  // Define the locations for source and destination
  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  // Create the markers
  //   final Set<Marker> _markers = {
  //   Marker(
  //     markerId: MarkerId("source"),
  //     position: sourceLocation,
  //     infoWindow: InfoWindow(title: "Source Location"),
  //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  //   ),
  //   Marker(
  //     markerId: MarkerId("destination"),
  //     position: destination,
  //     infoWindow: InfoWindow(title: "Destination Location"),
  //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
  //   ),
  // };

  final List<LatLng> polylineCoordinates = [];

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleMapsApiKey,
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(destination.latitude, destination.longitude));
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polylineCoordinates.add(LatLng(point.latitude, point.longitude)));
      setState(() {});
    }
  }

  @override
  void initState() {
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Track order",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition:
            const CameraPosition(target: sourceLocation, zoom: 14.5),
        polylines: {
          Polyline(
              polylineId: const PolylineId("route"),
              points: polylineCoordinates),
        },
        markers: {
          Marker(
            markerId: MarkerId("source"),
            position: sourceLocation,
            infoWindow: InfoWindow(title: "Source Location"),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
          ),
          Marker(
            markerId: MarkerId("destination"),
            position: destination,
            infoWindow: InfoWindow(title: "Destination Location"),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        }, // Add the markers to the GoogleMap widget
      ),
    );
  }
}
