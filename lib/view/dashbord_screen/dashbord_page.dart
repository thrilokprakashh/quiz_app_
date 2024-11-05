import 'package:flutter/material.dart';
import 'package:quiz_app_june/controller/localdb.dart';

import 'package:quiz_app_june/utils/color_constants.dart';
import 'package:quiz_app_june/view/quesitons_screen/questions_screen.dart';

class DashbordPage extends StatefulWidget {
  const DashbordPage({super.key});

  @override
  State<DashbordPage> createState() => _DashbordPageState();
}

class _DashbordPageState extends State<DashbordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.scaffoldBackgroundColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi, John",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.textColor),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Let’s make this day productive",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: ColorConstants.textColor),
            ),
          ],
        ),
        actions: [
          CircleAvatar(
            radius: 27,
            backgroundColor: Colors.amber,
            child: Image(
              image: AssetImage("assets/images/happy.png"),
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: ColorConstants.questionsBgColor,
              ),
              height: 100,
              width: double.infinity,
              child: Row(
                children: [
                  SizedBox(
                    child: Image.asset(
                      "assets/images/trophy.png",
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                    children: [
                      Text(
                        "Ranking",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.textColor,
                            fontSize: 20),
                      ),
                      Text(
                        "348",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.scaffoldBackgroundColor,
                            fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(width: 30),
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: 1,
                          color: ColorConstants.textColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 23,
                  ),
                  SizedBox(
                    child: Image.asset(
                      "assets/images/coin.png",
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                    children: [
                      Text(
                        "Points",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.textColor,
                            fontSize: 20),
                      ),
                      Text(
                        "1209",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.scaffoldBackgroundColor,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Let's play",
                style: TextStyle(
                  color: ColorConstants.textColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 15,
                  ),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      if (index >= 0 && index < Localdb.categoryList.length) {
                        final category = Localdb.categoryList[index];
                        if (category['name'] != null &&
                            category['questionsList'] != null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuestionsScreen(),
                            ),
                          );
                        }
                      }
                    },
                    child: SizedBox(
                      height: 150,
                      width: 155,
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              height: 155,
                              width: 155,
                              decoration: BoxDecoration(
                                color: ColorConstants.questionsBgColor,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Localdb.categoryList[index]["name"],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstants.textColor,
                                    ),
                                  ),
                                  Text(
                                    '${Localdb.categoryList[index]["questions"]} Questions',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: ColorConstants.textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 15,
                            left: 34,
                            child: Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      Localdb.categoryList[index]["image"],
                                    ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  itemCount: Localdb.categoryList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
