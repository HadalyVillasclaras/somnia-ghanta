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
        leadingWidth: 200,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start, 
          children: [
          TextButton.icon(
            onPressed: onBack,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
              size: 15,
            ),
            label: const Text('Volver', style: TextStyle(color: Colors.grey)),
          ),])
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineLarge,),
            child,
          ],
        ),
      ),
    );
  }
}