// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:collection/collection.dart' show IterableExtension;
// import 'package:sharewithme/export.dart';
// import 'package:sharewithme/shared/config/router2.dart';

// import '../../activity/application/activity_cubit/activity_cubit.dart';
// import '../init/register.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   Register.setUp();
//   runApp(const Ana());
// }

// class AppState {
//   static Map<int, String> mapScreen = {};
//   static ValueNotifier<bool> showNavBar = ValueNotifier(false);
//   static List<BottomNavigationBarItem> navigationBarItems = [];
// }

// class Ana extends StatelessWidget {
//   const Ana({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<ApplyCubit>(
//           create: (BuildContext context) => ApplyCubit(),
//         ),
//         BlocProvider<AuthCubit>(
//           create: (BuildContext context) => AuthCubit(),
//         ),
//         BlocProvider<ActivityCubit>(
//           create: (context) => ActivityCubit(),
//         )
//       ],
//       child: MaterialApp.router(
//         title: 'Dynamic route',
//         debugShowCheckedModeBanner: false,
//         routerConfig: router,
//       ),
//     );
//   }
// }

// class AppScaffold extends StatefulWidget {
//   const AppScaffold({Key? key, required this.child}) : super(key: key);

//   final Widget child;

//   @override
//   State<AppScaffold> createState() => _AppScaffoldState();
// }

// class _AppScaffoldState extends State<AppScaffold> {
//   @override
//   void initState() {
//     buildLayout();
//     super.initState();
//   }

//   Future<void> buildLayout() async {
//     setDefaultLayout();

//     AppState.showNavBar.value = true;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<bool>(
//       valueListenable: AppState.showNavBar,
//       builder: (context, showBar, child) {
//         return MaterialApp(
//           theme: ThemeData(
//             useMaterial3: true,
//             primaryColor: ColorConstants.primaryOrange,
//             primarySwatch: Colors.orange,
//           ),
//           home: Scaffold(
//             appBar: AppBar(title: const Text('Share With Me')),
//             body: widget.child,
//             bottomNavigationBar: !showBar
//                 ? null
//                 : BottomNavigationBar(
//                     onTap: (index) => context.go(AppState.mapScreen[index]!),
//                     items: AppState.navigationBarItems,
//                     currentIndex: _calculateSelectedIndex(context),
//                   ),
//           ),
//         );
//       },
//     );
//   }

//   int _calculateSelectedIndex(BuildContext context) {
//     final GoRouter route = GoRouter.of(context);
//     final String location = route.location;

//     final index = AppState.mapScreen.keys.firstWhereOrNull(
//       (element) => AppState.mapScreen[element] == location,
//     );

//     return index ?? 0;
//   }
// }

// void setDefaultLayout() async {
//   AppState.mapScreen[0] = '/home';
//   AppState.mapScreen[1] = '/search';
//   AppState.mapScreen[2] = '/profile';

//   AppState.navigationBarItems.addAll(
//     [
//       const BottomNavigationBarItem(
//         label: 'Home',
//         icon: Icon(IconData(58136, fontFamily: 'MaterialIcons')),
//       ),
//       const BottomNavigationBarItem(
//         label: 'Search',
//         icon: Icon(IconData(58727, fontFamily: 'MaterialIcons')),
//       ),
//       const BottomNavigationBarItem(
//         label: 'Account',
//         icon: Icon(IconData(57410, fontFamily: 'MaterialIcons')),
//       ),
//     ],
//   );
// }
