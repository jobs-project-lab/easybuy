import 'dart:io';

import 'package:easy/presentation/page/BottomParPages/main_page.dart';
import 'package:easy/presentation/page/home.dart';
import 'package:easy/presentation/page/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationSection extends StatefulWidget {
  @override
  _LocationSectionState createState() => _LocationSectionState();
}

class _LocationSectionState extends State<LocationSection> {
  Set<Marker> _markers = {};
  void _onTap(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => GoogleMapsScreen()));
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId('id-1'),
            position: LatLng(22.0548451989, 88.484981),
            infoWindow: InfoWindow(title: 'Damascus', snippet: 'AlMazeh')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Location',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox()
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    color: Colors.orange,
                  ),
                  Flexible(
                    child: Text(
                      'Lago Vista - Tower C, Dubai Production City (IMP...)',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              child: Container(
                height: 150,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  markers: _markers,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(22.0548451989, 88.484981),
                    zoom: 15,
                  ),
                  onTap: (target) {
                    _onTap(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GoogleMapsScreen extends StatefulWidget {
  @override
  _GoogleMapsScreenState createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  Set<Marker> _markers = {};
  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId('id-1'),
            position: LatLng(22.0548451989, 88.484981),
            infoWindow: InfoWindow(title: 'Damascus', snippet: 'AlMazeh')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps Screen title'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        markers: _markers,
        initialCameraPosition: CameraPosition(
          target: LatLng(22.0548451989, 88.484981),
          zoom: 15,
        ),
      ),
    );
  }
}
