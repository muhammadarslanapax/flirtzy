import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/Fetch_Country/Global_Country/global_country_controller.dart';
import 'package:hokoo_flutter/Api_Service/chat/controller/create_chat_room_controller.dart';
import 'package:hokoo_flutter/Api_Service/controller/host_thumb_controller.dart';
import 'package:hokoo_flutter/Api_Service/gift/controller/create_gift_category_controller.dart';
import 'package:hokoo_flutter/Api_Service/story/controller/get_host_story_controller.dart';
import 'package:hokoo_flutter/Controller/carousal_controller.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/user/pages/live_host_grid.dart';
import 'package:hokoo_flutter/view/user/pages/story_view_page.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_lottie.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/settings/models/dummy_host_model.dart';
import 'package:hokoo_flutter/view/utils/widgets/gradient_text.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
import 'package:lottie/lottie.dart';
import 'package:scroll_page_view/pager/page_controller.dart';
import 'package:scroll_page_view/pager/scroll_page_view.dart';
import '../../../../../Api_Service/constant.dart';
import '../../../../../Api_Service/controller/fetch_banner_controller.dart';
import 'user_notification_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  CreateGiftCategoryController createGiftCategoryController = Get.put(CreateGiftCategoryController());
  FetchBannerController fetchBannerController = Get.put(FetchBannerController());
  HostThumbController hostThumbController = Get.put(HostThumbController());
  CreateChatRoomController createChatRoomController = Get.put(CreateChatRoomController());
  List<DummyHostModel> countryWiseUserList = [];
  PageController pageController = PageController(initialPage: 0);
  CarouselController controller = CarouselController();
  int initialIndex = 0;
  String selectedCountry = "Global";

  CarousalController carousalController = Get.put(CarousalController());
  GlobalCountryController globalCountryController = Get.put(GlobalCountryController());
  GetHostStoryController getHostStoryController = Get.put(GetHostStoryController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await createGiftCategoryController.createGift();
      await getHostStoryController.getHostStory(loginUserId);
      await globalCountryController.globalCountry();
      hostThumbController.fetchHostThumb(country);
    });

    super.initState();
  }

  Future _refresh() async {
    await Future.delayed(const Duration(seconds: 2));
    hostThumbController.fetchHostThumb(country);
    getHostStoryController.getHostStory(loginUserId);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(true);
        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              leadingWidth: SizeConfig.blockSizeHorizontal * 14,
              leading: Row(
                children: [
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 4,
                  ),
                  Image.asset(
                    AppIcons.appLogo,
                    height: 35,
                    width: 35,
                  ),
                ],
              ),
              title: GradientText(
                "Flirtzy",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: SizeConfig.blockSizeHorizontal * 7),
                gradient: const LinearGradient(colors: [AppColors.pinkColor, Color(0xff573777)]),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 13),
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                        ),
                        barrierColor: AppColors.appBarColor.withOpacity(0.8),
                        context: context,
                        isScrollControlled: true,
                        builder: (_) {
                          return StatefulBuilder(
                            builder: (BuildContext context, StateSetter setModelState) {
                              return NotificationListener<OverscrollIndicatorNotification>(
                                onNotification: (overscroll) {
                                  overscroll.disallowIndicator();
                                  return false;
                                },
                                child: DraggableScrollableSheet(
                                  expand: false,
                                  initialChildSize: 0.6,
                                  minChildSize: 0.1,
                                  maxChildSize: 0.8,
                                  builder: (BuildContext context, ScrollController scrollController) {
                                    return Container(
                                      decoration: const BoxDecoration(
                                          color: AppColors.scaffoldColor,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.symmetric(vertical: 20),
                                            height: 3.5,
                                            width: 70,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10), color: Colors.white),
                                          ),
                                          SizedBox(
                                            height: SizeConfig.blockSizeVertical * 52,
                                            child: ListView.separated(
                                              physics: const ScrollPhysics(),
                                              itemCount: globalCountryController.globalCountryData!.flag!.length,
                                              itemBuilder: (BuildContext context, int index) {
                                                return Padding(
                                                  padding: const EdgeInsets.only(bottom: 5, left: 20, top: 10),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      setState(() {
                                                        country = globalCountryController
                                                            .globalCountryData!.flag![index].name
                                                            .toString();
                                                      });
                                                      hostThumbController.fetchHostThumb(country);
                                                      Get.back();
                                                    },
                                                    child: Row(
                                                      children: [
                                                        (globalCountryController
                                                                    .globalCountryData!.flag![index].name
                                                                    .toString() ==
                                                                "Global")
                                                            ? Container(
                                                                margin: const EdgeInsets.only(left: 10),
                                                                height: 30,
                                                                width: 30,
                                                                decoration:
                                                                    const BoxDecoration(shape: BoxShape.circle),
                                                                child: SvgPicture.network(
                                                                  globalCountryController
                                                                      .globalCountryData!.flag![index].flag
                                                                      .toString(),
                                                                  fit: BoxFit.cover,
                                                                ),
                                                              )
                                                            : Container(
                                                                margin: const EdgeInsets.only(left: 5),
                                                                height: 25,
                                                                width: 40,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(3),
                                                                ),
                                                                child: SvgPicture.network(
                                                                  globalCountryController
                                                                      .globalCountryData!.flag![index].flag
                                                                      .toString(),
                                                                  fit: BoxFit.cover,
                                                                ),
                                                              ),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        Text(
                                                          globalCountryController
                                                                      .globalCountryData!.flag![index].name
                                                                      .toString()
                                                                      .length >
                                                                  30
                                                              ? "${globalCountryController.globalCountryData!.flag![index].name.toString().substring(0, 30)}..."
                                                              : globalCountryController
                                                                  .globalCountryData!.flag![index].name
                                                                  .toString(),
                                                          style:
                                                              const TextStyle(color: Colors.white, fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              separatorBuilder: (BuildContext context, int index) {
                                                return Padding(
                                                  padding: const EdgeInsets.only(
                                                    left: 18,
                                                    right: 25,
                                                  ),
                                                  child: Divider(
                                                    color: AppColors.lightPinkColor.withOpacity(0.1),
                                                    thickness: 1,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.pinkColor,
                          size: SizeConfig.blockSizeHorizontal * 7,
                        ),
                        Text(
                          country,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: SizeConfig.blockSizeHorizontal * 4,
                              color: AppColors.pinkColor),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const UserNotificationScreen());
                  },
                  child: Image.asset(
                    AppImages.noNotification,
                    width: SizeConfig.blockSizeHorizontal * 10,
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.black,
        body: Obx(() {
          if (hostThumbController.isLoading.value) {
            return Shimmer.fromColors(
                period: const Duration(milliseconds: 1100),
                baseColor: Colors.black,
                highlightColor: Colors.grey.shade700,
                child: SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: GridView.builder(
                    itemCount: 10,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, crossAxisSpacing: 5, childAspectRatio: 1, mainAxisSpacing: 5),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration:
                            BoxDecoration(color: AppColors.pinkColor, borderRadius: BorderRadius.circular(15)),
                        child: const Text("Flirtzy"),
                      );
                    },
                  ),
                ));
          } else {
            return NestedScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() {
                            if (getHostStoryController.hostStoryList.isNotEmpty) {
                              return SizedBox(
                                height: 115,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: const ClampingScrollPhysics(),
                                  child: ListView.builder(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    itemCount: getHostStoryController.hostStoryList.length,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (BuildContext context, int index) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              hostId =
                                                  getHostStoryController.hostStoryList[index].hostName.toString();
                                              Get.to(() => StoryViewPage(
                                                    storyList: getHostStoryController.hostStoryList,
                                                    index: index,
                                                  ));
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4),
                                              height: 70,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: (getHostStoryController
                                                                  .hostStoryList[index].hostStory![index].isView ==
                                                              false)
                                                          ? AppColors.pinkColor
                                                          : AppColors.grey,
                                                      width: 2),
                                                  image: DecorationImage(
                                                      image: NetworkImage(getHostStoryController
                                                          .hostStoryList[index].hostImage
                                                          .toString()),
                                                      fit: BoxFit.cover)),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 8.5),
                                            child: Text(
                                              getHostStoryController.hostStoryList[index].hostName.toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: SizeConfig.blockSizeVertical * 1.7),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            height: 0.2,
                                            width: Get.width,
                                            color: Colors.white.withOpacity(0.8),
                                            child: const Text("-"),
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
                        ],
                      ),
                    ),
                  ];
                },
                body: RefreshIndicator(
                  backgroundColor: Colors.black,
                  color: AppColors.pinkColor,
                  onRefresh: _refresh,
                  child: CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(
                          height: 160,
                          width: 100,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                          child: ScrollPageView(
                            controller: ScrollPageController(),
                            delay: const Duration(seconds: 5),
                            indicatorAlign: Alignment.bottomCenter,
                            indicatorColor: AppColors.grey,
                             indicatorPadding: EdgeInsets.only(bottom: 5),
                            checkedIndicatorColor: AppColors.pinkColor,
                            children: fetchBannerController.bannersImages.asMap().entries.map((e) {
                              log("Banner images :: ${Constant.baseUrl1 + e.value}");
                              return SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: CachedNetworkImage(
                                    imageUrl: Constant.baseUrl1 + e.value,
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high,
                                  ));
                            }).toList(),
                          ),
                        ).paddingSymmetric(horizontal: 10, vertical: 15),
                      ),
                      Obx(() {
                        if (hostThumbController.hostThumbList.isEmpty) {
                          return SliverToBoxAdapter(
                            child: Column(
                              children: [
                                SizedBox(height: SizeConfig.blockSizeVertical * 15),
                                Lottie.asset(AppLottie.notificationLottieTwo,
                                    repeat: true, reverse: false, width: SizeConfig.blockSizeHorizontal * 45),
                                Text(
                                  "No Data Found!!",
                                  style: TextStyle(
                                      color: const Color(
                                        0xffDF4D97,
                                      ),
                                      fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return SliverPadding(
                              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                              sliver: SliverGrid(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 12,
                                  childAspectRatio: 0.8,
                                ),
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    return OnlineHostGrid(
                                      hostData: hostThumbController.hostThumbList,
                                      index: index,
                                      createGiftCategoryModel:
                                          createGiftCategoryController.createGiftCategoryModel!,
                                    );
                                  },
                                  childCount: hostThumbController.hostThumbList.length,
                                ),
                              ));
                        }
                      })
                    ],
                  ),
                ));
          }
        }),
      ),
    );
  }

  void animateToSlide(int index) => controller.animateToPage(index);
}
