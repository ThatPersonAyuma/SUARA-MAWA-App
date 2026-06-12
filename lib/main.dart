import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:suara_mawa/screens/aspirasi/beranda_mahasiswa/beranda_mahasiswa_screen.dart';
import 'package:suara_mawa/screens/auth/controller/auth_service.dart';
import 'package:suara_mawa/screens/auth/index.dart';
import 'package:suara_mawa/utils/app_colors.dart';
import 'package:suara_mawa/screens/auth/index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suara_mawa/utils/local_notif.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Notifikasi Background: ${message.notification?.title}");
}

void setupFirebaseListeners() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    if (message.notification != null) {
      print("SHOW LOCAL");
      await NotificationService.showNotification(
        title: message.notification!.title ?? 'Notifikasi',
        body: message.notification!.body ?? '',
      );
      print("success");
    }
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService.initialize();
  // Set background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  setupFirebaseListeners();
  await Future.delayed(const Duration(seconds: 3));

  await NotificationService.showNotification(
    title: "Test",
    body: "Local notification",
  );
  runApp(
    // ProviderScope stores the state of all providers
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SUARA MAWA',
      theme: ThemeData(fontFamily: 'PublicSans'),
      home: AnimatedSplashScreen(
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', width: 180, height: 90),
            const SizedBox(height: 20),
            const Text(
              'SUARA MAWA',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Suarakan Aspirasimu',
              style: TextStyle(fontSize: 14, color: AppColors.subtext1),
            ),
          ],
        ),
        nextScreen: const FirstPage(),
        splashTransition: SplashTransition.scaleTransition,
        pageTransitionType: PageTransitionType.fade,
        backgroundColor: AppColors.background,
        duration: 1000,
        animationDuration: const Duration(milliseconds: 500),
        splashIconSize: 300,
      ),
    );
  }
}
