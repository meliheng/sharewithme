import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/home/page_cubit.dart';
import 'package:sharewithme/user/presentation/_presentation_exporter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeScreen extends StatefulWidget {
  final AuthCubit authCubit;
  const HomeScreen({super.key, required this.authCubit});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageCubit cubit = PageCubit.instance();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: BlocConsumer<AuthCubit, AuthState>(
        bloc: widget.authCubit,
        listener: (context, state) {},
        builder: (context, state) {
          return state.status == AuthStatus.submitting
              ? const CircularProgressIndicator()
              : PersistentTabView(
                  context,
                  controller: PersistentTabController(initialIndex: 0),
                  screens: _buildScreens(
                    authCubit: widget.authCubit,
                    pageCubit: cubit,
                  ),
                  items: _navBarsItems(),
                  confineInSafeArea: true,
                  backgroundColor: ColorConstants.kBlue,
                  resizeToAvoidBottomInset: true,
                  stateManagement: true,
                  navBarHeight: 70,
                  hideNavigationBarWhenKeyboardShows: true,
                  itemAnimationProperties: const ItemAnimationProperties(
                    // Navigation Bar's items animation properties.
                    duration: Duration(milliseconds: 200),
                    curve: Curves.ease,
                  ),
                  screenTransitionAnimation: const ScreenTransitionAnimation(
                    // Screen transition animation on change of selected tab.
                    animateTabTransition: true,
                    curve: Curves.ease,
                    duration: Duration(milliseconds: 200),
                  ),
                  navBarStyle: NavBarStyle.style13,
                );
        },
      ),
    );
  }
}

AppBar _appBar(BuildContext context) {
  return AppBar(
    title: const Text('Share With Me'),
    backgroundColor: ColorConstants.primaryBackground,
  );
}

List<Widget> _buildScreens(
    {required AuthCubit authCubit, required PageCubit pageCubit}) {
  return [
    ActivityScreen(authCubit: authCubit),
    UserListScreen(pageCubit: pageCubit),
    ProfileScreen(authCubit: authCubit),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(
        CupertinoIcons.house_fill,
        color: ColorConstants.primaryOrange,
        size: 30,
      ),
      title: ("Anasayfa"),
      activeColorPrimary: ColorConstants.primaryOrange,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(
        CupertinoIcons.search,
        color: ColorConstants.primaryOrange,
        size: 30,
      ),
      title: ("Arama"),
      activeColorPrimary: ColorConstants.primaryOrange,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        CupertinoIcons.person_alt_circle_fill,
        size: 30,
      ),
      title: ("Profil"),
      activeColorPrimary: ColorConstants.primaryOrange,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];
}
