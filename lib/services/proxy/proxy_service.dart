import 'package:didar_app/model/config_model.dart';
import 'package:didar_app/model/user_model.dart';
import 'package:didar_app/model/user_profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_retry/http_retry.dart';
import 'dart:convert' as convert;

import 'package:logger/logger.dart';

final Logger logger = Logger();

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

  Future<User>? signInWorkaround(email) async {
    var url = Uri.http('216.137.187.176:8080', '/login', {'key': email});
    logger.d("Going to login via proxy " + email + " from " + url.path);

    // Await the http get response, then decode the json-formatted response.
    var response;

    try {
      response =
          await http.get(url, headers: {'Access-Control-Allow-Origin': '*'});
      logger.d("response:", response);
      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, String>;
        var email = jsonResponse['Email'];
        var uid = jsonResponse['UID'];
        print('User: $email $uid.');
        return User(uid!, email!);
      } else {
        print('Request failed with status: ${response.statusCode}.');
        return Future.error(
            'Request failed with status: ${response.statusCode}.');
      }
    } on Exception catch (e) {
      logger.e("ERROR: ", e);
      return Future.error(e);
    }
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
