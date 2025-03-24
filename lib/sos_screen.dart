import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class SOSScreen extends StatefulWidget {
  const SOSScreen({super.key});

  @override
  State<SOSScreen> createState() => _SOSScreenState();
}

class _SOSScreenState extends State<SOSScreen> {
  String _location = "Unknown";

  Future<void> _sendSOS() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _location = "Location services are disabled.";
      });
      return;
    }

    // Request location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        setState(() {
          _location = "Location permission denied.";
        });
        return;
      }
    }

    // Get the current position
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _location = "Lat: ${position.latitude}, Lon: ${position.longitude}";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("🚨 SOS Sent! Location: $_location"),
        backgroundColor: Colors.red,
      ),
    );

    // TODO: Send location to emergency contact or backend
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shurokkha BD – SOS"),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.warning_amber_rounded, size: 100, color: Colors.red),
            const SizedBox(height: 20),
            const Text("Emergency Assistance", style: TextStyle(fontSize: 24)),
            const SizedBox(height: 10),
            Text("Your Location:\n$_location", textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              ),
              onPressed: _sendSOS,
              child: const Text("SEND SOS", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
