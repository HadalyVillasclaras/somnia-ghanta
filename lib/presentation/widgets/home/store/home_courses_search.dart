import 'package:flutter/material.dart';
import 'package:ghanta/infraestructure/_infraestructure.dart';

class HomeCoursesSearch extends StatelessWidget {
  const HomeCoursesSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final sizes = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Container(
      height: sizes.height * 0.25,
      width: double.infinity,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20.0),
          Text(Lang.of(context).home_store_ready_to_enroll,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineMedium!.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              cursorColor: theme.colorScheme.onPrimary,
              style: theme.textTheme.labelLarge!.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
              decoration: InputDecoration(
                hintText: Lang.of(context).home_store_find_by_name,
                hintStyle: const TextStyle(
                  color: Colors.white,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                //Cambiar color del texto
              ),
            ),
          ),
        ],
      ),
    );
  }
}
