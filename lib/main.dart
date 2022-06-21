import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertraining/ChatModule/Service/local_%20notification_handler.dart';
import 'package:fluttertraining/GoogleMapModule/map_view.dart';
import 'package:fluttertraining/Translation/translation.dart';
import 'package:fluttertraining/Translation/translation_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("message recieved");
  print(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
  await LocalNotifications().init();
  LocalNotifications().notification('${message.notification!.title}',
      '${message.notification!.body}', message.data.toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await LocalNotifications().init();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  String? token = await messaging.getToken();
  print('FCM TOKEN   ' + token.toString());

  FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
    print("recieved");
    print(event.notification);

    LocalNotifications().notification('${event.notification!.title}',
        '${event.notification!.body}', event.data.toString());
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) async {
    print("app is open  recieved");
    print(message.data);
    LocalNotifications().notification('${message.notification!.title}',
        '${message.notification!.body}', message.data.toString());
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Messages(),
      // your translations
      locale: Get.deviceLocale,
      fallbackLocale: Locale('en', 'US'),
      supportedLocales: [
        Locale('en', 'US'), // English, no country code
        Locale('ar', 'AE'), // Spanish, no country code
      ],
      // transla
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // home: LocaleView(),
      home: GoogleMapView(),
      // home: TextApis(),
      // home: SplashScreen(),
    );
  }
}

// Google Map
//
// google map show
// current location
// camera
//Animate camera
// heading(bearing)
// markers
//Polylines
