import 'package:flutter/material.dart';
import 'package:ghanta/config/constants/colors_theme.dart';
import 'package:ghanta/domain/entities/activity.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

enum ActivityType { meditation, text, audio, tinder, popup, voiceRecorder }

class ActivityPagination extends StatefulWidget {

  const ActivityPagination({
    super.key,
    required this.pageController,
    required this.activity,
  });

  final Activity activity;
  final PageController pageController;

  @override
  State<ActivityPagination> createState() => _ActivityPaginationState();
}

class _ActivityPaginationState extends State<ActivityPagination> {
  bool _isFirstPage = true;
  bool _isLastPage = false;

   late ActivityType activityType;
 
  @override
  void initState() {
    super.initState();
    activityType = widget.activity.activityTypology;

    widget.pageController.addListener(() {
      setState(() {
        _isFirstPage =
            widget.pageController.page == widget.pageController.initialPage;
        _isLastPage = widget.pageController.page == _getPagesCount() - 1;
      });
    });
  }

  int _getPagesCount() {
    switch (activityType) {
      case ActivityType.meditation:
        return 6;
      case ActivityType.audio:
        return 2;
      case ActivityType.voiceRecorder:
        return 2;
      case ActivityType.tinder:
        return 2;
      case ActivityType.popup:
        return 2;
      case ActivityType.text:
        return _calculateTextPages(widget.activity.descriptionEs);
      default:
        return 0;
    }
  }

   int _calculateTextPages(String text) {
    return (text.length / 190).ceil();
  }

  @override
  void dispose() {
    // widget.pageController.removeListener(() { });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // if(_isFirstPage == false)
            AnimatedOpacity(
              opacity: _isFirstPage ? 0 : 1,
              duration: const Duration(milliseconds: 300),
              child: IconButton(
                onPressed: _isFirstPage
                  ? null
                  : () {
                    if (widget.pageController.page == 0) return;
                    widget.pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                    },
                icon: const Icon(Icons.arrow_back_ios)),
            ),
            SmoothPageIndicator(
              controller: widget.pageController,
              count: _getPagesCount(),
              effect: const SlideEffect(
                  dotColor: ColorsTheme.primaryColorBlue,
                  activeDotColor: ColorsTheme.primaryColorBlue,
                  dotHeight: 13,
                  dotWidth: 13,
                  spacing: 13,
                  paintStyle: PaintingStyle.stroke),
            ),
            // if(_isLastPage == false)
            AnimatedOpacity(
              opacity: _isLastPage ? 0 : 1,
              duration: const Duration(milliseconds: 300),
              child: IconButton(
                  onPressed: _isLastPage
                      ? null
                      : () {
                          if (widget.pageController.page ==
                              _getPagesCount() - 1) return;
                          widget.pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        },
                  icon: const Icon(Icons.arrow_forward_ios)),
            ),
          ],
        ),
      ),
    );
  }
}
