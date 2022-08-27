import 'package:muif_app/models/utilities.dart';
import 'package:muif_app/widgets/widgets.dart';

import '../models/bar_code_text.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String barcodeScanRes = '0';
    return Drawer(
      elevation: 10.0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const _DrawerHeader(),
          const _ListTileMenu(
            icon: Icons.credit_card,
            text: 'Mis tarjetas',
            navegacion: '/tusTarjetas',
          ),
          const _ListTileMenu(
            icon: Icons.qr_code_2_rounded,
            text: 'Escanear código QR',
            navegacion: '/barCode',
          ),
          ListTile(
            leading: const Icon(
              Icons.wallet,
              color: Colors.black,
              size: 40.0,
            ),
            title: const TitleText(
                color: Colors.black, text: 'Monedero virtual', size: 20.0),
            onTap: () => Navigator.pushNamed(
              context,
              '/monederoVirtual',
              arguments: BarCodeText(barcodeScanRes),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: size.height < 800 ? size.height * 0.39 : size.height * 0.45,
              left: size.width < 390 ? size.width * 0.1 : size.width * 0.05,
              right: size.width < 390 ? size.width * 0.1 : size.width * 0.05,
            ),
            child: SizedBox(
              width: 100,
              child: BotonWidget(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                textColor: Theme.of(context).colorScheme.primary,
                text: 'Cerrar sesión',
                navigator: '/',
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
