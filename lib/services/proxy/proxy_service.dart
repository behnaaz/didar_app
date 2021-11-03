import 'package:didar_app/model/config_model.dart';
import 'package:didar_app/model/user_model.dart';
import 'package:didar_app/model/user_profile_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:logger/logger.dart';

final Logger logger = Logger();

class ProxyService {
  final Future<Config> _config;
  late String _proxyUrl;
  final _client;

  ProxyService(this._config, this._client) {
    _config.then((value) => {_proxyUrl = value.proxyUrl});
  }

  //dynamic connect() async {
  //try {
  //logger.d(await _client.read(Uri.http('url', '')));
  // } finally {
  //_client.close();
  //}
  // }

  Future<UserProfile> userProfile(email) async {
    var url = Uri.http(_proxyUrl, '/profile', {'key': email});
    http.Response response = await _client.get(url);
    logger.d("response is: " +
        response.statusCode.toString() +
        " : " +
        response.body.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      logger.d("json res: uid: " +
          jsonResponse['uid']! +
          " email:" +
          jsonResponse['email']);
      return UserProfile(
          firstName: jsonResponse[UserProfile.FIRST_NAME],
          lastName: jsonResponse[UserProfile.LAST_NAME],
          bio: jsonResponse[UserProfile.BIO],
          eduDegree: jsonResponse[UserProfile.EDU_DEGREE],
          email: jsonResponse[UserProfile.EMAIL],
          phoneNumber: jsonResponse[UserProfile.PHONE_NUMBER],
          sessionTopics: jsonResponse[UserProfile.SESSION_TOPICS],
          socialLinks: jsonResponse[UserProfile.SOCIAL_LINK]);
      //TODO Behnaz : :[] :[map[instagram:ff] map[LinkedIn:eeeee]]]
    }
    throw "An error occurred" +
        response.statusCode.toString() +
        response.toString();
  }

  Future<User> login(email) async {
    var url = Uri.http(_proxyUrl, '/login', {'key': email});
    http.Response response = await _client.get(url);
    logger.d("response is: " +
        response.statusCode.toString() +
        " : " +
        response.body.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      logger.d("json res: uid: " +
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
