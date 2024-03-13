import 'package:flutter/material.dart';

class SettingOptionWrapper extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback onBack;

  const SettingOptionWrapper({
    Key? key,
    required this.title,
    required this.child,
    required this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: onBack,
        // ),
        
        title: Text(title, style: Theme.of(context).textTheme.headlineLarge,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: child,
      ),
    );
  }
}