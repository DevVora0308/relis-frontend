import 'package:flutter/material.dart';
import 'package:relis/authentication/services.dart';
import 'package:relis/authentication/user.dart';
import 'package:relis/globals.dart';
import 'package:relis/widget/OnHover.dart';

class CreditsPage extends StatefulWidget {
  static const routeName = '/CreditsPage';

  @override
  _CreditsPageState createState() => _CreditsPageState();
}

class _CreditsPageState extends State<CreditsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        title: Text("Earn Credits"),
        backgroundColor: appBarBackgroundColor,
        shadowColor: appBarShadowColor,
        elevation: 2.0,
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  "Your ReLis Coins: ",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  " ${user!["credits"]??0} ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: view(),
      // LayoutBuilder(
      //   builder: (BuildContext context, BoxConstraints constraints) {
      //     if (constraints.maxWidth > 700) {
      //       return desktopView();
      //     } else {
      //       return mobileView();
      //     }
      //   },
      // ),
    );
  }

  Widget view() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: BoxConstraints.expand(
                height: Theme.of(context).textTheme.headline4!.fontSize! * 1.1 + 200.0,
              ),
              color: Colors.black87,
              alignment: Alignment.center,
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.center,
                spacing: 10.00,
                runSpacing: 20.00,
                direction: Axis.vertical,
                verticalDirection: VerticalDirection.down,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                children: <Widget>[
                  Text(
                    'ReLis Store',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                  Text(
                    'Shop in our store or redeem our products for free by using ReLisCoins',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.white54,
                      fontSize: MediaQuery.of(context).size.width * 0.028,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
              //color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Daily Missions
                  missionTitle("Check-in Missions"),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    runAlignment: WrapAlignment.spaceAround,
                    spacing: 60.00,
                    runSpacing: 20.00,
                    direction: Axis.horizontal,
                    verticalDirection: VerticalDirection.down,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    children: [
                      rewardItem("Daily Login", credits["dailyLogin"]!, achievedDailyLoginReward() ? "Collected" : "Collect", (){}),
                      rewardItem("Daily Read 'x' Pages", credits["dailyRead"]!, achievedDailyLoginReward() ? "Collected" : "Collect", (){}),
                      rewardItem("30-Days Streak Login", credits["dailyLoginStreak"]!, achievedDailyLoginStreakReward() ? "Collected" : "Collect", (){}),
                    ],
                  ),
                  // Profile Missions
                  missionTitle("Profile Missions"),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    runAlignment: WrapAlignment.spaceAround,
                    spacing: 60.00,
                    runSpacing: 20.00,
                    direction: Axis.horizontal,
                    verticalDirection: VerticalDirection.down,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    children: [
                      rewardItem("Complete Profile", credits["completeProfile"]!, achievedDailyLoginReward() ? "Collected" : "Collect", (){}),
                      rewardItem("Connect Facebook", credits["connectFacebook"]!, achievedDailyLoginReward() ? "Collected" : "Collect", (){}),
                      rewardItem("Connect Instagram", credits["connectInstagram"]!, achievedDailyLoginReward() ? "Collected" : "Collect", (){}),
                    ],
                  ),
                  //Other Missions and Redeem stuff
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget missionTitle(String missionName) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20.0, 0, 10.0),
      child: Text(
        missionName,
        style: Theme.of(context).textTheme.headline5!.copyWith(
          color: mainAppBlue,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  Widget rewardItem(String rewardMission, int points, String buttonText, Function collectCredits) {
    return OnHover(
      builder: (isHovered) {
        return Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width < 700 ? MediaQuery.of(context).size.width - 150 : 350,
          ),
          height: 150,
          // width: 350,
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.00)),
            color: mainAppBlue,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //Image of Coin
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      buttonText == "Collect" ? Icons.monetization_on_outlined : Icons.done_all_rounded,
                      color: Colors.yellow[600],
                      size: MediaQuery.of(context).size.width < 700 ? 45 : 65,
                    ),
                    Text(
                      '+$points',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Colors.yellow[600],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.center,
                    mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(5.0),
                        child: Text(
                          rewardMission,
                          style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      MaterialButton(
                        color: Colors.white,
                        padding: EdgeInsets.all(20.0),
                        splashColor: Color(0xff014b76),
                        elevation: 5.0,
                        onPressed: () async {
                          if(buttonText == "Collect")
                            await collectCredits();
                        },
                        child: Text(
                          buttonText,
                          style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: mainAppBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}