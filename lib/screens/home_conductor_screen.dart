// ignore_for_file: avoid_print

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:muif_app/widgets/drawer_conductor.dart';
import 'package:muif_app/widgets/title_widget.dart';

class HomeConductorPage extends StatefulWidget {
  const HomeConductorPage({Key? key}) : super(key: key);

  @override
  State<HomeConductorPage> createState() => _HomeConductorPageState();
}

class _HomeConductorPageState extends State<HomeConductorPage> {
  bool _switchCurrentValue = false;
  late GoogleMapController _mapController;
  final Location _location = Location();
  late StreamSubscription<LocationData> subscription;
  late StreamSubscription<QuerySnapshot> documentSubscription;
  final _initialCameraPosition = const CameraPosition(
    target: LatLng(4.342518, -74.361593),
    zoom: 16,
  );

  @override
  void initState() {
    super.initState();
  }

  _initLocation() async {
    var _serviceEnable = await _location.serviceEnabled();
    if (!_serviceEnable) {
      _serviceEnable = await _location.requestService();
      if (!_serviceEnable) {
        return;
      }
    }
    var _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('No Permission');
        return;
      }
    }
    //Compartir ubicación en tiempo real
    Timer.periodic(const Duration(seconds: 20), (timer) {
      subscription = _location.onLocationChanged.listen((LocationData event) {
        FirebaseFirestore.instance
            .collection('route')
            .doc('001')
            .collection('people')
            .doc('0001')
            .set({
          'lat': event.latitude,
          'lng': event.longitude,
        });
        print('${event.latitude}, ${event.longitude}');
      });
    });
  }

  _removeLocation() {
    if (documentSubscription != null) {
      documentSubscription.cancel();
    }
    if (subscription != null) {
      subscription.cancel();
    }
    FirebaseFirestore.instance
        .collection('route')
        .doc('001')
        .collection('people')
        .doc('0001')
        .delete();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(
          color: Theme.of(context).colorScheme.secondary,
          size: 20,
          text: 'MUIF APP CONDUCTOR',
        ),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          Switch(
            value: _switchCurrentValue,
            onChanged: (bool valueIn) {
              setState(() {
                _switchCurrentValue = valueIn;
                if (_switchCurrentValue == true) {
                  _initLocation();
                } else {
                  _removeLocation();
                }
              });
            },
          ),
          // IconButton(
          //   onPressed: ,
          //   icon: const Icon(
          //     Icons.route,
          //     color: Colors.white,
          //   ),
          // ),
        ],
      ),
      drawer: const SideMenuConductor(),
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
        // markers: people
        //     .map((e) => Marker(
        //           markerId: MarkerId(e.id),
        //           position: e.position,
        //         ))
        //     .toSet(),
        onMapCreated: (controller) => _mapController = controller,
      ),
    );
  }
}
