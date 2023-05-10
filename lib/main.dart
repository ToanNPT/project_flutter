import 'package:UdemyClone/Screens/HomeScreens/HomeCourse.dart';
import 'package:UdemyClone/Screens/HomeScreens/WishList.dart';
import 'package:UdemyClone/Screens/LearningScreen.dart';
import 'package:UdemyClone/Screens/SignInOptions/Login_Screen.dart';
import 'package:UdemyClone/Services/PrefStorage.dart';
import 'package:UdemyClone/blocs/CartBloc.dart';
import 'package:UdemyClone/blocs/ContentCourseBloc.dart';
import 'package:UdemyClone/blocs/CoursesBloc.dart';
import 'package:UdemyClone/blocs/GirdCourseBloc.dart';
import 'package:UdemyClone/states/CourseState.dart';
import 'package:UdemyClone/widgets/SlidableCourseItem.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PrefStorage.init();
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        title: 'Udemy Clone',
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider<CoursesBloc>(
              create: (BuildContext context) => CoursesBloc(),
            ),
            BlocProvider<GridCoursesBloc>(
              create: (BuildContext context) => GridCoursesBloc(),
            ),
            BlocProvider<ContentCourseBloc>(
              create: (BuildContext context) => ContentCourseBloc(),
            )

          ],
          child: LoginScreen(),
        )
      //home: WishList(),
    );
  }
}
