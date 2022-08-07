import 'package:flutter/material.dart';
import 'package:muif_app/models/utilities.dart';
import 'package:muif_app/widgets/widgets.dart';

class SheetWidget extends StatelessWidget {
  const SheetWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: ListView(
        children: [
          Column(
            children: [
              const _BarWidget(),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: _IconsWidgets(),
                    ),
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: _FirstRow(),
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
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: TitleText(
                    text: 'Horarios', color: Colors.black, size: 23.0),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                child: _InfoContainer(
                  ruta: 'Pampa - Terminal',
                  horarioSemana: '5:20 am - 7:40 pm',
                  horarioFinSemana: '5:25 am - 7:48 pm',
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                child: _InfoContainer(
                  ruta: 'Pampa - Terminal',
                  horarioSemana: '5:20 am - 7:40 pm',
                  horarioFinSemana: '5:25 am - 7:48 pm',
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                child: _InfoContainer(
                  ruta: 'Pampa - Terminal',
                  horarioSemana: '5:20 am - 7:40 pm',
                  horarioFinSemana: '5:25 am - 7:48 pm',
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
    return SizedBox(
      height: 170,
      width: 340,
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
              padding: const EdgeInsets.only(left: 15.0),
              child: TitleText(
                text: 'Lunes a sabado',
                color: Theme.of(context).colorScheme.primary,
                size: 15,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: NormalText(
                text: horarioSemana,
                color: Colors.grey.shade700,
                size: 15,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: TitleText(
                text: 'Domingos y festivos',
                color: Theme.of(context).colorScheme.primary,
                size: 15,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
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
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
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
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(
                text: 'Origen',
                color: Colors.grey.shade400,
                size: 14,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, top: 5.0),
                child:
                    NormalText(text: 'La Pampa', color: Colors.black, size: 19),
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
