import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      appBar: _appBar(),
      body: PersistentTabView(
        context, screens: _buildScreens(authCubit: widget.authCubit),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: ColorConstants.primaryBackground,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10),
          colorBehindNavBar: ColorConstants.primaryBackground,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
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
        navBarStyle: NavBarStyle.style4, // Ch
      ),
    );
  }
}

AppBar _appBar() {
  return AppBar(
      title: const Text('Share With Me'),
      backgroundColor: ColorConstants.primaryBackground);
}

List<Widget> _buildScreens({required AuthCubit authCubit}) {
  return [
    ActivityScreen(authCubit: authCubit),
    const UserListScreen(),
    ProfileScreen(authCubit: authCubit),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.home),
      title: ("Anasayfa"),
      activeColorPrimary: ColorConstants.primaryOrange,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.search),
      title: ("Arama"),
      activeColorPrimary: ColorConstants.primaryOrange,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.person),
      title: ("Profil"),
      activeColorPrimary: ColorConstants.primaryOrange,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];
}
// return BlocConsumer<PageCubit, PageState>(
//       bloc: cubit,
//       listener: (context, state) {},
//       builder: (context, state) {
//         return Scaffold(
//           appBar: AppBar(title: const Text('Share With Me')),
//           body: IndexedStack(
//             index: state.activeTabIndex,
//             children:  [
//               ActivityScreen(authCubit: widget.authCubit),
//               const UserListScreen(),
//              if(widget.authCubit.state.user!=null) ProfileScreen(authCubit: widget.authCubit),
//             ],
//           ),
//           bottomNavigationBar: BottomNavigationBar(
//             type: BottomNavigationBarType.fixed,
//             currentIndex: state.activeTabIndex,
//             selectedItemColor: ColorConstants.primaryOrange,
//             iconSize: 30,
//             onTap: (value) {
//               cubit.updateActiveTab(value);
//             },
//             items: const [
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.home), label: "Anasayfa"),
//               BottomNavigationBarItem(icon: Icon(Icons.search), label: "Ara"),
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.account_box), label: "Profil"),
//             ],
//           ),
//         );
//       },
//     );