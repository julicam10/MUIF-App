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
              Column(children: const [
                Center(
                  child: TitleText(
                    text: 'Producto destino',
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
