import 'package:cs310_app/utils/color.dart';
import 'package:cs310_app/utils/styles.dart';
import 'package:flutter/material.dart';


class WalkThrough extends StatefulWidget {
  @override
  _WalkThroughState createState() => _WalkThroughState();
}

class _WalkThroughState extends State {
  int currPage, totalPage;
  String currImage, currTitle, currPageTitle, currCaption, buttonText;

  List<String> imageList = [
    "https://www.webtekno.com/images/editor/default/0001/37/752a885428bdc269de40c63336a9536e1a9e5765.jpeg",
    "https://webhostreviewers.com/wp-content/uploads/2018/07/Free-Web-Hosting.jpg",
    "https://www.1mn.org/wp-content/uploads/2020/08/female-portrait-avatar-profile-woman-sexy-afro-2-512.png",
    "https://api.time.com/wp-content/uploads/2019/07/dating-apps.jpg"
  ];
  List<String> titleList = ["WELCOME", "INTRO", "PROFILES", "CONTENT"];
  List<String> pageTitlesList = [
    "Awesome Social Media App",
    "Fast Sign Up",
    "Create your profile",
    "Start meeting with people"
  ];

  List<String> captionList = [
    "Revolutionary social media app",
    "Easiest sign up mechanism",
    "And start adding your media now!",
    "Also view other peoples posts"
  ];

  List<String> buttonTextList = ["Next", "Next", "Next", "Finish"];

  @override
  void initState() {
    super.initState();
    currPage = 1;
    totalPage = 4;
    currImage = imageList[currPage - 1];
    currTitle = titleList[currPage - 1];
    currPageTitle = pageTitlesList[currPage - 1];
    currCaption = captionList[currPage - 1];
    buttonText = buttonTextList[currPage - 1];
  }

  void nextPage() {
    setState(() {
      currPage++;
      currImage = imageList[currPage - 1];
      currTitle = titleList[currPage - 1];
      currPageTitle = pageTitlesList[currPage - 1];
      currCaption = captionList[currPage - 1];
      buttonText = buttonTextList[currPage - 1];
    });
  }

  void prevPage() {
    setState(() {
      currPage--;
      currImage = imageList[currPage - 1];
      currTitle = titleList[currPage - 1];
      currPageTitle = pageTitlesList[currPage - 1];
      currCaption = captionList[currPage - 1];
      buttonText = buttonTextList[currPage - 1];
    });
  }

  void finishFunction() {
    if (buttonText == "Finish") {
      Navigator.pushNamed(context, '/welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text(currTitle, style: appBarStyle)),
        backgroundColor: AppColors.appBarColour,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(currPageTitle, style: mainTextStyle),
              Container(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(currImage),
                    backgroundColor: Color(0xFF229A98),
                  ),
                  width: 280.0,
                  height: 280.0),
              Text(
                currCaption,
                style: secondaryTextStyle,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    OutlinedButton(
                      style: buttonStyle,
                      onPressed: prevPage,
                      child: Text(
                        "Prev",
                        style: buttonTextStyle,
                      ),
                    ),
                    Text(
                      "$currPage/$totalPage",
                      style: secondaryTextStyle,
                    ),
                    OutlinedButton(
                      style: buttonStyle,
                      onPressed: () {
                        finishFunction();
                        nextPage();
                      },
                      child: Text(
                        buttonText,
                        style: buttonTextStyle,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
