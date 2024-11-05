import 'package:flutter/material.dart';
import 'package:quiz_app_june/dummy_db.dart';
import 'package:quiz_app_june/utils/color_constants.dart';
import 'package:quiz_app_june/view/dashbord_screen/dashbord_page.dart';
import 'package:quiz_app_june/view/quesitons_screen/questions_screen.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key, required this.RightAnsCount});
  final int RightAnsCount;

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  int starCount = 0;
  calculateStarCount() {
    var percentage = (widget.RightAnsCount / DummyDb.questionList.length) * 100;

    if (percentage >= 80) {
      starCount = 3;
    } else if (percentage >= 50) {
      starCount = 2;
    } else if (percentage >= 30) {
      starCount = 1;
    } else {
      starCount = 0;
    }
  }

  @override
  void initState() {
    calculateStarCount();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => Padding(
                    padding: EdgeInsets.only(
                        left: 15, right: 15, bottom: index == 1 ? 30 : 0),
                    child: Icon(
                      Icons.star,
                      size: index == 1 ? 80 : 45,
                      color: index < starCount
                          ? ColorConstants.goldenYellowColor
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Congratulations",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.goldenYellowColor),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                " Your Score",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.textColor),
              ),
              Text(
                "${widget.RightAnsCount} / ${DummyDb.questionList.length}",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.textColor),
              ),
              SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionsScreen(),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorConstants.textColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.restart_alt),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Restart",
                        style: TextStyle(
                            color: ColorConstants.scaffoldBackgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashbordPage(),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorConstants.textColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.home),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                            color: ColorConstants.scaffoldBackgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
