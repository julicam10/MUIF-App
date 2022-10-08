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
  late GoogleMapController _mapController;
  final Location _location = Location();
  late StreamSubscription<LocationData> subscription;
  final _initialCameraPosition = const CameraPosition(
    target: LatLng(4.342518, -74.361593),
    zoom: 16,
  );

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  @override
  void dispose() {
    super.dispose();
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
            //cambiar el número de la ruta
            .doc('569')
            // .collection('ubicacion')
            // .doc('ubicacion')
            .set({
          'lat': event.latitude,
          'lng': event.longitude,
        });
        print('${event.latitude}, ${event.longitude}');
      });
    });
  }

  _removeLocation() {
    subscription.cancel();
    FirebaseFirestore.instance
        .collection('route')
        .doc('001')
        .collection('people')
        //cambiar el número de la ruta
        .doc('569')
        .collection('ubicacion')
        .doc('ubicacion')
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
          IconButton(
            onPressed: () => openDialog(),
            icon: const Icon(
              Icons.location_disabled_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      drawer: const SideMenuConductor(),
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
        onMapCreated: (controller) => _mapController = controller,
      ),
    );
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('¿Desea terminar la ruta?'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
              child: const Text(
                'Aceptar',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                _removeLocation();
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
}
