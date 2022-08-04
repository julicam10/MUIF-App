import 'package:flutter/material.dart';
import 'package:muif_app/models/utilities.dart';
import 'package:muif_app/widgets/widgets.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10.0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const _DrawerHeader(),
          ListTile(
            leading: const Icon(
              Icons.credit_card,
              color: Colors.black,
              size: 40.0,
            ),
            title: const TitleText(
                color: Colors.black, text: 'Mis tarjetas', size: 20.0),
            onTap: (() {}),
          ),
          ListTile(
            leading: const Icon(
              Icons.qr_code_2_rounded,
              color: Colors.black,
              size: 40.0,
            ),
            title: const TitleText(
                color: Colors.black, text: 'Escanear código QR', size: 20.0),
            onTap: (() {}),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 400.0, left: 30.0, right: 30.0),
            child: SizedBox(
              width: 100,
              child: BotonWidget(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  textColor: Theme.of(context).colorScheme.primary,
                  text: 'Cerrar sesión',
                  navigator: '/'),
            ),
          )
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Text(
                  'Movilidad Urbana Inteligente Fusagasugá',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                // Image(
                //   image: AssetImage('assets/img/iconFlutter.png'),
                //   fit: BoxFit.contain,
                // )
              ],
            )
          ],
        ),
      ),
    );
  }
}
