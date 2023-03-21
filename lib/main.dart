import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:partner/providers/auth.dart';
import 'package:partner/providers/location.dart';
import 'package:partner/providers/salon.dart';
import 'package:partner/screens/addsaloninfoscreen.dart';
import 'package:partner/screens/helpcenterscreen.dart';
import 'package:partner/screens/profilescreen.dart';
import 'package:partner/screens/saloninfocongratulationscreen.dart';
import 'package:partner/screens/settingsscreen.dart';
import 'package:partner/screens/tabsscreen.dart';
import 'package:partner/screens/updateSalonInfo.dart';
import 'package:provider/provider.dart';

import 'package:partner/screens/loginscreen.dart';
import 'package:partner/screens/registrationscreen.dart';
import './screens/firstscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  FlutterRingtonePlayer.playNotification();
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Got a message whilst in the foreground!');
      }
      if (kDebugMode) {
        print('Message data: ${message.data}');
      }
      if (message.notification != null) {
        if (kDebugMode) {
          print(
              'Message also contained a notification: ${message.notification}');
        }
      }
    });

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: LocationState(),
        ),
        ChangeNotifierProxyProvider<Auth, Salon>(
          create: ((context) => Salon("", "")),
          update: ((context, auth, previous) =>
              Salon(auth.isAuth, auth.userId)),
        )
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: const TextTheme(
              headline4: TextStyle(
                fontSize: 34,
              ),
              headline6: TextStyle(
                fontSize: 20,
              ),
              subtitle1: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          home: auth.isAuth.isNotEmpty
              ? const TabsScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: ((context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const FirstScreen()),
                ),
          routes: {
            TabsScreen.routeName: ((context) => const TabsScreen()),
            FirstScreen.routeName: (context) => const FirstScreen(),
            LoginScreen.routeName: (context) => const LoginScreen(),
            RegistrationScreen.routeName: (context) =>
                const RegistrationScreen(),
            AddSalonInfoScreen.routeName: (context) =>
                const AddSalonInfoScreen(),
            ProfileScreen.routeName: (context) => const ProfileScreen(),
            UpdateSalonInfoScreen.routeName: (context) =>
                const UpdateSalonInfoScreen(),
            SettingsScreen.routeName: (context) => const SettingsScreen(),
            HelpCenterScreen.routeName: (context) => const HelpCenterScreen(),
            SalonInfoCongratulationsScreen.routeName: (context) =>
                const SalonInfoCongratulationsScreen(),
          },
        ),
      ),
    );
  }
}
