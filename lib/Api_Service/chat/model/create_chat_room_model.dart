import 'dart:convert';

CreateChatRoomModel createChatRoomModelFromJson(String str) =>
    CreateChatRoomModel.fromJson(json.decode(str));

String createChatRoomModelToJson(CreateChatRoomModel data) =>
    json.encode(data.toJson());

class CreateChatRoomModel {
  CreateChatRoomModel({
    bool? status,
    String? message,
    ChatTopic? chatTopic,
  }) {
    _status = status;
    _message = message;
    _chatTopic = chatTopic;
  }

  CreateChatRoomModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _chatTopic = json['chatTopic'] != null
        ? ChatTopic.fromJson(json['chatTopic'])
        : null;
  }

  bool? _status;
  String? _message;
  ChatTopic? _chatTopic;

  CreateChatRoomModel copyWith({
    bool? status,
    String? message,
    ChatTopic? chatTopic,
  }) =>
      CreateChatRoomModel(
        status: status ?? _status,
        message: message ?? _message,
        chatTopic: chatTopic ?? _chatTopic,
      );

  bool? get status => _status;

  String? get message => _message;

  ChatTopic? get chatTopic => _chatTopic;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_chatTopic != null) {
      map['chatTopic'] = _chatTopic?.toJson();
    }
    return map;
  }
}

ChatTopic chatTopicFromJson(String str) => ChatTopic.fromJson(json.decode(str));

String chatTopicToJson(ChatTopic data) => json.encode(data.toJson());

class ChatTopic {
  ChatTopic({
    dynamic chat,
    String? id,
    String? userId,
    String? hostId,
    String? createdAt,
    String? updatedAt,
  }) {
    _chat = chat;
    _id = id;
    _userId = userId;
    _hostId = hostId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  ChatTopic.fromJson(dynamic json) {
    _chat = json['chat'];
    _id = json['_id'];
    _userId = json['userId'];
    _hostId = json['hostId'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  dynamic _chat;
  String? _id;
  String? _userId;
  String? _hostId;
  String? _createdAt;
  String? _updatedAt;

  ChatTopic copyWith({
    dynamic chat,
    String? id,
    String? userId,
    String? hostId,
    String? createdAt,
    String? updatedAt,
  }) =>
      ChatTopic(
        chat: chat ?? _chat,
        id: id ?? _id,
        userId: userId ?? _userId,
        hostId: hostId ?? _hostId,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  dynamic get chat => _chat;

  String? get id => _id;

  String? get userId => _userId;

  String? get hostId => _hostId;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['chat'] = _chat;
    map['_id'] = _id;
    map['userId'] = _userId;
    map['hostId'] = _hostId;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
