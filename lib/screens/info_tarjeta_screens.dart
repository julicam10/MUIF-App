import 'package:muif_app/models/utilities.dart';
import 'package:muif_app/widgets/widgets.dart';

class InfoTarjetaPage extends StatefulWidget {
  const InfoTarjetaPage({Key? key}) : super(key: key);

  @override
  State<InfoTarjetaPage> createState() => _InfoTarjetaPageState();
}

class _InfoTarjetaPageState extends State<InfoTarjetaPage> {
  var cardMask = MaskTextInputFormatter(
      mask: '#### #### #### ####', filter: {"#": RegExp(r'[0-9]')});

  var dateMask =
      MaskTextInputFormatter(mask: '##/##', filter: {"#": RegExp(r'[0-9]')});

  var codeMask =
      MaskTextInputFormatter(mask: '###', filter: {"#": RegExp(r'[0-9]')});
  String nombre = '';
  String card = '';
  String fecha = '';
  String codigo = '';
  final formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final cardController = TextEditingController();
  final fechaController = TextEditingController();
  final codigoController = TextEditingController();

  @override
  void dispose() {
    nombreController.dispose();
    cardController.dispose();
    fechaController.dispose();
    codigoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

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
                  const TitleText(
                    text: 'Ingrese la información de la tarjeta',
                    color: Colors.black,
                    size: 20,
                  ),
                  _creditCard(context),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: _inputNombre(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: _inputCard(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 25.0),
                    child: Row(
                      children: [
                        Container(
                          child: _inputDate(),
                        ),
                        Container(
                          child: _inputCode(),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 200.0),
                    child: Hero(
                      tag: 'boton',
                      child: BotonWidget(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        textColor: Theme.of(context).colorScheme.primary,
                        text: 'Guardar',
                        navigator: '/home',
                      ),
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

  Padding _creditCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        height: 180,
        width: 300,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Stack(
          children: [
            const SizedBox(
              height: 700,
              width: 700,
              child: Image(
                image: AssetImage('assets/img/fondoTarjeta.png'),
                fit: BoxFit.cover,
                height: 500,
                color: Color.fromRGBO(255, 255, 255, 0.12),
                colorBlendMode: BlendMode.modulate,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 0.0),
                        child: SizedBox(
                          height: 80.0,
                          width: 80.0,
                          child: Image(
                            image: AssetImage('assets/img/creditCard.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 150.0, bottom: 45.0),
                        child: SizedBox(
                          height: 50.0,
                          width: 50.0,
                          child: Image(
                            image: AssetImage('assets/img/iconoTarjeta.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TitleText(
                    text: card == '' ? 'Número de tarjeta' : card,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 17.0,
                  ),
                  TitleText(
                    text: nombre == '' ? 'Nombre del titular' : nombre,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 17.0,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: TitleText(
                          text: fecha == '' ? 'Fecha' : fecha,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 17.0,
                        ),
                      ),
                      TitleText(
                        text: codigo == '' ? 'Código' : codigo,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 17.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _inputNombre() {
    return Container(
      height: 50,
      width: 350,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(50.0)),
      child: TextFormField(
        controller: nombreController,
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(fontSize: 20.0),
        onChanged: (nombreInput) {
          setState(() {
            nombre = nombreInput;
          });
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Su nombre',
        ),
      ),
    );
  }

  Container _inputCard() {
    return Container(
      height: 50,
      width: 350,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(50.0)),
      child: TextFormField(
        controller: cardController,
        inputFormatters: [cardMask],
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 20.0),
        onChanged: (cardInput) {
          setState(() {
            card = cardInput;
          });
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: '0000-0000-0000-0000',
        ),
      ),
    );
  }

  Container _inputDate() {
    return Container(
      height: 50,
      width: 150,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(50.0)),
      child: TextFormField(
        controller: fechaController,
        keyboardType: TextInputType.number,
        inputFormatters: [dateMask],
        style: const TextStyle(fontSize: 20.0),
        onChanged: (dateInput) {
          setState(() {
            fecha = dateInput;
          });
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'MM/YYYY',
        ),
      ),
    );
  }

  Container _inputCode() {
    return Container(
      height: 50,
      width: 150,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(50.0)),
      child: TextFormField(
        controller: codigoController,
        inputFormatters: [codeMask],
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 20.0),
        onChanged: (codeInput) {
          setState(() {
            codigo = codeInput;
          });
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: '***',
        ),
      ),
    );
  }
}
