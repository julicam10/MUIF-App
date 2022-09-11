import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muif_app/screens/admin_screen.dart';
import 'package:muif_app/screens/screens_screen.dart';

import '../models/user.dart';

class EleccioRolPage extends StatefulWidget {
  const EleccioRolPage({Key? key}) : super(key: key);

  @override
  State<EleccioRolPage> createState() => _EleccioRolPageState();
}

class _EleccioRolPageState extends State<EleccioRolPage> {
  @override
  Widget build(BuildContext context) {
    return contro();
  }
}

class contro extends StatefulWidget {
  contro();

  @override
  _controState createState() => _controState();
}

class _controState extends State<contro> {
  _controState();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  String rol = '';
  String email = '';
  String id = '';
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users') //.where('uid', isEqualTo: user!.uid)
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
    }).whenComplete(() {
      const CircularProgressIndicator();
      setState(() {
        email = loggedInUser.email.toString();
        rol = loggedInUser.rol.toString();
        id = loggedInUser.id.toString();
      });
    });
  }

  routing() {
    if (rol == 'pasajero') {
      return const HomePage();
    } else {
      return const HomeConductorPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    const CircularProgressIndicator();
    return routing();
  }
}
