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
      child: Column(
        children: [
          const BarWidget(),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: IconsWidgets(),
                ),
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: FirstRow(),
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
                    const SecondRow(),
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: TitleText(text: 'Horarios', color: Colors.black, size: 20.0),
          )
        ],
      ),
    );
  }
}

class BarWidget extends StatelessWidget {
  const BarWidget({
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

class FirstRow extends StatelessWidget {
  const FirstRow({
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

class SecondRow extends StatelessWidget {
  const SecondRow({
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
                Text(
                  'Pagar pasaje',
                  style: GoogleFonts.sourceSerifPro(
                    color: const Color(0xFF3D73DD),
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
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

class IconsWidgets extends StatelessWidget {
  const IconsWidgets({
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
