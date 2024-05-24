import 'dart:developer';

import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/controller/fetch_host_controller.dart';
import 'package:hokoo_flutter/Api_Service/controller/fetch_user_controller.dart';
import 'package:hokoo_flutter/Controller/Google_Login/google_controller.dart';
import 'package:hokoo_flutter/view/Host/Host%20Bottom%20Navigation%20Bar/host_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/user_bottom_navigation_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/widgets/common_login_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  TextEditingController password = TextEditingController();
  FetchUserController fetchUserController = Get.put(FetchUserController());
  FetchHostController fetchHostController = Get.put(FetchHostController());
  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    log("==============================================================");
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    [
      Permission.camera,
      Permission.microphone,
    ].request();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (kDebugMode) {
      print("Build");
    }
    return GestureDetector(
      onTap: () => Get.focusScope?.unfocus(),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black,
          body: Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 20,
            ),
            height: height,
            width: width,
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(AppImages.loginModel), fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async {
                    await Fluttertoast.showToast(
                      msg: "Please Wait...",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.SNACKBAR,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black.withOpacity(0.35),
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                    await authController.signInWithGoogle();
                    if (authController.user != null) {
                      SharedPreferences preferences = await SharedPreferences.getInstance();
                      preferences.setBool("isBottom", true);
                      isBottom = preferences.getBool('isBottom')!;
                      if (isHost) {
                        await fetchHostController.fetchHost(
                            0, fcmToken, androidId, "Flirtzy@gmail.com", fetchCountry["country"]);
                        preferences.setString("userName", fetchHostController.hostData!.host!.name.toString());
                        preferences.setString("userBio", fetchHostController.hostData!.host!.bio.toString());
                        preferences.setString("userImage", fetchHostController.hostData!.host!.image.toString());
                        preferences.setString(
                            "getHostCoverImage", fetchHostController.hostData!.host!.coverImage.toString());
                        preferences.setString("loginUserId", fetchHostController.hostData!.host!.id.toString());
                        preferences.setString("userGender", fetchHostController.hostData!.host!.gender.toString());
                        userName = preferences.getString("userName")!;
                        userBio = preferences.getString("userBio")!;
                        userImage = preferences.getString("userImage")!;
                        hostCoverImage = preferences.getString("getHostCoverImage")!;
                        loginUserId = preferences.getString("loginUserId")!;
                        userGender = preferences.getString("userGender")!;
                        selectedIndex = 0;
                        Get.off(() => const HostBottomNavigationBarScreen());
                      } else {
                        await fetchUserController.fetchUser(1, fcmToken, androidId, authController.user!.email,
                            (fetchCountry.isEmpty) ? "India" : fetchCountry["country"]);
                        preferences.setString("getUserName", authController.user!.displayName.toString());
                        preferences.setString("getUserBio", fetchUserController.userData!.user!.bio.toString());
                        preferences.setString("getUserImage", authController.user!.photoUrl.toString());
                        preferences.setString("loginUserId", fetchUserController.userData!.user!.id.toString());
                        preferences.setString("userGender", fetchUserController.userData!.user!.gender.toString());
                        preferences.setString("uniqueId", fetchUserController.userData!.user!.uniqueID.toString());
                        userName = preferences.getString("getUserName")!;
                        userBio = preferences.getString("getUserBio")!;
                        userImage = preferences.getString("getUserImage")!;
                        loginUserId = preferences.getString("loginUserId")!;
                        userGender = preferences.getString("userGender")!;
                        uniqueId = preferences.getString("uniqueId")!;
                        selectedIndex = 0;
                        Get.off(() => const UserBottomNavigationScreen());
                      }
                    } else {
                      log("+++++++++++");
                      const Text("User Not Found");
                    }

                    /// ============================= \\\
                    // await Fluttertoast.showToast(
                    //   msg: "Please Wait...",
                    //   toastLength: Toast.LENGTH_SHORT,
                    //   gravity: ToastGravity.BOTTOM,
                    //   timeInSecForIosWeb: 1,
                    //   backgroundColor: Colors.black.withOpacity(0.35),
                    //   textColor: Colors.white,
                    //   fontSize: 16.0,
                    // );
                    // SharedPreferences preferences = await SharedPreferences.getInstance();
                    // preferences.setBool("isBottom", true);
                    // isBottom = preferences.getBool('isBottom')!;
                    // if (isHost) {
                    //   await fetchHostController.fetchHost(0, fcmToken, androidId,
                    //       "Flirtzy@gmail.com", fetchCountry["country"]);
                    //   preferences.setString(
                    //       "userName", fetchHostController.hostData!.host!.name.toString());
                    //   preferences.setString(
                    //       "userBio", fetchHostController.hostData!.host!.bio.toString());
                    //   preferences.setString("userImage",
                    //       fetchHostController.hostData!.host!.image.toString());
                    //   preferences.setString("getHostCoverImage",
                    //       fetchHostController.hostData!.host!.coverImage.toString());
                    //   preferences.setString(
                    //       "loginUserId", fetchHostController.hostData!.host!.id.toString());
                    //   preferences.setString("userGender",
                    //       fetchHostController.hostData!.host!.gender.toString());
                    //   userName = preferences.getString("userName")!;
                    //   userBio = preferences.getString("userBio")!;
                    //   userImage = preferences.getString("userImage")!;
                    //   hostCoverImage = preferences.getString("getHostCoverImage")!;
                    //   loginUserId = preferences.getString("loginUserId")!;
                    //   userGender = preferences.getString("userGender")!;
                    //   selectedIndex = 0;
                    //   Get.off(() => const HostBottomNavigationBarScreen());
                    // } else {
                    //   await fetchUserController.fetchUser(
                    //       0,
                    //       fcmToken,
                    //       androidId,
                    //       "Flirtzy@gmail.com",
                    //       (fetchCountry.isEmpty) ? "India" : fetchCountry["country"]);
                    //   preferences.setString("getUserName",
                    //       fetchUserController.userData!.user!.name.toString());
                    //   preferences.setString(
                    //       "getUserBio", fetchUserController.userData!.user!.bio.toString());
                    //   preferences.setString("getUserImage",
                    //       fetchUserController.userData!.user!.image.toString());
                    //   preferences.setString(
                    //       "loginUserId", fetchUserController.userData!.user!.id.toString());
                    //   preferences.setString("userGender",
                    //       fetchUserController.userData!.user!.gender.toString());
                    //   userName = preferences.getString("getUserName")!;
                    //   userBio = preferences.getString("getUserBio")!;
                    //   userImage = preferences.getString("getUserImage")!;
                    //   loginUserId = preferences.getString("loginUserId")!;
                    //   userGender = preferences.getString("userGender")!;
                    //   selectedIndex = 0;
                    //   Get.off(() => const UserBottomNavigationScreen());
                    // }
                  },
                  child: const CommonLoginButton(
                    icon: AppIcons.googleIcon,
                    title: "Login with gmail",
                    padding: 8,
                  ),
                ),
                quickLogin(context),

                /// Here host login buttton
                // hostLogin(context),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "By Signing up you will be agree to our",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Terms & Condition",
                      style: TextStyle(color: AppColors.pinkColor, fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    Text(
                      " and ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      "Privacy Policy",
                      style: TextStyle(color: AppColors.pinkColor, fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  CommonLoginButton quickLogin(BuildContext context) {
    return CommonLoginButton(
      onTap: () async {
        await Fluttertoast.showToast(
          msg: "Please Wait...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black.withOpacity(0.35),
          textColor: Colors.white,
          fontSize: 16.0,
        );
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool("isBottom", true);
        isBottom = preferences.getBool('isBottom')!;
        if (isHost) {
          await fetchHostController.fetchHost(
              0, fcmToken, androidId, "Flirtzy@gmail.com", fetchCountry["country"]);
          preferences.setString("userName", fetchHostController.hostData!.host!.name.toString());
          preferences.setString("userBio", fetchHostController.hostData!.host!.bio.toString());
          preferences.setString("userImage", fetchHostController.hostData!.host!.image.toString());
          preferences.setString("getHostCoverImage", fetchHostController.hostData!.host!.coverImage.toString());
          preferences.setString("loginUserId", fetchHostController.hostData!.host!.id.toString());
          preferences.setString("userGender", fetchHostController.hostData!.host!.gender.toString());
          userName = preferences.getString("userName")!;
          userBio = preferences.getString("userBio")!;
          userImage = preferences.getString("userImage")!;
          hostCoverImage = preferences.getString("getHostCoverImage")!;
          loginUserId = preferences.getString("loginUserId")!;
          userGender = preferences.getString("userGender")!;
          selectedIndex = 0;
          Get.off(() => const HostBottomNavigationBarScreen());
        } else {
          await fetchUserController.fetchUser(0, fcmToken, androidId, "Flirtzy@gmail.com",
              (fetchCountry.isEmpty) ? "India" : fetchCountry["country"]);
          preferences.setString("getUserName", fetchUserController.userData!.user!.name.toString());
          preferences.setString("getUserBio", fetchUserController.userData!.user!.bio.toString());
          preferences.setString("getUserImage", fetchUserController.userData!.user!.image.toString());
          preferences.setString("loginUserId", fetchUserController.userData!.user!.id.toString());
          preferences.setString("userGender", fetchUserController.userData!.user!.gender.toString());
          preferences.setString("uniqueId", fetchUserController.userData!.user!.uniqueID.toString());
          userName = preferences.getString("getUserName")!;
          userBio = preferences.getString("getUserBio")!;
          userImage = preferences.getString("getUserImage")!;
          loginUserId = preferences.getString("loginUserId")!;
          userGender = preferences.getString("userGender")!;
          uniqueId = preferences.getString("uniqueId")!;
          selectedIndex = 0;
          Get.off(() => const UserBottomNavigationScreen());
        }
      },
      icon: AppIcons.rocketIcon,
      title: "Quick Login",
      padding: 5,
    );
  }

  hostLogin(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Fluttertoast.showToast(
          msg: "Please Wait...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black.withOpacity(0.35),
          textColor: Colors.white,
          fontSize: 16.0,
        );
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool("isBottom", true);
        isBottom = preferences.getBool('isBottom')!;

        await fetchHostController.fetchHost(
            0, fcmToken, "qwerty12345", "Flirtzy@gmail.com", fetchCountry["country"]);
        preferences.setString("userName", fetchHostController.hostData!.host!.name.toString());
        preferences.setString("userBio", fetchHostController.hostData!.host!.bio.toString());
        preferences.setString("userImage", fetchHostController.hostData!.host!.image.toString());
        preferences.setString("getHostCoverImage", fetchHostController.hostData!.host!.coverImage.toString());
        preferences.setString("loginUserId", fetchHostController.hostData!.host!.id.toString());
        preferences.setString("userGender", fetchHostController.hostData!.host!.gender.toString());
        userName = preferences.getString("userName")!;
        userBio = preferences.getString("userBio")!;
        userImage = preferences.getString("userImage")!;
        hostCoverImage = preferences.getString("getHostCoverImage")!;
        loginUserId = preferences.getString("loginUserId")!;
        userGender = preferences.getString("userGender")!;
        selectedIndex = 0;
        Get.off(() => const HostBottomNavigationBarScreen());
      },
      child: const CommonLoginButton(
        icon: AppIcons.hostLogin,
        title: "Host Login",
        padding: 8,
      ),
    );
  }
}
