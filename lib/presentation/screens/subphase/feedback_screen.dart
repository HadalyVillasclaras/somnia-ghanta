import 'package:flutter/material.dart';
import 'package:ghanta/config/constants/colors_theme.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.sizeOf(context).width * 0.12),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [Color(0xffc5f7f4), Color(0xffffffff)],
            stops: [0.25, 0.75],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          )),
          child: SafeArea(
            child: Column(
              children: [
                Text('¿Cómo te sientes hoy?', style: Theme.of(context).textTheme.headlineSmall!),
                SizedBox(height: 20),
                const FeedbackOptions(),
                SizedBox(height: 20),
                const FeedbackComment(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                  child: const Text('Guardar'),
                ),
              ],
            ),
          )),
    );
  }
}

class FeedbackComment extends StatelessWidget {
  const FeedbackComment({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: ColorsTheme.primaryColorBlue),
      ),
      child: Column(
        children: [
          //POnemos un text area
          Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              color: ColorsTheme.primaryColorBlue,
              child: Text(
                'Notas',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
              )),
          const TextField(
            maxLines: 5,
            decoration: InputDecoration(
              //Cambiamos el color de dentro
              // filled: true,
              // fillColor: Colors.white,
              hintText: '¿Quieres contarnos algo?',
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(10),
            ),
          ),
        ],
      ),
    );
  }
}

class FeedbackOptions extends StatefulWidget {
  const FeedbackOptions({
    super.key,
  });

  @override
  State<FeedbackOptions> createState() => _FeedbackOptionsState();
}

class _FeedbackOptionsState extends State<FeedbackOptions> {
  int _selected = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.25 + 90,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: 16,
        itemBuilder: (context, index) => Container(
          padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: _selected == index
                    ? ColorsTheme.primaryColorBlue
                    : Colors.transparent),
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                _selected = index;
              });
            },
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/icons/emotions/emoji-${index + 1}.png',
                fit: BoxFit.cover,
                width: 70,
                height: 70,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
