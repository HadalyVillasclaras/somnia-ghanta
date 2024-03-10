import 'package:flutter/material.dart';
import 'package:ghanta/config/constants/colors_theme.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';

class PopupActivity extends StatelessWidget {
  const PopupActivity({super.key, required this.pageController});

  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: const [PopupActivityStepOne()],
    );
  }
}

class PopupActivityStepOne extends StatefulWidget {
  const PopupActivityStepOne({super.key});

  @override
  State<PopupActivityStepOne> createState() => _PopupActivityStepOneState();
}

class _PopupActivityStepOneState extends State<PopupActivityStepOne> {
  int selectedPill = -1;

  @override
  Widget build(BuildContext context) {
    final List<String> nombres = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
    ];

    List<String> descripcionNombres = [
      'La A es la primera letra del abecedario',
      'La B es la segunda letra del abecedario',
      'La C es la tercera letra del abecedario',
      'La D es la cuarta letra del abecedario',
      'La E es la quinta letra del abecedario',
      'La F es la sexta letra del abecedario',
    ];

    return ActivityBody(
        //De child hacemos un grid de 3 columnas
        child: Column(
      children: [
        if (selectedPill != -1)
          PopupActivityModal(
            nombre: nombres[selectedPill],
            descripcion: descripcionNombres[selectedPill],
          ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 1.8),
            itemCount: nombres.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedPill = index;
                  });
                },
                child: PopupPill(
                  nombre: nombres[index],
                  isSelected: selectedPill == index,
                  descripcion: descripcionNombres[index],
                ),
              );
            },
          ),
        ),
      ],
    ));
  }
}

class PopupPill extends StatelessWidget {
  const PopupPill({
    super.key,
    required this.nombre,
    required this.isSelected,
    required this.descripcion,
  });

  final String nombre;
  final bool isSelected;
  final String descripcion;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: isSelected ? ColorsTheme.primaryColorBlue : Colors.white,
          borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Text(
          nombre,
          style: TextStyle(
              fontSize: 20,
              color: isSelected ? Colors.white : ColorsTheme.primaryColorBlue,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class PopupActivityModal extends StatelessWidget {
  const PopupActivityModal(
      {super.key, required this.nombre, required this.descripcion});

  final String nombre;
  final String descripcion;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: MediaQuery.sizeOf(context).width * 0.95,
      // height: MediaQuery.sizeOf(context).height * 0.23,
      constraints: BoxConstraints(
        minHeight: MediaQuery.sizeOf(context).height * 0.35,
        maxHeight: MediaQuery.sizeOf(context).height * 0.35,
      ),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ActivityTextBody(
            nombre,
            textAlign: TextAlign.center,
            isSmall: false,
          ),
          ActivityTextBody(
            descripcion,
            textAlign: TextAlign.center,
            isSmall: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: ColorsTheme.primaryColorBlue,
                ),
                child: const Text(
                  'Guardar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
