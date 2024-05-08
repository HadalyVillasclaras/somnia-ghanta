import 'package:flutter/material.dart';
import 'package:ghanta/config/constants/colors_theme.dart';
import 'package:ghanta/domain/entities/activity.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';
import 'package:ghanta/presentation/widgets/activities/shared/activity_end_button.dart';

class PopupActivity extends StatelessWidget {
  const PopupActivity(
      {super.key, required this.pageController, required this.activity});

  final PageController pageController;
  final Activity activity;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: [
        ActivityIntroText(text: activity.descriptionEs),
        PopupActivityStepOne(
          activity: activity,
        )
      ],
    );
  }
}

class PopupActivityStepOne extends StatefulWidget {
  const PopupActivityStepOne({super.key, required this.activity});

  final Activity activity;

  @override
  State<PopupActivityStepOne> createState() => _PopupActivityStepOneState();
}

class _PopupActivityStepOneState extends State<PopupActivityStepOne> {
  int selectedPill = -1;

  @override
  Widget build(BuildContext context) {
    final List<String> nombres =
        widget.activity.popupData!.map((data) => data.titleTextEs).toList();
    final List<String> descripcionNombres =
        widget.activity.popupData!.map((data) => data.popupTextEs).toList();

    return ActivityBody(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (selectedPill != -1)
          PopupActivityModal(
              nombre: nombres[selectedPill],
              descripcion: descripcionNombres[selectedPill],
              onClose: () {
                setState(() {
                  selectedPill = -1;
                });
              }),
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
                  if (selectedPill == -1) {
                    setState(() {
                      selectedPill = index;
                    });
                  }
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
        const ActivityEndButton(isVisible: true),
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
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: isSelected ? ColorsTheme.primaryColorBlue : Colors.white,
          borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: Text(
          _formatTitle(nombre),
          style: TextStyle(
              color: isSelected ? Colors.white : ColorsTheme.primaryColorBlue,
              fontWeight: FontWeight.bold,
              fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

String _formatTitle(String title) {
  return title.length > 14 ? '${title.substring(0, 14)}...' : title;
}

class PopupActivityModal extends StatelessWidget {
  const PopupActivityModal({
    super.key,
    required this.nombre,
    required this.descripcion,
    required this.onClose,
  });

  final String nombre;
  final String descripcion;
  final VoidCallback onClose;

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
              onPressed: onClose,
              child: const Text('Ok'),
            ),
          )
        ],
      ),
    );
  }
}
