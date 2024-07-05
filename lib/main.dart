import 'package:flutter/material.dart';
import 'package:google_map_app/components/google_map_page.dart';
import 'package:google_map_app/components/order_tracking_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Google Maps App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: OrderTrackingPage(),
      );
}
