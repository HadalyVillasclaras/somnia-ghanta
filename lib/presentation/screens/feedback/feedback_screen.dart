import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/presentation/providers/feedback_provider.dart';

class FeedbackScreen extends ConsumerWidget {
  final int activityId;

  const FeedbackScreen({Key? key, required this.activityId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  WidgetsBinding.instance.addPostFrameCallback((_) {
    //     if (activityId == 0) {
    //       showDialog(
    //         context: context,
    //         builder: (BuildContext context) {
    //           return FeedbackDialog(
    //             parentContext: context,
    //             submissionMessage: "Se ha producido un error, por favor, inténtelo más tarde.",
    //             ref: ref,
    //           );
    //         },
    //       );
    //     }
    //   });

    final theme = Theme.of(context);
    ref.listen<FeedbackFormState>(feedbackProvider, (prev, next) {
      
      if (next.isSubmitted ) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return FeedbackDialog(
                parentContext: context,
                submissionMessage: next.submissionMessage!,
                hasError: next.hasError,
                ref: ref);
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
                Text('¿Cómo te sientes hoy?',
                    style: theme.textTheme.headlineSmall!),
                const SizedBox(height: 20),
                const FeedbackEmojis(), //emojis
                const SizedBox(height: 20),
                const FeedbackComment(), //notas
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await ref
                        .read(feedbackProvider.notifier)
                        .submitFeedback(activityId);
                    //fetch userFeedback again to update calendar with new feedback
                    ref.invalidate(userFeedbackProvider);
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50)),
                  child: const Text('Guardar'),
                ),
              ],
            ),
          )),
    );
  }
}

class FeedbackDialog extends StatelessWidget {
  final BuildContext parentContext;
  final String submissionMessage;
  final bool hasError;
  final WidgetRef ref;

  const FeedbackDialog({
    Key? key,
    required this.parentContext,
    required this.submissionMessage,
    required this.hasError,
    required this.ref,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Feedback", textAlign: TextAlign.center),
      surfaceTintColor: Colors.white,
      content: Text(submissionMessage, textAlign: TextAlign.center),
      actions: <Widget>[
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                child: const Text("Aceptar"),
                onPressed: () {
                  if (!hasError) {
                    Navigator.of(parentContext).pop();
                    Navigator.of(parentContext).pop();
                    Navigator.of(parentContext).pop();
                  } else {
                    Navigator.of(parentContext).pop();
                  }
                },
              ),
            ),
          ],
        ),
      ],
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
    final theme = Theme.of(context);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: theme.colorScheme.primary),
          color: Colors.white),
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              color: theme.colorScheme.primary,
              child: Text(
                'Notas',
                style: theme.textTheme.titleMedium!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
              )),
          TextFormField(
            style: const TextStyle(fontSize: 15),
            maxLines: 5,
            onChanged: (value) =>
                ref.read(feedbackProvider.notifier).onFeedbackChanged(value),
            decoration: const InputDecoration(
              hintText: 'Escribe tu diario',
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.all(10),
            ),
          ),
        ],
      ),
    );
  }
}

class FeedbackEmojis extends ConsumerStatefulWidget {
  const FeedbackEmojis({
    super.key,
  });

  @override
  ConsumerState<FeedbackEmojis> createState() => _FeedbackEmojisState();
}

class _FeedbackEmojisState extends ConsumerState<FeedbackEmojis> {
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
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            ref.read(feedbackProvider.notifier).onEmotionChanged(index);
            setState(() {
              _selected = index;
            });
          },
          child: Align(
            alignment: Alignment.center,
            child: Opacity(
              opacity: _selected == index ? 0.4 : 1.0,
              child: Image.asset(
                'assets/icons/emotions/emoji-${index + 1}.png',
                fit: BoxFit.contain,
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
