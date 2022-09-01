// ignore_for_file: unnecessary_null_comparison, no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:muif_app/widgets/widgets.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = 'Home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class Person {
  final String id;
  final LatLng position;
  Person(this.id, this.position);
}

class _HomePageState extends State<HomePage> {
  late GoogleMapController _mapController;
  final Location _location = Location();
  late StreamSubscription<LocationData> subscription;
  late StreamSubscription<QuerySnapshot> documentSubscription;
  List<Person> people = [];
  final String routeNumber = '001';
  final String userId = Uuid().v1();
  final _initialCameraPosition = const CameraPosition(
    target: LatLng(4.342518, -74.361593),
    zoom: 16,
  );

  @override
  void initState() {
    super.initState();
    //_initLocation();
  }

  @override
  void dispose() {
    super.dispose();
    _removeLocation();
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
    // Sincronizar multiusuarios en el map
    Timer.periodic(const Duration(seconds: 20), (timer) {
      documentSubscription = FirebaseFirestore.instance
          .collection('route')
          .doc(routeNumber)
          .collection('people')
          .snapshots()
          .listen((event) {
        people = event.docs
            .map(
              (e) => Person(
                e.id,
                LatLng(e['lat'], e['lng']),
              ),
            )
            .toList();
        setState(() {});
      });
    });

    Timer.periodic(const Duration(seconds: 20), (timer) {
      subscription = _location.onLocationChanged.listen((LocationData event) {
        FirebaseFirestore.instance
            .collection('route')
            .doc('001')
            .collection('people')
            .doc(userId)
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
        .doc(userId)
        .delete();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: TitleText(
            color: Theme.of(context).colorScheme.secondary,
            size: 30,
            text: 'MUIF APP',
          ),
          centerTitle: true,
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: _removeLocation,
              icon: const Icon(
                Icons.highlight_remove_sharp,
                color: Colors.red,
              ),
            )
          ],
        ),
        drawer: const SideMenu(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                color: Colors.grey,
                child: GoogleMap(
                  initialCameraPosition: _initialCameraPosition,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: false,
                  markers: people
                      .map((e) => Marker(
                            markerId: MarkerId(e.id),
                            position: e.position,
                          ))
                      .toSet(),
                  onMapCreated: (controller) => _mapController = controller,
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              height:
                  size.height < 800 ? size.height * 0.025 : size.height * 0.07,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                border: Border.all(),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: GestureDetector(
                onVerticalDragStart: (_) => showModalBottomSheet(
                  enableDrag: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  context: context,
                  builder: (context) => const SheetWidget(),
                ),
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: 5,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
