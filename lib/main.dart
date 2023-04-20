import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/auth/presentation/screen/login_screen.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/init/register.dart';

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
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Lato'),
        home: const LoginScreen(),
      ),
    );
  }
}
