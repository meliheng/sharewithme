import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/auth/application/apply_cubit/apply_cubit.dart';
import 'package:sharewithme/auth/presentation/screen/appeal_screen.dart';
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
    return BlocProvider(
      create: (_) => ApplyCubit(),
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Lato'),
        home: const AppealPage(),
      ),
    );
  }
}
