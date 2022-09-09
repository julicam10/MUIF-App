import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:muif_app/widgets/drawer_conductor.dart';

import '../widgets/widgets.dart';

class HomeConductorPage extends StatefulWidget {
  const HomeConductorPage({Key? key}) : super(key: key);

  @override
  State<HomeConductorPage> createState() => _HomeConductorPageState();
}

class _HomeConductorPageState extends State<HomeConductorPage> {
  late GoogleMapController _mapController;
  final _initialCameraPosition = const CameraPosition(
    target: LatLng(4.342518, -74.361593),
    zoom: 16,
  );
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
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.route,
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
