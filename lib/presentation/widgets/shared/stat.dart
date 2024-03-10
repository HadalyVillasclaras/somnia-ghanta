

import 'package:flutter/material.dart';

class Stat extends StatelessWidget {
  const Stat(
      {super.key,
      required this.nombre,
      required this.color,
      required this.icono});

  final String nombre;
  final Color color;
  final IconData icono;

  @override
  Widget build(BuildContext context) {
    final sizes = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color.withOpacity(0.2),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Icon(
                icono,
                color: color,
                size: sizes.height * 0.07,
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: color.withOpacity(0.5)),
                  child: Text(
                    '10',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Text(
            nombre,
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
