import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/activity/application/activity_cubit/activity_cubit.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/init/register.dart';

import 'auth/application/login_cubit/login_cubit.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Register.setUp();
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ApplyCubit>(
          create: (BuildContext context) => ApplyCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit(),
        ),
        BlocProvider<LoginCubit>(
          create: (BuildContext context) => LoginCubit(),
        ),
        BlocProvider<ActivityCubit>(
          create: (context) => ActivityCubit(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Lato'),
        onGenerateRoute: RouterManager.generateRoute,
        // initialRoute: HomeScreen.route,
        home: FutureBuilder(
          future: LoginCubit().getCurrentUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const ActivityScreen();
            } else {
              return const HomeScreen();
            }
          },
        ),
      ),
    );
  }
}
