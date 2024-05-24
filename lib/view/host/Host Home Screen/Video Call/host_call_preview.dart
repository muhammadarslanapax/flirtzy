import 'dart:async';
import 'dart:developer';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/controller/setting_controller.dart';

import 'package:hokoo_flutter/Controller/video_timer_controller.dart';
import 'package:hokoo_flutter/view/Utils/Settings/app_images.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:hokoo_flutter/view/utils/settings/app_icons.dart';
import 'package:hokoo_flutter/view/utils/settings/app_variables.dart';
import 'package:hokoo_flutter/view/utils/widgets/size_configuration.dart';
// ignore:library_prefixes
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
// ignore:library_prefixes
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:shared_preferences/shared_preferences.dart';
// ignore:library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../../Api_Service/chat/controller/create_chat_room_controller.dart';
import '../../../../Controller/user_live_streaming_comment_profile_controller.dart';

class VideoCallScreen extends StatefulWidget {
  final String matchName;
  final String matchImage;
  final ClientRole clientRole;
  final String token;
  final String channelName;
  final String callId;
  final String videoCallType;
  final String? callType;
  final String? liveStatus;
  final String hostId;

  const VideoCallScreen({
    super.key,
    required this.matchName,
    required this.matchImage,
    required this.clientRole,
    required this.token,
    required this.channelName,
    required this.callId,
    this.callType,
    this.liveStatus,
    required this.videoCallType,
    required this.hostId,
  });

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> with SingleTickerProviderStateMixin {
  bool isVolume = true;
  final _users = <int>[];
  final infoString = <String>[];
  bool muted = false;
  bool viewPanel = false;
  late RtcEngine _engine;
  int user = 0;
  int host = 1;
  var dropdownValue = 1;
  int dropdownValue1 = 1;

  // String dropdownValue = '';
  var items = [
    1,
    5,
    10,
    15,
    20,
    25,
    30,
    35,
    40,
    45,
    50,
  ];

  TimerDataController timerDataController = Get.put(TimerDataController());
  SettingController settingController = Get.put(SettingController());

  UserLiveStreamingCommentProfile userLiveStreamingCommentProfile =
      Get.put(UserLiveStreamingCommentProfile());
  CreateChatRoomController createChatRoomController = Get.put(CreateChatRoomController());

  String gift = "";
  String countValueIs = "";
  bool showGif = false;
  double callRating = 4.0;

  @override
  void dispose() {
    _users.clear();
    _engine.leaveChannel();
    _engine.destroy();
    timerDataController.dispose();
    super.dispose();
  }

  Future<void> initialize() async {
    if (appId.isEmpty) {
      setState(() {
        infoString.add("appId is missing, Please provide your appId in app_variables.dart");
        infoString.add("Agora engine is not starting");
      });
      return;
    }
    _engine = await RtcEngine.create(appId);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(widget.clientRole);
    addAgoraEventHandlers();
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = const VideoDimensions(width: 1920, height: 1080);
    await _engine.setVideoEncoderConfiguration(configuration);
    await _engine.joinChannel(widget.token, widget.channelName, null, 0);
  }

  void addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(
      error: (code) {},
      joinChannelSuccess: (channel, uid, elapsed) {
        setState(() {
          final info = "Join Channel:$channel,uid:$uid";
          infoString.add(info);
        });
      },
      leaveChannel: (stats) {
        setState(() {
          infoString.add("Leave Channel");
          socket.emit("callDisconnect", {
            'callId': widget.callId,
          });
          _engine.destroy();
          _users.clear();
          selectedIndex = 0;
          Get.back();
        });
      },
      userJoined: (uid, elapsed) {
        setState(() {
          final info = "User Joined:$uid";
          infoString.add(info);
          _users.add(uid);
        });
      },
      userOffline: (uid, elapsed) {
        setState(() {
          final info = "User Offline:$uid";
          infoString.add(info);
          infoString.add("Leave Channel");
          socket.emit("callDisconnect", {
            'callId': widget.callId,
          });
          _engine.destroy();
          _users.remove(uid);
          selectedIndex = 0;
          Get.back();
        });
      },
      firstRemoteVideoFrame: (uid, width, height, elapsed) {
        setState(() {
          final info = "First Remote Video:$uid ${width}x$height";
          infoString.add(info);
        });
      },
    ));
  }

  Widget viewRows() {
    final List<StatefulWidget> list = [];
    if (widget.clientRole == ClientRole.Broadcaster) {
      list.add(const RtcLocalView.SurfaceView());
    }
    for (var uid in _users) {
      list.add(RtcRemoteView.SurfaceView(uid: uid, channelId: widget.channelName));
    }
    final views = list;
    log("VIEW'S LENGTH === ${views.length}");
    return Stack(
      children: [
        (views.length == 2)
            ? SizedBox(height: Get.height, width: Get.width, child: views[host])
            : Container(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            (views.length == 2)
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        host = host == 0 ? 1 : 0;
                        user = user == 1 ? 0 : 1;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 180,
                        width: 140,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: views[user],
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        host = host == 0 ? 1 : 0;
                        user = user == 1 ? 0 : 1;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 180,
                        width: 140,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              opacity: 0.4,
                              fit: BoxFit.cover,
                              image: NetworkImage(userImage),
                            )),
                      ),
                    ),
                  ),
          ],
        ),
      ],
    );
  }

  void connect() {
    log(widget.callId);
    log("Connect function called");
    socket = IO.io(
      Constant.baseUrl1,
      IO.OptionBuilder().setTransports(['websocket']).setQuery({"videoCallRoom": widget.callId}).build(),
    );
    socket.connect();
    socket.onConnect((data) {});

    socket.on("gift", (data) {
      setState(() {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString("userCoin", (data[1]["coin"]).toString());
          preferences.setString("hostCoin", (data[2]["coin"]).toString());
          userCoin.value = preferences.getString("userCoin")!;
          hostCoin.value = preferences.getString("hostCoin")!;
        });
        userCoin.value = "${data[1]["coin"]}";
        gift = "${Constant.baseUrl1}${data[0]["gift"]["image"]}";
        showGif = true;
        countValueIs = data[0]["countOfGift"];
      });
      Future.delayed(const Duration(seconds: 8)).then((value) {
        setState(() {
          dropdownValue = 1;
          showGif = false;
          countValueIs = "";
        });
      });
    });
  }

  @override
  void initState() {
    initialize();
    connect();
    settingController.setting();
    if (widget.videoCallType == "user") {
      if (widget.callType == "random") {
        Timer.periodic(const Duration(minutes: 1), (timer) {
          setState(() {
            log("Random Call :- ${widget.callType}");
            socket.on("callReceive", (data) async {
              SharedPreferences preferences = await SharedPreferences.getInstance();
              preferences.setString("userCoin", (data[0]["coin"]).toString());
              preferences.setString("hostCoin", (data[1]["coin"]).toString());
              userCoin.value = preferences.getString("userCoin")!;
              hostCoin.value = preferences.getString("hostCoin")!;
            });
            socket.emit("callReceive", {
              'callId': widget.callId,
              'callType': widget.callType,
              'coin': settingController.getSetting!.setting!.chargeForRandomCall,
              'live': (widget.liveStatus == "live") ? true : false,
            });
          });
        });
      } else {
        Timer.periodic(const Duration(minutes: 1), (timer) {
          setState(() {
            log("private Call :- ${widget.callType}");
            socket.on("callReceive", (data) async {
              SharedPreferences preferences = await SharedPreferences.getInstance();
              preferences.setString("userCoin", (data[0]["coin"]).toString());
              preferences.setString("hostCoin", (data[1]["coin"]).toString());
              userCoin.value = preferences.getString("userCoin")!;
              hostCoin.value = preferences.getString("hostCoin")!;
            });
            socket.emit("callReceive", {
              'callId': widget.callId,
              'callType': widget.callType,
              'coin': settingController.getSetting!.setting!.chargeForPrivateCall,
              'live': (widget.liveStatus == "live") ? true : false,
            });
          });
        });
        createChatRoomController.createChatRoom(loginUserId, widget.hostId);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SizedBox(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: SizedBox(
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
                child: Stack(
                  children: [
                    viewRows(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 15, top: 20),
                          height: 26,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.transparentColor,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.access_time_filled,
                                size: 18,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Obx(
                                () => Text(
                                  '${timerDataController.hours.toString().padLeft(2, '0')}:${timerDataController.minutes.toString().padLeft(2, '0')}:${timerDataController.seconds.toString().padLeft(2, '0')}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Center(
                          child: Container(
                            height: 75,
                            width: Get.width / 1.2,
                            decoration: BoxDecoration(
                              color: AppColors.appBarColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox.shrink(),
                                GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      _engine.destroy();
                                      _engine.leaveChannel();
                                      log("Call Disconnected Id Is :- ${widget.callId}");
                                      socket.emit("callDisconnect", {
                                        "callId": widget.callId,
                                      });
                                      selectedIndex = 0;
                                      Get.back();
                                    });
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.redColor,
                                    ),
                                    child: const Icon(Icons.call_end_outlined,
                                        color: Colors.white, size: 25),
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      _engine.switchCamera();
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        height: 50,
                                        width: 50,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.flipCameraColor,
                                        ),
                                        child: const ImageIcon(
                                          AssetImage(AppImages.flipCamera),
                                          color: Colors.white,
                                          size: 30,
                                        ))),
                                GestureDetector(
                                  onTap: () {
                                    log("On Tap Mic on and Off");
                                    setState(() {
                                      muted = !muted;
                                    });
                                    _engine.muteLocalAudioStream(muted);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.flipCameraColor,
                                    ),
                                    child: Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: (muted)
                                                ? const AssetImage(
                                                    AppIcons.micOff,
                                                  )
                                                : const AssetImage(
                                                    AppIcons.micOn,
                                                  )),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ).paddingOnly(bottom: 50),
                      ],
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
