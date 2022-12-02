import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:nehwe/api_calls/online_status.dart';
import 'package:nehwe/constants/color_palettes.dart';
import 'package:nehwe/models/user_details_model.dart';
import 'package:nehwe/models/user_intime.dart';
import 'package:nehwe/screens/splash_screen.dart';
import 'package:nehwe/widgets/view_notification.dart';

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initalized firebase
  await Firebase.initializeApp();
  //generate token id
  FirebaseMessaging.instance.getToken().then((value) {
    print('get token :$value');
    userTiming.devicetoken = value;
  });

  //app on background
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    print('on message Opened :$message');
    await Navigator.push(
        navigatorKey.currentState!.context,
        MaterialPageRoute(
            builder: ((context) => ViewNOtification(
                  message: json.encode(message.data),
                ))));
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print('on message Opened App:$message');
    await Navigator.push(
        navigatorKey.currentState!.context,
        MaterialPageRoute(
            builder: ((context) => ViewNOtification(
                  message: json.encode(message.data),
                ))));
  });

// it will be workes app is closed.
  FirebaseMessaging.instance
      .getInitialMessage()
      .then((RemoteMessage? message) async {
    if (message != null) {
      await Navigator.push(
          navigatorKey.currentState!.context,
          MaterialPageRoute(
              builder: ((context) => ViewNOtification(
                    message: json.encode(message.data),
                  ))));
      // Navigator.pushNamed(navigatorKey.currentState!.context, '/push-page',
      //     arguments: {'message': json.encode(message.data)});
    }
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //MobileAds.instance.initialize();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('_firebaseMessagingBackgroundHandler:$message');
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // Future<InitializationStatus> initGoogleMobileAds() {
  //    Initialize Google Mobile Ads SDK
  //   return MobileAds.instance.initialize();
  // }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    var isremoved = state == AppLifecycleState.detached;
    var isonline = state == AppLifecycleState.resumed;
    var isbg = state == AppLifecycleState.paused;
    var inactive = state == AppLifecycleState.inactive;
    if (newUser.id != null) {
      isremoved || inactive
          ? await updateOnline(newUser.id, 'offline')
          : isonline || isbg
              ? await updateOnline(newUser.id, 'online')
              : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Proxima Nova',
            appBarTheme:
                const AppBarTheme(color: ColorPalette.backgroundcolor2)),
        home: const SplashScreen(),
        navigatorKey: navigatorKey,
        builder: EasyLoading.init(
          builder: (context, child) {
            return ScrollConfiguration(behavior: MyBehavior(), child: child!);
          },
        ));
  }
}
