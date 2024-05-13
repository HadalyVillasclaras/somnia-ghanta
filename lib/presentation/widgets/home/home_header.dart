import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/infraestructure/_infraestructure.dart';
import 'package:ghanta/presentation/providers/_providers.dart';

class HomeHeader extends ConsumerWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref ) {
    final textTheme = Theme.of(context).textTheme;
    final sizes = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    final authProv = ref.watch(authProvider);

    return Container(
      height: sizes.height * 0.50,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: colors.brightness == Brightness.dark
              ? const AssetImage('assets/images/bg-night.png')
              : const AssetImage('assets/images/bg-day.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Text(Lang.of(context).home_page_header_greeting(authProv.user!.name),
                style: textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
            const SizedBox(height: 10.0),
            Text(Lang.of(context).home_page_header_feelings, style: textTheme.bodyLarge!.copyWith(color: Colors.white)),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
