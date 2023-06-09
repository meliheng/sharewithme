import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/home/home_screen.dart';
import 'package:sharewithme/shared/init/register.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'activity/application/_application_exporter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Register.setUp();
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print("tokennnnn");
  print(fcmToken);
  print("token bittiii");

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = AuthCubit.instance();
    return MultiBlocProvider(
      providers: [
        BlocProvider<ApplyCubit>(
          create: (BuildContext context) => ApplyCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => authCubit,
        ),
        BlocProvider<ActivityListCubit>(
          create: (context) => ActivityListCubit(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Poppins',
          useMaterial3: true,
          primarySwatch: Colors.red,
        ),
        onGenerateRoute: RouterManager.generateRoute,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              User? user = snapshot.data;
              if (user == null) {
                return const WelcomeScreen();
              } else {
                authCubit.getUser();

                return HomeScreen(
                  authCubit: authCubit,
                );
              }
            }
            return Container();
          },
        ),
      ),
    );
  }
}
