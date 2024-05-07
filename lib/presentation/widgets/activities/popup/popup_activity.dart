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
      children: const [
        ActivityIntroText(
            text:
                'Duis a lacus convallis, sagittis erat nec, lobortis urna. Fusce ac risus malesuada, consectetur magna et, scelerisque felis. Phasellus laoreet scelerisque facilisis. Duis luctus sollicitudin semper. Aenean viverra enim eget enim euismod, vitae aliquet libero semper.'),
        PopupActivityStepOne()
      ],
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
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer ac commodo est, non lobortis lectus.',
      'Integer ac commodo est, non lobortis lectus.',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer ac commodo est, non lobortis lectus.',
      'Integer ac commodo est, non lobortis lectus.',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer ac commodo est, non lobortis lectus.',
      'Integer ac commodo est, non lobortis lectus.',
    ];

    return ActivityBody(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (selectedPill != -1)
          PopupActivityModal(
            nombre: nombres[selectedPill],
            descripcion: descripcionNombres[selectedPill],
          ),
        const SizedBox(height: 30),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
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
         Row(
          mainAxisAlignment: MainAxisAlignment.end,
           children: [
             FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.background,
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.fromLTRB(15, 2, 0, 2)),
                    onPressed: () {
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Seguir'),
                        SizedBox(width: 4),
                        Icon(
                          Icons.chevron_right,
                          size: 40,
                        ),
                      ],
                    ),
                  ),
           ],
         ),
      ],
    );
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
      height: 8,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: isSelected ? ColorsTheme.primaryColorBlue : Colors.white,
          borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: Text(
          nombre,
          style: TextStyle(
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
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      width: MediaQuery.sizeOf(context).width * 0.95,
      constraints: BoxConstraints(
        minHeight: MediaQuery.sizeOf(context).height * 0.32,
        maxHeight: MediaQuery.sizeOf(context).height * 0.32,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ActivityTextBody(
            nombre,
            isSmall: false,
          ),
          ActivityTextBody(
            descripcion,
            isSmall: true,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Ok'),
            ),
          )
        ],
      ),
    );
  }
}
