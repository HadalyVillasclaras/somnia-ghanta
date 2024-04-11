import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/config/constants/colors_theme.dart';
import 'package:ghanta/presentation/providers/feedback_provider.dart';

class FeedbackScreen extends ConsumerWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

@override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<FeedbackFormState>(feedbackProvider, (prev, next) {
      if (next.isSubmitted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Feedback"),
              content: Text(next.submissionMessage!),
              actions: <Widget>[
                FilledButton(
                  child: const Text("De acuerdo"),
                  onPressed: () {
                    ref.read(feedbackProvider.notifier).resetSubmission();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();

                  },
                ),
              ],
            );
          },
        );
      }
    });

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
                const SizedBox(height: 20),
                const FeedbackOptions(),
                const SizedBox(height: 20),
                const FeedbackComment(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                   await ref.read(feedbackProvider.notifier).submitFeedback(1);
                   //fetch userFeedback again to update calendar with new feedback
                   ref.invalidate(userFeedbackProvider);
                  },
                  style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                  child: const Text('Guardar'),
                ),
              ],
            ),
          )),
    );
  }
}

class FeedbackComment extends ConsumerStatefulWidget {
  const FeedbackComment({super.key});

  @override
  ConsumerState<FeedbackComment> createState() => _FeedbackCommentState();
}

class _FeedbackCommentState extends ConsumerState<FeedbackComment> {

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
          TextFormField(
            maxLines: 5,
             onChanged: (value) =>
                ref.read(feedbackProvider.notifier).onFeedbackChanged(value),
            decoration: InputDecoration(
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

class FeedbackOptions extends ConsumerStatefulWidget {
  const FeedbackOptions({
    super.key,
  });

  @override
  ConsumerState<FeedbackOptions> createState() => _FeedbackOptionsState();
}

class _FeedbackOptionsState extends ConsumerState<FeedbackOptions> {
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
              ref.read(feedbackProvider.notifier).onEmotionChanged(index);
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
