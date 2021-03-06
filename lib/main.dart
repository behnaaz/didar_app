import 'package:didar_app/constants/them_conf.dart';
import 'package:didar_app/model/config_model.dart';
import 'package:didar_app/routes/routes.dart';
import 'package:didar_app/services/auth/authenticatService.dart';
import 'package:didar_app/services/database/fb_all_session_service.dart';
import 'package:didar_app/services/database/fb_availability%20_service.dart';
import 'package:didar_app/services/database/fb_user_session_service.dart';
import 'package:didar_app/services/database/firestore_service.dart';
import 'package:didar_app/services/proxy/proxy_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_retry/http_retry.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';
import 'package:http/http.dart' as http;

const configPath = 'assets/config/config.yaml';
const proxyUrlKey = 'proxy-url';

Future<void> main() async {
  // ---------- Landscape off
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  // ----------
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DidarApp());
}

class DidarApp extends StatelessWidget {
  Future<Config> loadConfigs(BuildContext context) async {
    var yamlString =
        await DefaultAssetBundle.of(context).loadString(configPath);
    dynamic yamlMap = loadYaml(yamlString);
    return Future.value(new Config(yamlMap[proxyUrlKey]));
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ProxyService>(
          create: (_) =>
              ProxyService(loadConfigs(context), RetryClient(http.Client())),
        ),
        Provider<FirebaseAuth>(create: (_) => FirebaseAuth.instance),
        Provider<FBAllSessionTypeService>(create: (_) => FBAllSessionTypeService()),
        ProxyProvider2<ProxyService, FirebaseAuth, AuthenticationService>(
            update: (context, proxyService, firebaseAuth, authService) =>
                AuthenticationService(proxyService, firebaseAuth)),
        ProxyProvider<AuthenticationService, FirestoreServiceDB>(
          update: (context, authService, firestoreService) =>
              FirestoreServiceDB(authService),
        ),
        ProxyProvider<AuthenticationService, FBUserSessionService>(
          update: (context, authService, firestoreService) =>
              FBUserSessionService(authService),
        ),
        ProxyProvider<AuthenticationService, FBAvailableTimeService>(
          update: (context, authService, firestoreService) =>
              FBAvailableTimeService(authService),
        ),
      ],
      builder: (context, child) {
        return GetMaterialApp(
          locale: const Locale('fa', 'IR'),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'IranSans',
            scaffoldBackgroundColor: ColorPallet.lightGrayBg,
            appBarTheme: AppBarTheme(
              color: Colors.white,
              iconTheme: IconThemeData(color: ColorPallet.grayBg),
            ),
          ),
          initialRoute: HOME_ROUTE,
          getPages: routes,
        );
      },
    );
  }
}
