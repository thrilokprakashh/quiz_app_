import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app_june/dummy_db.dart';
import 'package:quiz_app_june/utils/animation_constent.dart';
import 'package:quiz_app_june/utils/color_constants.dart';
import 'package:quiz_app_june/view/quesitons_screen/results_screem/results_screen.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int questionIndex = 0;
  int rightAnsCount = 0;
  int? selectedAnswerIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.scaffoldBackgroundColor,
        actions: [
          Text(
            "${questionIndex + 1} / ${DummyDb.questionList.length}",
            style: TextStyle(
                color: ColorConstants.textColor,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          children: [
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
