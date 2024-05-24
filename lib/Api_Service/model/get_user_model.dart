import 'dart:convert';

GetUserModel getUserModelFromJson(String str) => GetUserModel.fromJson(json.decode(str));
String getUserModelToJson(GetUserModel data) => json.encode(data.toJson());
class GetUserModel {
  GetUserModel({
      bool? status, 
      String? message, 
      FindUser? findUser,}){
    _status = status;
    _message = message;
    _findUser = findUser;
}

  GetUserModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _findUser = json['findUser'] != null ? FindUser.fromJson(json['findUser']) : null;
  }
  bool? _status;
  String? _message;
  FindUser? _findUser;
GetUserModel copyWith({  bool? status,
  String? message,
  FindUser? findUser,
}) => GetUserModel(  status: status ?? _status,
  message: message ?? _message,
  findUser: findUser ?? _findUser,
);
  bool? get status => _status;
  String? get message => _message;
  FindUser? get findUser => _findUser;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_findUser != null) {
      map['findUser'] = _findUser?.toJson();
    }
    return map;
  }

}


FindUser findUserFromJson(String str) => FindUser.fromJson(json.decode(str));
String findUserToJson(FindUser data) => json.encode(data.toJson());
class FindUser {
  FindUser({
      String? id, 
      String? name, 
      String? bio, 
      String? email, 
      String? password, 
      dynamic token, 
      dynamic channel, 
      String? country, 
      num? platformType, 
      num? coin, 
      String? dob, 
      String? image, 
      bool? isOnline, 
      bool? isBusy, 
      bool? isBlock, 
      bool? isHost, 
      bool? isSignup, 
      String? uniqueID, 
      String? identity, 
      String? lastLogin, 
      String? createdAt, 
      String? updatedAt, 
      num? age,}){
    _id = id;
    _name = name;
    _bio = bio;
    _email = email;
    _password = password;
    _token = token;
    _channel = channel;
    _country = country;
    _platformType = platformType;
    _coin = coin;
    _dob = dob;
    _image = image;
    _isOnline = isOnline;
    _isBusy = isBusy;
    _isBlock = isBlock;
    _isHost = isHost;
    _isSignup = isSignup;
    _uniqueID = uniqueID;
    _identity = identity;
    _lastLogin = lastLogin;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _age = age;
}

  FindUser.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _bio = json['bio'];
    _email = json['email'];
    _password = json['password'];
    _token = json['token'];
    _channel = json['channel'];
    _country = json['country'];
    _platformType = json['platformType'];
    _coin = json['coin'];
    _dob = json['dob'];
    _image = json['image'];
    _isOnline = json['isOnline'];
    _isBusy = json['isBusy'];
    _isBlock = json['isBlock'];
    _isHost = json['isHost'];
    _isSignup = json['isSignup'];
    _uniqueID = json['uniqueID'];
    _identity = json['identity'];
    _lastLogin = json['lastLogin'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _age = json['age'];
  }
  String? _id;
  String? _name;
  String? _bio;
  String? _email;
  String? _password;
  dynamic _token;
  dynamic _channel;
  String? _country;
  num? _platformType;
  num? _coin;
  String? _dob;
  String? _image;
  bool? _isOnline;
  bool? _isBusy;
  bool? _isBlock;
  bool? _isHost;
  bool? _isSignup;
  String? _uniqueID;
  String? _identity;
  String? _lastLogin;
  String? _createdAt;
  String? _updatedAt;
  num? _age;
FindUser copyWith({  String? id,
  String? name,
  String? bio,
  String? email,
  String? password,
  dynamic token,
  dynamic channel,
  String? country,
  num? platformType,
  num? coin,
  String? dob,
  String? image,
  bool? isOnline,
  bool? isBusy,
  bool? isBlock,
  bool? isHost,
  bool? isSignup,
  String? uniqueID,
  String? identity,
  String? lastLogin,
  String? createdAt,
  String? updatedAt,
  num? age,
}) => FindUser(  id: id ?? _id,
  name: name ?? _name,
  bio: bio ?? _bio,
  email: email ?? _email,
  password: password ?? _password,
  token: token ?? _token,
  channel: channel ?? _channel,
  country: country ?? _country,
  platformType: platformType ?? _platformType,
  coin: coin ?? _coin,
  dob: dob ?? _dob,
  image: image ?? _image,
  isOnline: isOnline ?? _isOnline,
  isBusy: isBusy ?? _isBusy,
  isBlock: isBlock ?? _isBlock,
  isHost: isHost ?? _isHost,
  isSignup: isSignup ?? _isSignup,
  uniqueID: uniqueID ?? _uniqueID,
  identity: identity ?? _identity,
  lastLogin: lastLogin ?? _lastLogin,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  age: age ?? _age,
);
  String? get id => _id;
  String? get name => _name;
  String? get bio => _bio;
  String? get email => _email;
  String? get password => _password;
  dynamic get token => _token;
  dynamic get channel => _channel;
  String? get country => _country;
  num? get platformType => _platformType;
  num? get coin => _coin;
  String? get dob => _dob;
  String? get image => _image;
  bool? get isOnline => _isOnline;
  bool? get isBusy => _isBusy;
  bool? get isBlock => _isBlock;
  bool? get isHost => _isHost;
  bool? get isSignup => _isSignup;
  String? get uniqueID => _uniqueID;
  String? get identity => _identity;
  String? get lastLogin => _lastLogin;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get age => _age;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['bio'] = _bio;
    map['email'] = _email;
    map['password'] = _password;
    map['token'] = _token;
    map['channel'] = _channel;
    map['country'] = _country;
    map['platformType'] = _platformType;
    map['coin'] = _coin;
    map['dob'] = _dob;
    map['image'] = _image;
    map['isOnline'] = _isOnline;
    map['isBusy'] = _isBusy;
    map['isBlock'] = _isBlock;
    map['isHost'] = _isHost;
    map['isSignup'] = _isSignup;
    map['uniqueID'] = _uniqueID;
    map['identity'] = _identity;
    map['lastLogin'] = _lastLogin;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['age'] = _age;
    return map;
  }

}