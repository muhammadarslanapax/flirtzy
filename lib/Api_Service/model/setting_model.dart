import 'dart:convert';

SettingModel settingModelFromJson(String str) => SettingModel.fromJson(json.decode(str));
String settingModelToJson(SettingModel data) => json.encode(data.toJson());

class SettingModel {
  SettingModel({
    bool? status,
    String? message,
    Setting? setting,
  }) {
    _status = status;
    _message = message;
    _setting = setting;
  }

  SettingModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _setting = json['setting'] != null ? Setting.fromJson(json['setting']) : null;
  }
  bool? _status;
  String? _message;
  Setting? _setting;
  SettingModel copyWith({
    bool? status,
    String? message,
    Setting? setting,
  }) =>
      SettingModel(
        status: status ?? _status,
        message: message ?? _message,
        setting: setting ?? _setting,
      );
  bool? get status => _status;
  String? get message => _message;
  Setting? get setting => _setting;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_setting != null) {
      map['setting'] = _setting?.toJson();
    }
    return map;
  }
}

Setting settingFromJson(String str) => Setting.fromJson(json.decode(str));
String settingToJson(Setting data) => json.encode(data.toJson());

class Setting {
  Setting({
    String? id,
    String? agoraKey,
    String? agoraCertificate,
    String? privacyPolicyLink,
    String? privacyPolicyText,
    String? termAndCondition,
    String? googlePlayEmail,
    String? googlePlayKey,
    bool? googlePlaySwitch,
    bool? stripeSwitch,
    String? stripePublishableKey,
    String? stripeSecretKey,
    bool? isAppActive,
    String? welcomeMessage,
    String? razorPayId,
    bool? razorPaySwitch,
    String? razorSecretKey,
    num? chargeForRandomCall,
    num? chargeForPrivateCall,
    num? coinPerDollar,
    num? coinCharge,
    List<String>? paymentGateway,
    String? redirectAppUrl,
    String? redirectMessage,
    num? withdrawLimit,
  }) {
    _id = id;
    _agoraKey = agoraKey;
    _agoraCertificate = agoraCertificate;
    _privacyPolicyLink = privacyPolicyLink;
    _privacyPolicyText = privacyPolicyText;
    _termAndCondition = termAndCondition;
    _googlePlayEmail = googlePlayEmail;
    _googlePlayKey = googlePlayKey;
    _googlePlaySwitch = googlePlaySwitch;
    _stripeSwitch = stripeSwitch;
    _stripePublishableKey = stripePublishableKey;
    _stripeSecretKey = stripeSecretKey;
    _isAppActive = isAppActive;
    _welcomeMessage = welcomeMessage;
    _razorPayId = razorPayId;
    _razorPaySwitch = razorPaySwitch;
    _razorSecretKey = razorSecretKey;
    _chargeForRandomCall = chargeForRandomCall;
    _chargeForPrivateCall = chargeForPrivateCall;
    _coinPerDollar = coinPerDollar;
    _coinCharge = coinCharge;
    _paymentGateway = paymentGateway;
    _redirectAppUrl = redirectAppUrl;
    _redirectMessage = redirectMessage;
    _withdrawLimit = withdrawLimit;
  }

  Setting.fromJson(dynamic json) {
    _id = json['_id'];
    _agoraKey = json['agoraKey'];
    _agoraCertificate = json['agoraCertificate'];
    _privacyPolicyLink = json['privacyPolicyLink'];
    _privacyPolicyText = json['privacyPolicyText'];
    _termAndCondition = json['termAndCondition'];
    _googlePlayEmail = json['googlePlayEmail'];
    _googlePlayKey = json['googlePlayKey'];
    _googlePlaySwitch = json['googlePlaySwitch'];
    _stripeSwitch = json['stripeSwitch'];
    _stripePublishableKey = json['stripePublishableKey'];
    _stripeSecretKey = json['stripeSecretKey'];
    _isAppActive = json['isAppActive'];
    _welcomeMessage = json['welcomeMessage'];
    _razorPayId = json['razorPayId'];
    _razorPaySwitch = json['razorPaySwitch'];
    _razorSecretKey = json['razorSecretKey'];
    _chargeForRandomCall = json['chargeForRandomCall'];
    _chargeForPrivateCall = json['chargeForPrivateCall'];
    _coinPerDollar = json['coinPerDollar'];
    _coinCharge = json['coinCharge'];
    _paymentGateway = json['paymentGateway'] != null ? json['paymentGateway'].cast<String>() : [];
    _redirectAppUrl = json['redirectAppUrl'];
    _redirectMessage = json['redirectMessage'];
    _withdrawLimit = json['withdrawLimit'];
  }
  String? _id;
  String? _agoraKey;
  String? _agoraCertificate;
  String? _privacyPolicyLink;
  String? _privacyPolicyText;
  String? _termAndCondition;
  String? _googlePlayEmail;
  String? _googlePlayKey;
  bool? _googlePlaySwitch;
  bool? _stripeSwitch;
  String? _stripePublishableKey;
  String? _stripeSecretKey;
  bool? _isAppActive;
  String? _welcomeMessage;
  String? _razorPayId;
  bool? _razorPaySwitch;
  String? _razorSecretKey;
  num? _chargeForRandomCall;
  num? _chargeForPrivateCall;
  num? _coinPerDollar;
  num? _coinCharge;
  List<String>? _paymentGateway;
  String? _redirectAppUrl;
  String? _redirectMessage;
  num? _withdrawLimit;
  Setting copyWith({
    String? id,
    String? agoraKey,
    String? agoraCertificate,
    String? privacyPolicyLink,
    String? privacyPolicyText,
    String? termAndCondition,
    String? googlePlayEmail,
    String? googlePlayKey,
    bool? googlePlaySwitch,
    bool? stripeSwitch,
    String? stripePublishableKey,
    String? stripeSecretKey,
    bool? isAppActive,
    String? welcomeMessage,
    String? razorPayId,
    bool? razorPaySwitch,
    String? razorSecretKey,
    num? chargeForRandomCall,
    num? chargeForPrivateCall,
    num? coinPerDollar,
    num? coinCharge,
    List<String>? paymentGateway,
    String? redirectAppUrl,
    String? redirectMessage,
    num? withdrawLimit,
  }) =>
      Setting(
        id: id ?? _id,
        agoraKey: agoraKey ?? _agoraKey,
        agoraCertificate: agoraCertificate ?? _agoraCertificate,
        privacyPolicyLink: privacyPolicyLink ?? _privacyPolicyLink,
        privacyPolicyText: privacyPolicyText ?? _privacyPolicyText,
        termAndCondition: termAndCondition ?? _termAndCondition,
        googlePlayEmail: googlePlayEmail ?? _googlePlayEmail,
        googlePlayKey: googlePlayKey ?? _googlePlayKey,
        googlePlaySwitch: googlePlaySwitch ?? _googlePlaySwitch,
        stripeSwitch: stripeSwitch ?? _stripeSwitch,
        stripePublishableKey: stripePublishableKey ?? _stripePublishableKey,
        stripeSecretKey: stripeSecretKey ?? _stripeSecretKey,
        isAppActive: isAppActive ?? _isAppActive,
        welcomeMessage: welcomeMessage ?? _welcomeMessage,
        razorPayId: razorPayId ?? _razorPayId,
        razorPaySwitch: razorPaySwitch ?? _razorPaySwitch,
        razorSecretKey: razorSecretKey ?? _razorSecretKey,
        chargeForRandomCall: chargeForRandomCall ?? _chargeForRandomCall,
        chargeForPrivateCall: chargeForPrivateCall ?? _chargeForPrivateCall,
        coinPerDollar: coinPerDollar ?? _coinPerDollar,
        coinCharge: coinCharge ?? _coinCharge,
        paymentGateway: paymentGateway ?? _paymentGateway,
        redirectAppUrl: redirectAppUrl ?? _redirectAppUrl,
        redirectMessage: redirectMessage ?? _redirectMessage,
        withdrawLimit: withdrawLimit ?? _withdrawLimit,
      );
  String? get id => _id;
  String? get agoraKey => _agoraKey;
  String? get agoraCertificate => _agoraCertificate;
  String? get privacyPolicyLink => _privacyPolicyLink;
  String? get privacyPolicyText => _privacyPolicyText;
  String? get termAndCondition => _termAndCondition;
  String? get googlePlayEmail => _googlePlayEmail;
  String? get googlePlayKey => _googlePlayKey;
  bool? get googlePlaySwitch => _googlePlaySwitch;
  bool? get stripeSwitch => _stripeSwitch;
  String? get stripePublishableKey => _stripePublishableKey;
  String? get stripeSecretKey => _stripeSecretKey;
  bool? get isAppActive => _isAppActive;
  String? get welcomeMessage => _welcomeMessage;
  String? get razorPayId => _razorPayId;
  bool? get razorPaySwitch => _razorPaySwitch;
  String? get razorSecretKey => _razorSecretKey;
  num? get chargeForRandomCall => _chargeForRandomCall;
  num? get chargeForPrivateCall => _chargeForPrivateCall;
  num? get coinPerDollar => _coinPerDollar;
  num? get coinCharge => _coinCharge;
  List<String>? get paymentGateway => _paymentGateway;
  String? get redirectAppUrl => _redirectAppUrl;
  String? get redirectMessage => _redirectMessage;
  num? get withdrawLimit => _withdrawLimit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['agoraKey'] = _agoraKey;
    map['agoraCertificate'] = _agoraCertificate;
    map['privacyPolicyLink'] = _privacyPolicyLink;
    map['privacyPolicyText'] = _privacyPolicyText;
    map['termAndCondition'] = _termAndCondition;
    map['googlePlayEmail'] = _googlePlayEmail;
    map['googlePlayKey'] = _googlePlayKey;
    map['googlePlaySwitch'] = _googlePlaySwitch;
    map['stripeSwitch'] = _stripeSwitch;
    map['stripePublishableKey'] = _stripePublishableKey;
    map['stripeSecretKey'] = _stripeSecretKey;
    map['isAppActive'] = _isAppActive;
    map['welcomeMessage'] = _welcomeMessage;
    map['razorPayId'] = _razorPayId;
    map['razorPaySwitch'] = _razorPaySwitch;
    map['razorSecretKey'] = _razorSecretKey;
    map['chargeForRandomCall'] = _chargeForRandomCall;
    map['chargeForPrivateCall'] = _chargeForPrivateCall;
    map['coinPerDollar'] = _coinPerDollar;
    map['coinCharge'] = _coinCharge;
    map['paymentGateway'] = _paymentGateway;
    map['redirectAppUrl'] = _redirectAppUrl;
    map['redirectMessage'] = _redirectMessage;
    map['withdrawLimit'] = _withdrawLimit;
    return map;
  }
}
