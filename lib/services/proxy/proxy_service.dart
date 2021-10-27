import 'package:didar_app/model/config_model.dart';
import 'package:didar_app/model/user_model.dart';
import 'package:didar_app/model/user_profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_retry/http_retry.dart';
import 'dart:convert' as convert;

class ProxyService {
  final Future<Config> _config;
  String? _proxyUrl;
  final _client = RetryClient(http.Client()); //TODO inject

  ProxyService(this._config) {
    _config.then((value) => {_proxyUrl = value.proxyUrl});
  }

  //dynamic connect() async {
  //try {
  //print(await _client.read(Uri.http('url', '')));
  // } finally {
  //_client.close();
  //}
  // }

  Future<UserProfile> userProfile(email) async {
    var url = Uri.http(_proxyUrl!, '/profile', {'key': email});
    http.Response response = await _client.get(url);
    print("response is: " +
        response.statusCode.toString() +
        " : " +
        response.body.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      print("json res: uid: " +
          jsonResponse['uid']! +
          " email:" +
          jsonResponse['email']);
      return UserProfile(
          firstName: jsonResponse['first_name'],
          lastName: jsonResponse['last_name'],
          bio: jsonResponse['first_name'],
          eduDegree: jsonResponse['first_name'],
          email: jsonResponse['email'],
          phoneNumber: jsonResponse['phone_number'],
          sessionTopics: jsonResponse['session_topics'],
          socialLinks: jsonResponse['social_links']);
      //TODO Behnaz : :[] :[map[instagram:ff] map[LinkedIn:eeeee]]]
    }
    throw "An error occurred" +
        response.statusCode.toString() +
        response.toString();
  }

  Future<User> login(email) async {
    var url = Uri.http(_proxyUrl!, '/login', {'key': email});
    http.Response response = await _client.get(url);
    print("response is: " +
        response.statusCode.toString() +
        " : " +
        response.body.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      print("json res: uid: " +
          jsonResponse['uid']! +
          " email:" +
          jsonResponse['email']);
      return Future.value(User(jsonResponse['uid']!, jsonResponse['email']));
    }
    throw "An error occurred" +
        response.statusCode.toString() +
        response.toString();
  }
}
