// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:sharewithme/activity/presentation/activity_screen.dart';
// import 'package:sharewithme/auth/auth_export.dart';
// import 'package:sharewithme/user/presentation/profile/profile_screen.dart';
// import 'package:sharewithme/user/user_export.dart';

// import 'main.dart';

// final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
// final GlobalKey<NavigatorState> _shellNavigatorKey =
//     GlobalKey<NavigatorState>();

// final router = GoRouter(
//   navigatorKey: _rootNavigatorKey,
//   initialLocation: '/home',
//   routes: [
//     ShellRoute(
//       navigatorKey: _shellNavigatorKey,
//       builder: (context, state, child) {
//         return AppScaffold(child: child);
//       },
//       routes: <RouteBase>[
//         GoRoute(
//           path: '/home',
//           builder: (BuildContext context, GoRouterState state) {
//             return const ActivityScreen();
//           },
//         ),
//         GoRoute(
//           path: '/search',
//           builder: (BuildContext context, GoRouterState state) {
//             return const Center(child: UserListScreen());
//           },
//         ),
//         GoRoute(
//           path: '/profile',
//           builder: (BuildContext context, GoRouterState state) {
//             return const Center(child: ProfileScreen());
//           },
//         ),
//         GoRoute(
//           path: '/welcome',
//           builder: (BuildContext context, GoRouterState state) {
//             return const WelcomeScreen();
//           },
//         ),
//       ],
//     ),
//   ],
// );
