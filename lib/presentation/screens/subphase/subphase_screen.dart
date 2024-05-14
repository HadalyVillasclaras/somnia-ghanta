import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/config/constants/colors_theme.dart';
import 'package:ghanta/domain/entities/subphase.dart';
import 'package:ghanta/presentation/providers/new_courses_provider.dart';
import 'package:ghanta/presentation/widgets/activities/shared/activity_base.dart';

class SubphaseScreen extends ConsumerWidget {
  const SubphaseScreen(
    {
      Key? key,
      required this.subphaseId,
      required this.phaseId
    })
    : super(key: key);

    final int subphaseId;
    final int phaseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final subphaseAsyncValue = ref.watch(subphaseProvider(subphaseId));

    return subphaseAsyncValue.when(
     loading: () => Scaffold(
      body: Container(
        color: theme.primary,  
        width: double.infinity,
        height: double.infinity,
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    ),
      error: (err, stack) => Scaffold(
        backgroundColor: theme.primary,
        body: const Center(child: Text('Ha habido un error al cargar la actividad')),
      ),
      data: (Subphase subphase) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            actions: const [CloseActivity()],
          ),
          body: ActivityBase(
              subphase: subphase,
        ));
      },
    );
  }
}
class CloseActivity extends StatelessWidget {
  const CloseActivity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('¿Estás seguro?'),
                content: const Text(
                    'Si sales ahora, perderás todo tu progreso en esta fase.'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancelar')),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text('Salir')),
                ],
              );
            },
          );
        },
        iconSize: 30,
        color: ColorsTheme.primaryColorBlue,
        icon: const Icon(Icons.close));
  }
}
