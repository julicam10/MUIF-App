import 'package:firebase_auth/firebase_auth.dart';
import 'package:muif_app/models/utilities.dart';
import 'package:muif_app/widgets/widgets.dart';

class SideMenuConductor extends StatelessWidget {
  const SideMenuConductor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Drawer(
      elevation: 10.0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const _DrawerHeader(),
          const _ListTileMenu(
            icon: Icons.history_edu_outlined,
            text: 'Consultar pagos',
            navegacion: '/consultarPagos',
          ),
          Padding(
            padding: EdgeInsets.only(
              top: size.height < 800 ? size.height * 0.45 : size.height * 0.60,
              left: size.width < 390 ? size.width * 0.1 : size.width * 0.05,
              right: size.width < 390 ? size.width * 0.1 : size.width * 0.05,
            ),
            child: SizedBox(
              width: 100,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.secondary,
                ),
                child: TitleText(
                  text: 'Cerrar sesión',
                  color: Theme.of(context).colorScheme.primary,
                  size: 20.0,
                ),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, '/iniciarSesion');
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ListTileMenu extends StatelessWidget {
  const _ListTileMenu({
    Key? key,
    required this.icon,
    required this.text,
    required this.navegacion,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final String navegacion;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.black,
        size: 40.0,
      ),
      title: TitleText(color: Colors.black, text: text, size: 20.0),
      onTap: () => Navigator.pushNamed(
        context,
        navegacion,
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
              ],
            )
          ],
        ),
      ),
    );
  }
}
