
class HostComment {
  String message;
  String user;
  String image;
  String age;
  String country;
  String id;

  HostComment(
      {required this.message,
      required this.user,
      required this.image,
      required this.age,
      required this.country,
      required this.id});
}

List<HostComment> hostCommentList = [];

List<HostComment> demoStreamList = [];
