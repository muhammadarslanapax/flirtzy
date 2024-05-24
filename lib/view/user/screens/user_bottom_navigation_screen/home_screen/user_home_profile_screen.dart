import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/chat/controller/create_chat_room_controller.dart';
import 'package:hokoo_flutter/Api_Service/model/host_thumb_list_model.dart';
import 'package:hokoo_flutter/demo_page.dart';
import 'package:hokoo_flutter/view/Chat_Screen/chat_screen.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/user/screens/user_bottom_navigation_screen/home_screen/user_profile_image_show_screen.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
import 'package:share/share.dart';
import 'package:shimmer/shimmer.dart';
import '../user_bottom_navigation_screen.dart';

class UserHomeProfileScreen extends StatefulWidget {
  final List<Host> hostData;
  final int index;
  final String token;
  final String channel;
  final String hostId;
  final String userId;

  const UserHomeProfileScreen({
    Key? key,
    required this.hostData,
    required this.index,
    required this.token,
    required this.channel,
    required this.hostId,
    required this.userId,
  }) : super(key: key);

  @override
  State<UserHomeProfileScreen> createState() => _UserHomeProfileScreenState();
}

class _UserHomeProfileScreenState extends State<UserHomeProfileScreen> {
  CreateChatRoomController createChatRoomController = Get.put(CreateChatRoomController());

  @override
  void initState() {
    createChatRoomController.createChatRoom(loginUserId, widget.hostId);
    super.initState();
  }

  double callRating = 0;

  @override
  Widget build(BuildContext context) {
    log("button is active :- $videoButtonIs");

    userprofileImageList.shuffle();
    SizeConfig().init(context);
    return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: WillPopScope(
          onWillPop: () async {
            selectedIndex = 0;
            Get.offAll(() => const UserBottomNavigationScreen());
            return false;
          },
          child: Container(
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
              decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage(AppImages.appBackground), fit: BoxFit.cover)),
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: AppColors.transparentColor,
                  body: Obx(() {
                    if (createChatRoomController.isLoading.value) {
                      return buildShimmer;
                    } else {
                      return buildData;
                    }
                  }))),
        ));
  }

  Column get buildData {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 3,
                  right: SizeConfig.blockSizeHorizontal * 3,
                  top: SizeConfig.blockSizeVertical * 5),
              height: SizeConfig.blockSizeVertical * 35,
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.hostData[widget.index].coverImage.toString()),
                    fit: BoxFit.cover),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        selectedIndex = 0;
                        Get.offAll(() => const UserBottomNavigationScreen());
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      )),
                  GestureDetector(
                      onTap: () {
                        Share.share(
                          "Hello Flirtzy",
                        );
                      },
                      child: const Icon(
                        Icons.share,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
            Container(
              height: SizeConfig.blockSizeVertical * 27,
              margin: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 5,
                  right: SizeConfig.blockSizeHorizontal * 5,
                  top: SizeConfig.blockSizeVertical * 27),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(3),
                        height: SizeConfig.blockSizeVertical * 14,
                        width: SizeConfig.blockSizeHorizontal * 28,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xffE5477A),
                                  Color(0xffE5477A),
                                  Color(0xffE5477A),
                                  Color(0xffE5477A),
                                  AppColors.appBarColor,
                                  AppColors.appBarColor,
                                ])),
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(widget.hostData[widget.index].image.toString()),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: Text(
                          widget.hostData[widget.index].name.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.blockSizeHorizontal * 5.8),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: Text(
                          "ID : 9876",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.blockSizeHorizontal * 3.5),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 0.7, left: 5),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 3),
                              padding: const EdgeInsets.all(5),
                              height: SizeConfig.blockSizeVertical * 3.5,
                              width: SizeConfig.blockSizeHorizontal * 13,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xff6C2D42),
                                  border: Border.all(width: 1, color: const Color(0xffD97998))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: SizeConfig.blockSizeHorizontal * 4,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(AppIcons.genderIcon), fit: BoxFit.fill)),
                                  ),
                                  Text("24",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: SizeConfig.blockSizeHorizontal * 3))
                                ],
                              ),
                            ),
                            Text(
                              widget.hostData[widget.index].country.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: SizeConfig.blockSizeVertical * 1.8),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: (widget.hostData[widget.index].status.toString() == "Online")
                        ? SizeConfig.blockSizeHorizontal * 18
                        : (widget.hostData[widget.index].status.toString() == "Busy")
                            ? SizeConfig.blockSizeHorizontal * 14
                            : (widget.hostData[widget.index].status.toString() == "Live")
                                ? SizeConfig.blockSizeHorizontal * 12
                                : SizeConfig.blockSizeHorizontal * 8.5,
                    child: Column(
                      children: [
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 8.5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  (widget.hostData[widget.index].status.toString() == "Online")
                                      ? AppColors.onlineColor
                                      : (widget.hostData[widget.index].status.toString() == "Busy")
                                          ? AppColors.busyColor
                                          : (widget.hostData[widget.index].status.toString() == "Live")
                                              ? AppColors.pinkColor
                                              : AppColors.transparentColor,
                              radius: 4.5,
                            ),
                            Text(
                              widget.hostData[widget.index].status.toString(),
                              style: TextStyle(
                                  color: (widget.hostData[widget.index].status.toString() == "Online")
                                      ? AppColors.onlineColor
                                      : (widget.hostData[widget.index].status.toString() == "Busy")
                                          ? AppColors.busyColor
                                          : (widget.hostData[widget.index].status.toString() == "Live")
                                              ? AppColors.pinkColor
                                              : Colors.transparent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.blockSizeHorizontal * 4.5),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 1.5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5),
              child: Text(
                "My Gallery",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffEB497E),
                    fontSize: SizeConfig.blockSizeVertical * 2.3),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1.5,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 60),
              height: SizeConfig.blockSizeVertical * 20,
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 10),
                scrollDirection: Axis.horizontal,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.hostData[widget.index].album!.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Get.to(
                        () => UserProfileFullImageScreen(
                            profileImage: widget.hostData[widget.index].album![index].toString()),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: SizeConfig.blockSizeHorizontal * 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image:
                                  NetworkImage(widget.hostData[widget.index].album![index].toString()),
                              fit: BoxFit.cover)),
                    ),
                  );
                },
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AbsorbPointer(
                absorbing: !videoButtonIs,
                child: GestureDetector(
                  onTap: (int.parse(userCoin.value) >= 20)
                      ? () {
                          if (widget.hostData[widget.index].status.toString() == "Busy") {
                            Get.snackbar(
                                borderRadius: 2,
                                isDismissible: true,
                                backgroundColor: Colors.black,
                                colorText: Colors.white,
                                dismissDirection: DismissDirection.horizontal,
                                duration: const Duration(seconds: 3),
                                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                snackPosition: SnackPosition.BOTTOM,
                                "Please Wait",
                                "${widget.hostData[widget.index].name.toString()} is on other call");
                          } else {
                            setState(() {
                              log("User calling on tap button");
                              videoButtonIs = false;
                              log("button is not active :- $videoButtonIs");
                              Future.delayed(const Duration(seconds: 5), () {
                                setState(() {
                                  videoButtonIs = true;
                                  log("button is active :- $videoButtonIs");
                                });
                              });
                            });
                            Get.to(() => DemoCall(
                                  receiverId: widget.hostData[widget.index].id.toString(),
                                  hostName: widget.hostData[widget.index].name.toString(),
                                  hostImage: widget.hostData[widget.index].image.toString(),
                                  callType: 'normal',
                                  videoCallType: 'user',
                                ));
                          }
                        }
                      : () {
                          Fluttertoast.showToast(
                            msg: "Insufficient Balance",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.SNACKBAR,
                            backgroundColor: Colors.black.withOpacity(0.35),
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 5),
                    height: SizeConfig.blockSizeVertical * 6,
                    width: SizeConfig.screenWidth * 0.53,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15), color: const Color(0xffF24A80)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppIcons.videoCallIcon,
                          color: Colors.white,
                          width: SizeConfig.blockSizeHorizontal * 7,
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 3,
                        ),
                        Text(
                          "Video Chat",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(),
              GestureDetector(
                onTap: () {
                  log("user id :: $loginUserId");
                  log("Host id $chatHostId");
                  Get.to(
                    () => ChatScreen(
                      hostName: widget.hostData[widget.index].name.toString(),
                      hostImage: widget.hostData[widget.index].image.toString(),
                      chatRoomId: createChatRoomController.createChatRoomData!.chatTopic!.id.toString(),
                      senderId:
                          createChatRoomController.createChatRoomData!.chatTopic!.userId.toString(),
                      receiverId:
                          createChatRoomController.createChatRoomData!.chatTopic!.hostId.toString(),
                      screenType: 'UserProfileScreen',
                      type: 1,
                      callType: 'user',
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 4),
                  height: SizeConfig.blockSizeVertical * 6,
                  width: SizeConfig.screenWidth * .35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 1, color: Colors.grey),
                      color: const Color(0xff2A2A2A)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        AppIcons.commentIcon,
                        color: Colors.white,
                        width: SizeConfig.blockSizeHorizontal * 6,
                      ),
                      Text(
                        "Say Hi",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Shimmer get buildShimmer {
    return Shimmer.fromColors(
        period: const Duration(milliseconds: 1100),
        baseColor: Colors.black38,
        highlightColor: Colors.grey.shade700,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 270,
              width: Get.width,
              color: AppColors.blackColor,
            ),
            const SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.blackColor,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 20,
                        width: 200,
                        color: AppColors.blackColor,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 20,
                        width: 180,
                        color: AppColors.blackColor,
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5),
                  height: 25,
                  width: 75,
                  color: AppColors.blackColor,
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 1.5,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 60),
                  height: SizeConfig.blockSizeVertical * 20,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(left: 10),
                    scrollDirection: Axis.horizontal,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          width: SizeConfig.blockSizeHorizontal * 30,
                          decoration: BoxDecoration(
                              color: AppColors.blackColor, borderRadius: BorderRadius.circular(10)),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 5),
                        height: SizeConfig.blockSizeVertical * 6,
                        width: SizeConfig.screenWidth * 0.53,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15), color: const Color(0xffF24A80))),
                  ),
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 4),
                      height: SizeConfig.blockSizeVertical * 6,
                      width: SizeConfig.screenWidth * .35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 1, color: Colors.grey),
                          color: const Color(0xff2A2A2A)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
