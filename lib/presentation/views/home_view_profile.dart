import 'package:flutter/material.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';

class HomeProfileView extends StatelessWidget {
  const HomeProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              HomeProfileData(),
              SizedBox(
                height: 40,
              ),
              HomeProfileActivity(),
              SizedBox(
                height: 40,
              ),
              HomeProfileAchievements()
            ],
          ),
        ),
      ),
    );
  }
}





