import 'package:flutter/material.dart';

class Achievement extends StatelessWidget {
  const Achievement(
      {super.key,
      required this.nombre,
      required this.descripcion,
      required this.imagen, this.size});

  final String nombre;
  final String descripcion;
  final String imagen;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final sizes = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: CircleAvatar(
        radius: size ?? sizes.width * 0.20,
        backgroundColor: theme.brightness == Brightness.light
            ? theme.primary
            : const Color(0xFF06667C),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: -30,
              child: Icon(
                Icons.emoji_events,
                color: Colors.white.withOpacity(0.1),
                size: sizes.width * 0.4,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  nombre,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                ),
                Text(
                  descripcion,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}