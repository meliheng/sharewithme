import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/user/user_export.dart';

class NavigationBarCubit extends Cubit<NavigationBarState> {
  late PageController pageController;

  NavigationBarCubit() : super(NavigationBarState.initial()) {
    pageController = PageController();
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }

  void onPageChanged(int index) {
    emit(state.copyWith(currentIndex: index));
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  Widget get getCurrentScreen => screens[state.currentIndex];
  Widget? showFloatActionButton(BuildContext context) {
    if (state.currentIndex == 0) {
      return FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          ActivityListCubit cubit = ActivityListCubit();
          cubit.addActivity(context);
        },
      );
    } else {
      return null;
    }
  }

  Color? iconColor(int index) =>
      index == state.currentIndex ? ColorConstant.kPrimaryBlue : null;
  List<Widget> get screens => [
        ActivityScreen(authCubit: AuthCubit()),
        const UserListScreen(),
      ];
}
