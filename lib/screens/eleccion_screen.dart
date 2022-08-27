import '../models/utilities.dart';
import '../widgets/widgets.dart';

class EleccionPage extends StatefulWidget {
  const EleccionPage({Key? key}) : super(key: key);

  @override
  State<EleccionPage> createState() => _EleccionPageState();
}

class _EleccionPageState extends State<EleccionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    text: '¿De donde saldrá el dinero?',
                    color: Colors.black,
                    size: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 600.0),
                  child: Container(
                    height: 65,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: TitleText(
                        color: Theme.of(context).colorScheme.primary,
                        size: 20.0,
                        text: 'Lista de tarjetas del usuario',
                      ),
                    ),
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
