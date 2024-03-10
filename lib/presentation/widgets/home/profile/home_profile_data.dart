import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/infraestructure/_infraestructure.dart';
import 'package:ghanta/presentation/providers/_providers.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';

class HomeProfileData extends ConsumerWidget {
  const HomeProfileData({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final sizes = MediaQuery.of(context).size;
    final theme = Theme.of(context).colorScheme;
    final authProv = ref.watch(authProvider);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(20, 40, 20, 0),
          padding: const EdgeInsets.all(20),
          height: sizes.height * 0.3 + 40,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: theme.brightness == Brightness.light
                ? theme.primary
                : const Color(0xFF06667C),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Lang.of(context).home_profile_my_profile,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authProv.user!.name,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        authProv.user!.email,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),

              //Row con datos rachas, puntos y nivel
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stat(
                    nombre: Lang.of(context).home_profile_streak,
                    color: Colors.orange,
                    icono: Icons.local_fire_department,
                  ),
                  Stat(
                    nombre: Lang.of(context).home_profile_points,
                    color: Colors.yellow,
                    icono: Icons.star,
                  ),
                  Stat(
                    nombre: Lang.of(context).home_profile_level,
                    color: Colors.blueAccent,
                    icono: Icons.grade,
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: -30,
          right: 0,
          child: Image.asset(
            'assets/images/profile.png',
            height: sizes.height * 0.25,
            width: sizes.width * 0.7,
          ),
        ),
      ],
    );
  }
}