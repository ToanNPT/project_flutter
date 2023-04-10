import 'package:UdemyClone/main.dart';
import 'package:UdemyClone/notficationProvider/CartNotification.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../Screens/HomeScreens/MyList.dart';
import '../blocs/CartBloc.dart';

class MyAppbar extends AppBar{
  String screenName;
  MyAppbar({this.screenName});

  @override
  Widget build(BuildContext context) {
    return Center();
  }

}