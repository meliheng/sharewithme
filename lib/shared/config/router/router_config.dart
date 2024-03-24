import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sharewithme/activity/domain/_domain_exporter.dart';
import 'package:sharewithme/activity/presentation/_presentation_exporter.dart';
import 'package:sharewithme/auth/application/_application_exporter.dart';
import 'package:sharewithme/auth/presentation/screen/forget_password_screen.dart';
import 'package:sharewithme/auth/presentation/screen/login_screen.dart';
import 'package:sharewithme/auth/presentation/screen/signup_screen.dart';
import 'package:sharewithme/shared/home/screen_template.dart';
import 'package:sharewithme/user/user_export.dart';

class GoRouterConfig {
  GoRouterConfig._();
  static const String initialRoute = '/signup';
  static final _navigationKey = GlobalKey<NavigatorState>();
  static final _navigationActivityKey = GlobalKey<NavigatorState>();
  static final _navigationProfileKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    initialLocation: initialRoute,
    navigatorKey: _navigationKey,
    routes: [
      GoRoute(
        path: "/login",
        name: "Login",
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: "/signup",
        name: "Sign up",
        builder: (context, state) {
          return const SignUpPage();
        },
      ),
      GoRoute(
        path: "/forget_password",
        name: "Forget password",
        builder: (context, state) {
          return const ForgetPasswordScreen();
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScreenTemplate(
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _navigationActivityKey,
            routes: [
              GoRoute(
                path: "/activity",
                name: "Activity",
                builder: (context, state) {
                  return ActivityScreen(
                    authCubit: AuthCubit(),
                    key: state.pageKey,
                  );
                },
                // routes: [
                //   GoRoute(
                //     path: "userDetail",
                //     name: "User Detail",
                //     builder: (context, state) {
                //       return UserDetailPage(
                //         key: state.pageKey,
                //         username: state.uri.queryParameters["username"]!,
                //       );
                //     },
                //   )
                // ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _navigationProfileKey,
            routes: [
              GoRoute(
                path: "/profile",
                name: "Profile",
                builder: (context, state) {
                  return ProfileScreen(
                    key: state.pageKey,
                  );
                },
                routes: [
                  GoRoute(
                    path: "activityDetail",
                    name: "Activity Detail",
                    builder: (context, state) {
                      ActivityEntity activity = state.extra as ActivityEntity;
                      return ActivityDetailScreen(
                        key: state.pageKey,
                        activityEntity: activity,
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ],
      )
    ],
  );
}
