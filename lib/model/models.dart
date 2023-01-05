import 'package:dataprovider/globals/global.dart';

class Provider {
  late int userid;
  late int id;
  late int postId;
  late int albumId;
  late String title;
  late String body;
  late String name;
  late String username;
  late String email;
  late bool completed;

  Provider.post({
    required this.userid,
    required this.id,
    required this.title,
    required this.body,
  });

  Provider.comments({
    required this.userid,
    required this.id,
    required this.title,
    required this.email,
    required this.body,
  });

  Provider.album({
    required this.userid,
    required this.id,
    required this.title,
  });

  Provider.photo({
    required this.userid,
    required this.id,
    required this.title,
  });

  Provider.todo({
    required this.userid,
    required this.id,
    required this.title,
  });

  Provider.user({
    required this.id,
    required this.username,
    required this.title,
  });

  factory Provider.fromMap({required Map data}) {
    if (Global.endpoint == "/posts") {
      return Provider.post(
        userid: data['userId'],
        id: data['id'],
        title: data['title'],
        body: data['body'],
      );
    } else if (Global.endpoint == "/comments") {
      return Provider.comments(
        userid: data['postId'],
        id: data['id'],
        title: data['name'],
        email: data['email'],
        body: data['body'],
      );
    } else if (Global.endpoint == "/albums") {
      return Provider.album(
        userid: data['userId'],
        id: data['id'],
        title: data['title'],
      );
    } else if (Global.endpoint == "/photos") {
      return Provider.photo(
        userid: data['albumId'],
        id: data['id'],
        title: data['title'],
      );
    } else if (Global.endpoint == "/todos") {
      return Provider.todo(
        userid: data['userId'],
        id: data['id'],
        title: data['title'],
        );
    }
    return Provider.user(
        id: data['id'],
        username: data['username'],
        title: data['email']);
  }
}
