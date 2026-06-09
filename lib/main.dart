import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:suara_mawa/screens/penindak/penindak_main_screen.dart';
import 'package:suara_mawa/utils/app_colors.dart';
import 'package:suara_mawa/screens/auth/index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Notifikasi Background: ${message.notification?.title}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  // Set background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(// ProviderScope stores the state of all providers
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _setupFCM();
  }

  void _setupFCM() async {
    // 1. Request izin (khusus Android 13+)
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User mengizinkan notifikasi');
      
      // 2. Ambil FCM Token (Kirim token ini ke server Anda untuk target spesifik)
      String? token = await _firebaseMessaging.getToken();
      print("FCM Token Anda: $token");
    }

    // 3. Handle notifikasi saat aplikasi aktif (Foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Mendapat pesan dalam status Foreground!');
      if (message.notification != null) {
        // Di sini Anda bisa memunculkan dialog custom atau menggunakan flutter_local_notifications
        print('Judul: ${message.notification!.title}');
        print('Isi: ${message.notification!.body}');
      }
    });
    
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SUARA MAWA',
      theme: ThemeData(
        fontFamily: 'PublicSans'
      ),
      home: FirstPage()
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'SUARA MAWA',
//       theme: ThemeData(
//         fontFamily: 'PublicSans'
//       ),
//       home: FirstPage()
//     );
//   }
// }