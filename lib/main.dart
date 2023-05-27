import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/home/home_screen.dart';
import 'package:sharewithme/shared/init/register.dart';

import '../../activity/application/activity_cubit/activity_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Register.setUp();
  runApp(const MyApp());
}

class AppState {
  static Map<int, String> mapScreen = {};
  static ValueNotifier<bool> showNavBar = ValueNotifier(false);
  static List<BottomNavigationBarItem> navigationBarItems = [];
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = AuthCubit();
    return MultiBlocProvider(
      providers: [
        BlocProvider<ApplyCubit>(
          create: (BuildContext context) => ApplyCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => authCubit,
        ),
        BlocProvider<ActivityCubit>(
          create: (context) => ActivityCubit(),
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

class AppScaffold extends StatefulWidget {
  const AppScaffold({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  void initState() {
    buildLayout();
    super.initState();
  }

  Future<void> buildLayout() async {
    setDefaultLayout();

    AppState.showNavBar.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AppState.showNavBar,
      builder: (context, showBar, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Share With Me')),
          body: widget.child,
          bottomNavigationBar: !showBar
              ? null
              : BottomNavigationBar(
                  onTap: (index) => context.go(AppState.mapScreen[index]!),
                  items: AppState.navigationBarItems,
                  currentIndex: _calculateSelectedIndex(context),
                ),
        );
      },
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final GoRouter route = GoRouter.of(context);
    final String location = route.location;

    final index = AppState.mapScreen.keys.firstWhereOrNull(
      (element) => AppState.mapScreen[element] == location,
    );

    return index ?? 0;
  }
}

void setDefaultLayout() async {
  AppState.mapScreen[0] = '/home';
  AppState.mapScreen[1] = '/search';
  AppState.mapScreen[2] = '/profile';

  AppState.navigationBarItems.addAll(
    [
      const BottomNavigationBarItem(
        label: 'Home',
        icon: Icon(IconData(58136, fontFamily: 'MaterialIcons')),
      ),
      const BottomNavigationBarItem(
        label: 'Search',
        icon: Icon(IconData(58727, fontFamily: 'MaterialIcons')),
      ),
      const BottomNavigationBarItem(
        label: 'Profile',
        icon: Icon(IconData(57410, fontFamily: 'MaterialIcons')),
      ),
    ],
  );
}
