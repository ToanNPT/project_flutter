import 'package:UdemyClone/Screens/HomeScreens/AccountInfo.dart';
import 'package:UdemyClone/Screens/HomeScreens/MyList.dart';
import 'package:UdemyClone/Screens/HomeScreens/WishList.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../blocs/CartBloc.dart';
import '../../blocs/ContentCourseBloc.dart';
import '../../blocs/ReviewCourseBloc.dart';
import '../../blocs/WishListBloc.dart';
import '../../notficationProvider/CartNotification.dart';
import '../ChangePasswordScreen.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Account"),
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              child: InkWell(
                child: Icon(EvaIcons.shoppingCartOutline),
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        child: MyList(),
                        type: PageTransitionType.leftToRightWithFade),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              width: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "ToanNPT",
                      style: TextStyle(fontSize: 24.0, color: Colors.white),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        EvaIcons.google,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        "toanpt08102001@gmail.com",
                        style: TextStyle(fontSize: 18.0, color: Colors.grey),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Become an Instructor",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.lightBlue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                "Video Preferences",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Account Info",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
              onTap: (){
                Get.to(AccountInfo());
              },
            ),
            ListTile(
              title: Text(
                "Change Your Password",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
              onTap: (){
                Get.to(ChangPasswordScreen());
              },
            ),
            ListTile(
              title: Text(
                "Your Course In Udemy",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
              onTap: (){
                Get.to(
                    MultiBlocProvider(
                      providers: [
                        BlocProvider<WishListBloc>(
                          create: (BuildContext context) => WishListBloc(),
                        ),
                        BlocProvider<CartBloc>(
                          create: (BuildContext context) => CartBloc(),
                        ),
                        BlocProvider<ReviewCourseBloc>(
                          create: (BuildContext context) => ReviewCourseBloc(),
                        ),
                      ],
                      child: ChangeNotifierProvider(
                        create: (context) => CartItemsCount(),
                        child: WishList(),
                      ),
                    )
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                "Support",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "About Udemy",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ),
            ListTile(
              title: Text(
                "About Udemy for Business",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ),
            ListTile(
              title: Text(
                "FAQs",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ),
            ListTile(
              title: Text(
                "Share Udemy App",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                "Diagonostics",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Status",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Center(
                child: MaterialButton(
                  onPressed: () async {},
                  child: Text(
                    "Sign Out",
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 17.0,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Text(
                  "Udemy v1.4",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
