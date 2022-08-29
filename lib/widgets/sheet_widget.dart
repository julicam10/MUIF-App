import 'package:muif_app/models/utilities.dart';
import 'package:muif_app/widgets/widgets.dart';

class SheetWidget extends StatelessWidget {
  const SheetWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: 500,
      child: ListView(
        children: [
          Column(
            children: [
              const _BarWidget(),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height < 800
                      ? size.height * 0.06
                      : size.height * 0.03,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.height < 800
                            ? size.height * 0.005
                            : size.height * 0.01,
                      ),
                      child: const _IconsWidgets(),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: size.height < 800
                                ? size.height * 0.005
                                : size.height * 0.01,
                          ),
                          child: const _FirstRow(),
                        ),
                        Container(
                          height: 1.0,
                          width: 300.0,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        const _SecondRow(),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height < 800
                      ? size.height * 0.005
                      : size.height * 0.01,
                ),
                child: const TitleText(
                    text: 'Horarios', color: Colors.black, size: 23.0),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal:
                      size.width < 390 ? size.width / 30 : size.width / 30,
                  vertical: size.height < 800
                      ? size.height * 0.005
                      : size.height * 0.01,
                ),
                child: const _InfoContainer(
                  ruta: 'Pampa - Terminal',
                  horarioSemana: '5:20 am - 7:40 pm',
                  horarioFinSemana: '5:25 am - 7:48 pm',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal:
                      size.width < 390 ? size.width / 30 : size.width / 30,
                  vertical: size.height < 800
                      ? size.height * 0.005
                      : size.height * 0.01,
                ),
                child: const _InfoContainer(
                  ruta: 'Terminal - Pampa',
                  horarioSemana: '6:03 am - 7:43 pm',
                  horarioFinSemana: '6:03 am - 7:45 pm',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal:
                      size.width < 390 ? size.width / 30 : size.width / 30,
                  vertical: size.height < 800
                      ? size.height * 0.005
                      : size.height * 0.01,
                ),
                child: const _InfoContainer(
                  ruta: 'Terminal - Pekin',
                  horarioSemana: '5:38 am - 7:48 pm',
                  horarioFinSemana: '6:03 am - 7:48 pm',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoContainer extends StatelessWidget {
  const _InfoContainer({
    Key? key,
    required this.ruta,
    required this.horarioSemana,
    required this.horarioFinSemana,
  }) : super(key: key);

  final String ruta;
  final String horarioSemana;
  final String horarioFinSemana;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height < 800 ? size.height * 0.1 : size.height * 0.2,
      width: size.width < 390 ? size.width * 0.4 : size.width * 0.8,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            width: 1.0,
            color: Colors.black,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: TitleText(
                text: ruta,
                color: Colors.black,
                size: 18,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: size.width < 390 ? size.width * 0.02 : size.width * 0.04,
              ),
              child: TitleText(
                text: 'Lunes a sabado',
                color: Theme.of(context).colorScheme.primary,
                size: 15,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: size.width < 390 ? size.width * 0.025 : size.width * 0.05,
              ),
              child: NormalText(
                text: horarioSemana,
                color: Colors.grey.shade700,
                size: 15,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: size.width < 390 ? size.width * 0.02 : size.width * 0.04,
              ),
              child: TitleText(
                text: 'Domingos y festivos',
                color: Theme.of(context).colorScheme.primary,
                size: 15,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: size.width < 390 ? size.width * 0.025 : size.width * 0.05,
              ),
              child: NormalText(
                text: horarioFinSemana,
                color: Colors.grey.shade700,
                size: 15,
              ),
            ),
            Center(
              child: NormalText(
                text: 'Frecuencia: Pasa cada 10 minutos',
                color: Colors.grey.shade700,
                size: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BarWidget extends StatelessWidget {
  const _BarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        top: size.height < 800 ? size.height * 0.005 : size.height * 0.01,
      ),
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
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
    );
  }
}

class _FirstRow extends StatelessWidget {
  const _FirstRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: size.width < 390 ? size.width * 0.025 : size.width * 0.05,
              top: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(
                text: 'Origen',
                color: Colors.grey.shade400,
                size: 14,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left:
                      size.width < 390 ? size.width * 0.01 : size.width * 0.02,
                  top: 5.0,
                ),
                child: const NormalText(
                    text: 'La Pampa', color: Colors.black, size: 19),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 130.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(
                text: 'Tarifa única',
                color: Colors.grey.shade400,
                size: 14,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, top: 5.0),
                child: NormalText(
                    text: '1,850 COP', color: Colors.black, size: 19),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SecondRow extends StatelessWidget {
  const _SecondRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(
                  text: 'Destino',
                  color: Colors.grey.shade400,
                  size: 14,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 5.0),
                  child: NormalText(
                      text: 'Terminal', color: Colors.black, size: 19),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 130.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Text(
                    'Pagar pasaje',
                    style: GoogleFonts.sourceSerifPro(
                      color: const Color(0xFF3D73DD),
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _IconsWidgets extends StatelessWidget {
  const _IconsWidgets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.location_on,
          color: Color(0xFFDE1912),
          size: 30.0,
        ),
        Container(
          height: 30.0,
          width: 1.0,
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(
              style: BorderStyle.solid,
            ),
          ),
        ),
        const Icon(
          Icons.location_pin,
          color: Color(0xFF0aC24D),
          size: 30.0,
        ),
      ],
    );
  }
}
