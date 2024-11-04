import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app_june/dummy_db.dart';
import 'package:quiz_app_june/utils/animation_constent.dart';
import 'package:quiz_app_june/utils/color_constants.dart';
import 'package:quiz_app_june/view/quesitons_screen/results_screem/results_screen.dart';

class QuestionsScreen extends StatefulWidget {
  final CountDownController countDownController = CountDownController();
  QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int questionIndex = 0;
  int rightAnsCount = 0;
  int? selectedAnswerIndex;
  final int duration = 30;
  @override
  void initState() {
    super.initState();
    // Start the countdown timer when the screen is initialized
    widget.countDownController.start();
  }

  void onTimerComplete() {
    // Logic to handle what happens when the timer completes
    if (questionIndex < DummyDb.questionList.length - 1) {
      questionIndex++;
      selectedAnswerIndex = null; // Reset selected answer
      setState(() {});
      widget.countDownController
          .restart(); // Restart the countdown for the next question
    } else {
      // Navigate to the results screen if it's the last question
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsScreen(
            RightAnsCount: rightAnsCount,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 2, color: Colors.white54),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.white60),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: RoundedProgressBar(
                              style: RoundedProgressBarStyle(),
                              height: 10,
                              milliseconds: 100,
                              percent: (questionIndex + 1) /
                                  DummyDb.questionList.length *
                                  100,
                              theme: RoundedProgressBarTheme.yellow),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "${questionIndex + 1} / ${DummyDb.questionList.length}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 20,
            ),

            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: ColorConstants.questionsBgColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        DummyDb.questionList[questionIndex]["question"],
                        style: TextStyle(
                            color: ColorConstants.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 0,
                    right: 0,
                    child: CircularCountDownTimer(
                      duration: duration,
                      initialDuration: 0,
                      controller: widget.countDownController,
                      width: 50,
                      height: 50,
                      ringColor: ColorConstants.questionsBgColor,
                      ringGradient: null,
                      fillColor: ColorConstants.textColor,
                      fillGradient: null,
                      backgroundColor: Colors.black,
                      strokeWidth: 5.0,
                      strokeCap: StrokeCap.round,
                      textStyle: TextStyle(
                        fontSize: 20.0,
                        color: ColorConstants.textColor,
                        fontWeight: FontWeight.bold,
                      ),
                      isReverse: true,
                      isReverseAnimation: false,
                      onComplete:
                          onTimerComplete, // Call onComplete when timer finishes
                    ),
                  ),
                  if (selectedAnswerIndex ==
                      DummyDb.questionList[questionIndex]["answerIndex"])
                    Lottie.asset(AnimationConstent.rightAnsAnimation),
                ],
              ),
            ),
            Column(
                children: List.generate(
              DummyDb.questionList[questionIndex]["options"].length,
              (optionIndex) {
                var currentQuestion = DummyDb.questionList[questionIndex];

                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: InkWell(
                    onTap: () {
                      if (selectedAnswerIndex == null) {
                        selectedAnswerIndex = optionIndex;

                        setState(() {});
                        if (selectedAnswerIndex ==
                            DummyDb.questionList[questionIndex]
                                ["answerIndex"]) {
                          rightAnsCount++;
                        }
                      }
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: getColor(optionIndex),
                            width: 2,
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            currentQuestion["options"][optionIndex],
                            style: TextStyle(
                                color: ColorConstants.textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Icon(
                            Icons.circle_outlined,
                            color: ColorConstants.textColor,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            )),
            SizedBox(height: 20),

            // if answer selected  show next button
            if (selectedAnswerIndex != null)
              InkWell(
                onTap: () {
                  selectedAnswerIndex = null;
                  if (questionIndex < DummyDb.questionList.length - 1) {
                    questionIndex++;
                    setState(() {});
                  } else {
                    // navigate to result screen\
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultsScreen(
                          RightAnsCount: rightAnsCount,
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorConstants.textColor,
                  ),
                  child: Text(
                    "Next",
                    style: TextStyle(
                        color: ColorConstants.scaffoldBackgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  Color getColor(int currentOptionIndex) {
    if (selectedAnswerIndex != null &&
        currentOptionIndex ==
            DummyDb.questionList[questionIndex]["answerIndex"]) {
      return ColorConstants.rightAnswerColor;
    }

    if (selectedAnswerIndex == currentOptionIndex) {
      if (selectedAnswerIndex ==
          DummyDb.questionList[questionIndex]["answerIndex"]) {
        return ColorConstants.rightAnswerColor;
      } else {
        return ColorConstants.wrongAnswerColor;
      }
    } else {
      return ColorConstants.questionsBgColor;
    }
  }
}
