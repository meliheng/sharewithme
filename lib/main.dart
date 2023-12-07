import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/home/screen_template.dart';
import 'package:sharewithme/shared/init/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Register.setUp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouterManager.generateRoute,
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Colors.red,
        ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const ScreenTemplate();
          } else {
            return const AuthScreen();
          }
        },
      ),
      // home: const Scaffold(
      //   bottomNavigationBar: CustomNavigationBar(),
      // ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   final AuthCubit authCubit = AuthCubit.instance();
  //   return MultiBlocProvider(
  //     providers: [
  //       BlocProvider<ApplyCubit>(
  //         create: (BuildContext context) => ApplyCubit(),
  //       ),
  //       BlocProvider<AuthCubit>(
  //         create: (BuildContext context) => authCubit,
  //       ),
  //       BlocProvider<ActivityListCubit>(
  //         create: (context) => ActivityListCubit(),
  //       )
  //     ],
  //     child: MaterialApp(
  //       theme: ThemeData(
  //         fontFamily: 'Poppins',
  //         useMaterial3: true,
  //         primarySwatch: Colors.red,
  //       ),
  //       onGenerateRoute: RouterManager.generateRoute,
  //       home: StreamBuilder(
  //         stream: FirebaseAuth.instance.authStateChanges(),
  //         builder: (context, snapshot) {
  //           if (snapshot.connectionState == ConnectionState.active) {
  //             User? user = snapshot.data;
  //             if (user == null) {
  //               return const WelcomeScreen();
  //             } else {
  //               authCubit.getUser();

  //               return HomeScreen(
  //                 authCubit: authCubit,
  //               );
  //             }
  //           }
  //           return Container();
  //         },
  //       ),
  //     ),
  //   );
  // }
}
