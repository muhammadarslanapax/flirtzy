import 'dart:async';
import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/controller/setting_controller.dart';
import 'package:hokoo_flutter/Api_Service/notification/user_notification/update_fcm/user_update_notification_controller.dart';
import 'package:hokoo_flutter/view/Chat_Screen/chat_screen.dart';
import 'package:hokoo_flutter/view/Live_Stream/participant.dart';
import 'package:hokoo_flutter/view/host/Host%20Home%20Screen/Video%20Call/host_in_coming_call_screen.dart';
import 'package:hokoo_flutter/view/host/Host%20Home%20Screen/host_notification_screen.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/home_screen/user_notification_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';

// ignore:library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/controller/fetch_host_controller.dart';
import 'package:hokoo_flutter/Api_Service/controller/fetch_user_controller.dart';
import 'package:hokoo_flutter/Api_Service/controller/get_user_controller.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/host/Host%20Bottom%20Navigation%20Bar/host_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/user_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/user/screens/user_login_screen.dart';
import 'package:hokoo_flutter/view/user/screens/user_on_boarding_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Host/Host Profile Screen/host_history_screen/host_history_screen.dart';

class UserSplashScreen extends StatefulWidget {
  const UserSplashScreen({Key? key}) : super(key: key);

  @override
  State<UserSplashScreen> createState() => _UserSplashScreenState();
}

class _UserSplashScreenState extends State<UserSplashScreen> with WidgetsBindingObserver {
  SettingController settingController = Get.put(SettingController());
  FetchUserController fetchUserController = Get.put(FetchUserController());
  GetUserController getUserController = Get.put(GetUserController());
  FetchHostController fetchHostController = Get.put(FetchHostController());
  UserUpdateNotificationController userUpdateNotificationController = Get.put(UserUpdateNotificationController());

  connect() async {
    socket = IO.io(Constant.baseUrl,
        IO.OptionBuilder().setTransports(['websocket']).setQuery({"globalRoom": loginUserId}).build());
    socket.connect();
    socket.onConnect((data) {
      print(" Socket Connected HostInComingCallScreen");
    });
    socket.on("callRequest", (data) {
      print("CallRequest Data :: $data");
      if (data["live"] == "live") {
      } else {
        if (bgcall.value) {
          log("==========================!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        } else {
          Get.to(
            () => HostInComingCallScreen(
              receiveCallData: data,
              name: data["callerName"],
              image: data["callerImage"],
              callId: data["callId"],
            ),
          );
        }
      }
    });
  }

  initFirebase() async {
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

    await messaging.getToken().then((value) {
      log("this is fcm token = $value");
    });

    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      setState(() {
        print("notificationVisit with start :- $notificationVisit");
        notificationVisit = !notificationVisit;
        print("notificationVisit with SetState :- $notificationVisit");
      });
      handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      log("this is event log :- $event");
      handleMessage(event);
    });

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        log('Got a message whilst in the foreground!');
        log('Message data: ${message.data}');

        if (message.notification != null) {
          log('Message also contained a notification: ${message.notification}');
        }
        const AndroidInitializationSettings initializationSettingsAndroid =
            AndroidInitializationSettings('@mipmap/ic_launcher');
        flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
        flutterLocalNotificationsPlugin
            ?.initialize(const InitializationSettings(android: initializationSettingsAndroid),
                onDidReceiveNotificationResponse: (payload) {
          log("payload is:- $payload");
          handleMessage(message);
        });
        _showNotificationWithSound(message);
      },
    );
  }

  Future<void> handleMessage(RemoteMessage message) async {
    String screenType = "";
    String callType = "";
    int type = 0;

    if (message.data['type'] == 'ADMIN' && message.data['loginType'] == 'user') {
      log("Admin user notification");
      Get.to(() => const UserNotificationScreen());
    } else if (message.data['type'] == 'ADMIN' && message.data['loginType'] == 'host') {
      log("Admin host notification");
      Get.to(() => const HostNotificationScreen());
    } else if (message.data['type'] == 'MESSAGE') {
      log("Notification Type is :-  ${message.data['type']}");

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("loginUserId", fetchUserController.userData!.user!.id.toString());
      preferences.setBool("isHost", fetchUserController.userData!.user!.isHost!);
      isHost = preferences.getBool("isHost")!;
      loginUserId = preferences.getString("loginUserId")!;

      if (isHost == true) {
        screenType = 'HostScreen';
        type = 0;
        callType = 'host';
      } else {
        screenType = 'UserScreen';
        type = 1;
        callType = 'user';
      }

      log("That is background chat log......");
      log("That is app terminated chat log......");
      log("host name is :-  ${message.data['name']}");
      log("chatRoomId is :-  ${message.data['topic']}");
      log("senderId is :-  ${message.data['_id']}");
      log("hostImage is :-  ${message.data['image']}");
      log("receiverId is :-  ${message.data['topic']}");
      log("screen type is :-  $screenType");
      log("type is :-  $type");
      log("callType is :-  $callType");

      Get.to(() => ChatScreen(
            hostName: message.data['name'],
            chatRoomId: message.data['topic'],
            senderId: loginUserId,
            hostImage: message.data['image'],
            receiverId: message.data['_id'],
            screenType: screenType,
            type: type,
            callType: callType,
          ));
    } else if (message.data['type'] == 'REDEEM') {
      log("Redeem notification is.....");
      Get.to(() => const HostHistoryScreen());
    } else {
      log("live streaming notification");

      Get.to(() => Participant(
            token: message.data['token'],
            channelName: message.data['channel'],
            clientRole: ClientRole.Audience,
            liveStreamingId: message.data['liveStreamingId'],
            hostname: message.data['name'],
            hostImage: message.data['image'],
            hostId: message.data['_id'],
          ));
    }
  }

  Future _showNotificationWithSound(RemoteMessage message) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      '0',
      'Flirtzy',
      channelDescription: 'hello',
      icon: 'mipmap/ic_launcher',
      importance: Importance.max,
      priority: Priority.high,
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin?.show(
      message.hashCode,
      message.notification!.body.toString(),
      message.notification!.title.toString(),
      platformChannelSpecifics,
      payload: 'Custom_Sound',
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initFirebase();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    // NotificationController.notificationActivity();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await settingController.setting();
      preferences.setBool("isAppActive", settingController.getSetting!.setting!.isAppActive!);
      isAppActive = preferences.getBool("isAppActive")!;

      coinPerDollarIs = settingController.getSetting!.setting!.coinPerDollar!.toString();

      print("Coin per dollar is :- $coinPerDollarIs");
      publishableKey = settingController.getSetting!.setting!.stripePublishableKey!;
      secretKey = settingController.getSetting!.setting!.stripeSecretKey!;
      razorPayKey = settingController.getSetting!.setting!.razorSecretKey!;
      googlePayIsActive = settingController.getSetting!.setting!.googlePlaySwitch!;
      razorPayIsActive = settingController.getSetting!.setting!.razorPaySwitch!;
      stripePayIsActive = settingController.getSetting!.setting!.stripeSwitch!;

      print("googlePayIsActive :- $googlePayIsActive");
      print("razorPayIsActive :- $razorPayIsActive");
      print("stripePayIsActive :- $stripePayIsActive");

      if (isAppActive) {
        await fetchUserController.fetchUser(0, fcmToken, androidId, "Flirtzy@gmail.com",
            (fetchCountry.isEmpty) ? "India" : fetchCountry["country"]);
        preferences.setBool("isHost", fetchUserController.userData!.user!.isHost!);
        preferences.setString("loginUserId", fetchUserController.userData!.user!.id.toString());
        preferences.setString("userCoin", fetchUserController.userData!.user!.coin.toString());
        preferences.setBool("userIsBlock", fetchUserController.userData!.user!.isBlock!);
        preferences.setString("userGender", fetchUserController.userData!.user!.gender!);
        preferences.setString("uniqueId", fetchUserController.userData!.user!.uniqueID!);
        isHost = preferences.getBool("isHost")!;
        userIsBlock = preferences.getBool("userIsBlock")!;
        loginUserId = preferences.getString("loginUserId")!;
        userCoin.value = preferences.getString("userCoin")!;
        userGender = preferences.getString("userGender")!;
        uniqueId = preferences.getString("uniqueId")!;
        if (isHost) {
          await fetchHostController.fetchHost(0, fcmToken, androidId, "Flirtzy@gmail.com",
              (fetchCountry["country"] == null) ? "india" : fetchCountry["country"]);
          preferences.setBool("hostIsBlock", fetchHostController.hostData!.host!.isBlock!);
          preferences.setString("userName", fetchHostController.hostData!.host!.name.toString());
          preferences.setString("userCoin", fetchHostController.hostData!.host!.coin.toString());
          preferences.setString("userImage", fetchHostController.hostData!.host!.image.toString());
          preferences.setString("getHostCoverImage", fetchHostController.hostData!.host!.coverImage.toString());
          preferences.setString("userBio", fetchHostController.hostData!.host!.bio.toString());
          preferences.setString("userGender", fetchHostController.hostData!.host!.gender.toString());
          preferences.setString("loginUserId", fetchHostController.hostData!.host!.id.toString());
          hostIsBlock = preferences.getBool("hostIsBlock")!;
          userName = preferences.getString("userName")!;
          userCoin.value = preferences.getString("userCoin")!;
          userImage = preferences.getString("userImage")!;
          hostCoverImage = preferences.getString("getHostCoverImage")!;
          userBio = preferences.getString("userBio")!;
          userGender = preferences.getString("userGender")!;
          loginUserId = preferences.getString("loginUserId")!;
        } else {
          await userUpdateNotificationController.userUpdateNotificationIs(loginUserId, fcmToken, "user");
        }

        connect();

        if (notificationVisit == false) {
          if (userIsBlock || hostIsBlock) {
          } else {
            if (isOnBoarding) {
              Get.offAll(() => const UserOnBoardingScreen());
            } else if (isBottom) {
              if (isHost) {
                Get.offAll(() => const HostBottomNavigationBarScreen());
              } else {
                Get.offAll(() => const UserBottomNavigationScreen());
              }
            } else {
              Get.offAll(() => const UserLoginScreen());
            }
          }
        }
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      log("Went to Background");
      bgcall.value = true;
    }
    if (state == AppLifecycleState.resumed) {
      log("Come back to Foreground");
      bgcall.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        if (settingController.isLoading.value) {
          return Container(
            decoration: const BoxDecoration(
                image: DecorationImage(fit: BoxFit.cover, image: AssetImage(AppImages.splashScreenBackground))),
            child: Column(
              children: [
                const Expanded(
                  child: Center(
                      child: Image(
                    image: AssetImage(AppImages.splashCenterImage),
                    height: 130,
                  )),
                ),
                Column(
                  children: const [
                    Text(
                      "Flirtzy",
                      style: TextStyle(color: AppColors.pinkColor, fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 13),
                      child: Text(
                        "Let's Hook up !",
                        style: TextStyle(color: AppColors.pinkColor, fontSize: 16),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        } else if (userIsBlock || hostIsBlock || isAppActive == false) {
          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                    image:
                        DecorationImage(fit: BoxFit.cover, image: AssetImage(AppImages.splashScreenBackground))),
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                          child: Image(
                        image: AssetImage(AppImages.splashCenterImage),
                        height: 130,
                      )),
                    ),
                    Column(
                      children: [
                        Text(
                          "Flirtzy",
                          style: TextStyle(color: AppColors.pinkColor, fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 13),
                          child: Text(
                            "Let's Hook up !",
                            style: TextStyle(color: AppColors.pinkColor, fontSize: 16),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Center(
                child: Container(
                  height: 230,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                          image: AssetImage(
                            AppImages.appBackground,
                          ),
                          fit: BoxFit.cover)),
                  alignment: Alignment.center,
                  child: const Text(
                    "App is Not Working Currently",
                    style: TextStyle(color: AppColors.lightPinkColor),
                  ),
                ),
              )
            ],
          );
        } else if (userIsBlock) {
          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                    image:
                        DecorationImage(fit: BoxFit.cover, image: AssetImage(AppImages.splashScreenBackground))),
                child: Column(
                  children: [
                    const Expanded(
                      child: Center(
                          child: Image(
                        image: AssetImage(AppImages.splashCenterImage),
                        height: 130,
                      )),
                    ),
                    Column(
                      children: const [
                        Text(
                          "Flirtzy",
                          style: TextStyle(color: AppColors.pinkColor, fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 13),
                          child: Text(
                            "Let's Hook up !",
                            style: TextStyle(color: AppColors.pinkColor, fontSize: 16),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Center(
                child: Container(
                  height: 350,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                          image: AssetImage(
                            AppImages.appBackground,
                          ),
                          fit: BoxFit.cover)),
                  alignment: Alignment.center,
                  child: const Text(
                    "You are Block By Admin",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          );
        } else if (hostIsBlock) {
          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                    image:
                        DecorationImage(fit: BoxFit.cover, image: AssetImage(AppImages.splashScreenBackground))),
                child: Column(
                  children: [
                    const Expanded(
                      child: Center(
                          child: Image(
                        image: AssetImage(AppImages.splashCenterImage),
                        height: 130,
                      )),
                    ),
                    Column(
                      children: const [
                        Text(
                          "Flirtzy",
                          style: TextStyle(color: AppColors.pinkColor, fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 13),
                          child: Text(
                            "Let's Hook up !",
                            style: TextStyle(color: AppColors.pinkColor, fontSize: 16),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Center(
                child: Container(
                  height: 350,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                          image: AssetImage(
                            AppImages.appBackground,
                          ),
                          fit: BoxFit.cover)),
                  alignment: Alignment.center,
                  child: const Text(
                    "You are Block By Admin",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          );
        } else if (settingController.getSetting!.message == "No data found!") {
          return Container(
            height: Get.height,
            width: Get.width,
            decoration: const BoxDecoration(
                image: DecorationImage(fit: BoxFit.cover, image: AssetImage(AppImages.splashScreenBackground))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(settingController.getSetting!.message.toString(),
                    style: const TextStyle(
                        color: AppColors.lightPinkColor, fontSize: 20, fontWeight: FontWeight.w600)),
              ],
            ),
          );
        } else {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  AppImages.splashScreenBackground,
                ),
              ),
            ),
            child: Column(
              children: [
                const Expanded(
                  child: Center(
                      child: Image(
                    image: AssetImage(AppImages.splashCenterImage),
                    height: 130,
                  )),
                ),
                Column(
                  children: const [
                    Text(
                      "Flirtzy",
                      style: TextStyle(color: AppColors.pinkColor, fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 13),
                      child: Text(
                        "Let's Hook up !",
                        style: TextStyle(color: AppColors.pinkColor, fontSize: 16),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }
      }),
    );
  }
}
