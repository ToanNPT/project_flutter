import 'package:UdemyClone/repository/AuthenRepository.dart';
import 'package:UdemyClone/repository/StorageRepository.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Core/Animation/Fade_Animation.dart';
import '../blocs/ContentCourseBloc.dart';
import '../blocs/CoursesBloc.dart';
import '../blocs/GirdCourseBloc.dart';
import '../models/ChangePassword.dart';
import '../ultis/constants.dart' as Constants;
import 'SignInOptions/Login_Screen.dart';

enum FormData { old, newpass, confirm }

class ChangPasswordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangPasswordScreen> {
  Color enabled = const Color.fromARGB(255, 63, 56, 89);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color(0xFF1F1A30);
  bool ispasswordev = true;

  FormData selected;

  TextEditingController oldPassword = new TextEditingController();
  TextEditingController newPassword = new TextEditingController();
  TextEditingController confirmPassword = new TextEditingController();
  AuthenRepository repository = new AuthenRepository();
  StorageRepository store = new StorageRepository();

  void onSubmit() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    var username = await store.readSecureData(Constants.USERNAME);
    ChangePassword payload = new ChangePassword(
        username: username,
        oldPwd: oldPassword.text,
        newPwd: newPassword.text,
        confirmPwd: confirmPassword.text);

    var res = await repository.changePass(payload);
    if (res) {
      Navigator.pop(context);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        title: 'Success',
        desc: 'Change password success, you must to login again',
        btnOkOnPress: () {
          Get.to(
             LoginScreen()
          );
        },
      )..show();
    } else {
      Navigator.pop(context);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        title: 'Error',
        desc: 'Oop! Try again, something was wrong',
        btnOkOnPress: () {},
      )..show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // elevation:ElevatedButton,
        // // centerTitle: false,
        // iconTheme: Page.appBarTheme,
      ),
      body: GestureDetector(
        // close keyboard on outside input tap
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },

        child: Builder(
          builder: (context) => ListView(
            padding: EdgeInsets.all(5),
            children: <Widget>[
              // header text
              Padding(
                padding: EdgeInsets.only(top: 30, left: 10, bottom: 10),
                child: Text('Change Password',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 36)),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 2.5),
                child: Text('Your Account',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 32,
                        fontStyle: FontStyle.italic)),
              ),

              SizedBox(
                height: 50,
              ),
              // password input
              FadeAnimation(
                delay: 1,
                child: Container(
                  width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: selected == FormData.old ? enabled : backgroundColor,
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    controller: oldPassword,
                    onTap: () {
                      setState(() {
                        selected = FormData.old;
                      });
                    },
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.security,
                        color: selected == FormData.old ? enabledtxt : deaible,
                        size: 20,
                      ),
                      hintText: 'Old Password',
                      hintStyle: TextStyle(
                          color:
                              selected == FormData.old ? enabledtxt : deaible,
                          fontSize: 12),
                    ),
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(
                        color: selected == FormData.old ? enabledtxt : deaible,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
              ),

              SizedBox(
                height: 40,
              ),

              Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10),
                  child: Text(
                    "Set up your new password",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic),
                  )),

              FadeAnimation(
                delay: 1,
                child: Container(
                  width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: selected == FormData.newpass
                        ? enabled
                        : backgroundColor,
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    controller: newPassword,
                    onTap: () {
                      setState(() {
                        selected = FormData.newpass;
                      });
                    },
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.security,
                        color:
                            selected == FormData.newpass ? enabledtxt : deaible,
                        size: 20,
                      ),
                      hintText: 'New Password',
                      hintStyle: TextStyle(
                          color: selected == FormData.newpass
                              ? enabledtxt
                              : deaible,
                          fontSize: 12),
                    ),
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(
                        color:
                            selected == FormData.newpass ? enabledtxt : deaible,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
              ),

              SizedBox(
                height: 15,
              ),
              // password input
              FadeAnimation(
                delay: 1,
                child: Container(
                  width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: selected == FormData.confirm
                        ? enabled
                        : backgroundColor,
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    controller: confirmPassword,
                    onTap: () {
                      setState(() {
                        selected = FormData.confirm;
                      });
                    },
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.security,
                        color:
                            selected == FormData.confirm ? enabledtxt : deaible,
                        size: 20,
                      ),
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(
                          color: selected == FormData.confirm
                              ? enabledtxt
                              : deaible,
                          fontSize: 12),
                    ),
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(
                        color:
                            selected == FormData.confirm ? enabledtxt : deaible,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
              ),
              // sign up button
              GestureDetector(
                onTap: () {},
                child: Text("Sign up",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        fontSize: 14)),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.green)),
                onPressed: () {
                  onSubmit();
                },
                child: const Text('Change'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
