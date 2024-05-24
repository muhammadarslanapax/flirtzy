class Constant {
  ///////////// API \\\\\\\\\\\\

  static const key = "";                //Enter key :: H7t&hgug*6Jhccct$3JHVvjvJHVV
  static const baseUrl = "";              //Enter base URL :: https://abc.xyz.com
  static const baseUrl1 = "";             //Enter base URL 1 :: https://abc.xyz.com/
  static const queryUrl = "";         // Enter here query URL :: abc.xyz.com

  static const setting = "/setting";
  static const fetchCountry = "http://ip-api.com/json";
  static const globalCountry = "/flag";
  static const rating = "/ratting/rattingByUserToHost";

  //////////// User ////////////
  static const fetchUser = "/user/userProfile";
  static const getUser = "/user/userProfile";
  static const updateUser = "/user/userProfile";

  ///////////// Host /////////////
  static const fetchHost = "/host/login";
  static const fetchLiveHost = "/liveHost";
  static const getHost = "/host/hostProfile";
  static const updateHost = "/host/updateProfile";
  static const fetchHostThumbList = "/host/hostThumbList";
  static const hostStatus = "/host/isOnline";

  /////// Host Request //////
  static const hostRequest = "/request/newRequest";

  /////// Complain /////////
  /////// Complain /////////
  static const createComplain = "/complaint/create";
  static const getUserComplain = "/complaint/userComplaintList";
  static const getHostComplain = "/complaint/hostComplaintList";

  /////// Other //////////
  static const fetchBanner = "/banner";
  // static const getSetting = "/setting";
  static const getSetting = "/live";

  static const coinPlan = "/coinPlan/appPlan";

  /////// chat ///////

  static const createChatRoom = "/chatTopic/createRoom";
  static const createChat = "/chat/createChat";
  static const getOldChat = "/chat/getOldChat";
  static const chatThumbList = "/chatTopic/chatList";

  ////////// Story /////////
  static const createStory = "/story/create";
  static const createViewStory = "/story/view";
  static const storyView = "/ViewStory/create";
  static const getHostStory = "/story/hostStory";
  static const createUserViewStory = "/ViewStory/create";
  static const deleteStory = "/story/storyId";
  static const hostViceAllStory = "/story/hostWiseAllStory";

  ///////// video_call //////

  static const makeCall = "/history/makeCall";
  static const randomCall = "/random/match";

  ////// Gift //////////
  static const createGiftCategory = "/giftCategory/app";
  static const generateGift = "/gift/categoryWise";

  ///////////coin_plan//////
  static const coinHistory = "/coinPlan/createHistory";
  static const rechargeHistory = "/history/historyForUser";
  static const creditHistory = "/history/historyForUser";
  static const debitHistory = "/history/userDebit";

  //////////  sticker ////////////

  static const sticker = "/sticker";

  ///////////// Album /////////
  static const album = "/host/addAlbum";
  static const deleteAlbum = "/host/deleteAlbum";

  ///////////////  notification list///////////

  static const hostNotification = "/notification/hostList";
  static const userNotification = "/notification/userList";
  static const userUpdateNotification = "/notification/updateFCM";

  ///////////// redeem //////////

  static const createRedeem = "/redeem";
  static const withdraw = "/redeem/user";
  static const getWithdrawType = "/withdraw";
  static const getRedeemStatus = "/redeem/user";
  static const hostDebitHistory = "/redeem/debit";

  static const searchUser = "/chatTopic/userSearch";
  static const searchHost = "/chatTopic/hostSearch";
}
