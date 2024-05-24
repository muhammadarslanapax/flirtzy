import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/user/screens/user_splash_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseMessaging? messaging;
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

Future<void> backgroundNotification(RemoteMessage message) async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  log('Got a message whilst in the foreground!');
  log('Message data: ${message.data}');

  if (message.notification != null) {
    log('Message also contained a notification: ${message.notification}');
  }
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin?.initialize(
      const InitializationSettings(android: initializationSettingsAndroid),
      onDidReceiveBackgroundNotificationResponse: (message) {});
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    '0',
    'Flirtzy',
    channelDescription: 'hello',
    importance: Importance.max,
    icon: '@mipmap/ic_launcher',
    priority: Priority.high,
  );

  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );
  if (message != null) {
    await flutterLocalNotificationsPlugin?.show(
      message.hashCode,
      message.notification!.title.toString(),
      message.notification!.body.toString(),
      platformChannelSpecifics,
      payload: 'Custom_Sound',
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey =
      "pk_test_51IWywoSGE6fS01MG9U0usNXTW7BufqX1o2eFV4xAWSdTmZhrA7ixXV8EivBuGExwKZQHwH0hHtRvA2ASflY0fGIR00ol26LdEQ";

  hideStatusBar();

  /// Identity ///
  androidId = (await PlatformDeviceId.getDeviceId)!;
  log("Android ID :: $androidId");

  /// FCM_Token ///
  fcmToken = (await FirebaseMessaging.instance.getToken())!;
  log("FCM Tocken :: $fcmToken");
  FirebaseMessaging.onBackgroundMessage(backgroundNotification);

  SharedPreferences preferences = await SharedPreferences.getInstance();

  fetchBanner = preferences.getString("fetchBanner") == null
      ? {}
      : jsonDecode(preferences.getString("fetchBanner")!);

  fetchCountry = preferences.getString("fetchCountry") == null
      ? {}
      : jsonDecode(preferences.getString("fetchCountry")!);

  ///Real User Data ///
  userName = preferences.getString("getUserName") ?? "Flirtzy User";
  userGender = preferences.getString("userGender") ?? "Female";
  userBio = preferences.getString("getUserBio") ?? "I am Flirtzy user";
  userImage = preferences.getString("getUserImage") ?? AppImages.userProfile;
  userDob = preferences.getString("getUserDob") ?? "2023-03-10 11:02:15.252970";
  loginUserId = preferences.getString("loginUserId") ?? '';
  chatUserId = preferences.getString("chatUserId") ?? '';
  chatRoomId = preferences.getString("chatRoomId") ?? '';
  chatHostId = preferences.getString("chatHostId") ?? '';
  storyId = preferences.getString("storyId") ?? "";
  loginUserId = preferences.getString("loginUserId") ?? "";
  getLiveHostId = preferences.getString("getLiveHostId") ?? "";
  getLiveRoomId = preferences.getString("getLiveRoomId") ?? "";
  isHost = preferences.getBool("isHost") ?? false;
  userIsBlock = preferences.getBool("userIsBlock") ?? false;
  hostIsBlock = preferences.getBool("hostIsBlock") ?? false;
  isAppActive = preferences.getBool("isAppActive") ?? true;
  isOnline = preferences.getBool("isOnline") ?? true;
  userCoin.value = preferences.getString("userCoin") ?? "100";
  hostCoin.value = preferences.getString("hostCoin") ?? "100";

  log("loginUserId: $loginUserId");

  isOnBoarding = preferences.getBool("isOnBoarding") ?? true;
  isBottom = preferences.getBool("isBottom") ?? false;

  toysId = preferences.getString("toysId") ?? " ";
  loveId = preferences.getString("loveId") ?? " ";

  runApp(const MyApp());
}
///////// ================================

hideStatusBar() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.transparentColor,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final StreamController purchaseStreamController = StreamController<PurchaseDetails>.broadcast();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      theme: ThemeData(
        unselectedWidgetColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      getPages: [GetPage(name: "/", page: () => const UserSplashScreen())],
      debugShowCheckedModeBanner: false,
      // home:  const DemoScreen(),
    );
  }
}
