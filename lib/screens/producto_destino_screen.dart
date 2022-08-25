import '../models/utilities.dart';
import '../widgets/widgets.dart';

class ProductoDestinoPage extends StatefulWidget {
  const ProductoDestinoPage({Key? key}) : super(key: key);

  @override
  State<ProductoDestinoPage> createState() => _ProductoDestinoPageState();
}

class _ProductoDestinoPageState extends State<ProductoDestinoPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0.0,
          leading:
              BackArrowButton(color: Theme.of(context).colorScheme.secondary),
        ),
        body: Center(
          child: ListView(
            children: [
              Column(
                children: [
                  const Center(
                    child: TitleText(
                      text: 'Producto destino',
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Container(
                      height: 65,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const _CardMonederoVirtual(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 460.0),
                    child: BotonWidget(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      text: 'Continuar',
                      textColor: Theme.of(context).colorScheme.primary,
                      navigator: '/eleccion',
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardMonederoVirtual extends StatelessWidget {
  const _CardMonederoVirtual({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Image(
                image: AssetImage('assets/img/iconFlutter.png'),
              ),
            ),
          ),
          TitleText(
              text: 'Mi monedero virtual',
              color: Theme.of(context).colorScheme.primary,
              size: 20.0)
        ],
      ),
    );
  }
}
