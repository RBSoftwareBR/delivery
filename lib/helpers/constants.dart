
import 'dart:io';

import 'package:delivery/controllers/user_controller.dart';
import 'package:delivery/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper.dart';

SharedPreferences? sp;
String notificationUrl = '';
String appName = 'Delivery';
bool isIOS = Platform.isIOS;
bool isWeb = false;
Usuario? localUser;
FirebaseAuth auth = FirebaseAuth.instance;
UserController usuarioController = UserController();
String baseApi = 'https://g9pra0pot8.execute-api.sa-east-1.amazonaws.com/prod/';

double kNotificatiopnBarHeight = isIOS ? 20 : 24;
double kScreenHeightWithAppBar(context, {double extra = 0}) {
  return isIOS
      ? (getAltura(context) * (.8827 - extra)) - 4
      : getAltura(context) * (.8827 - extra);
}