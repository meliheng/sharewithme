import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/user/user_export.dart';

class NavigationBarCubit extends Cubit<NavigationBarState> {
  NavigationBarCubit() : super(NavigationBarState.initial());

  void changeIndex(int index) {
    emit(state.copyWith(currentIndex: index));
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
      index == state.currentIndex ? ColorConstants.primaryBlue : null;
  List<Widget> get screens => [
        ActivityScreen(authCubit: AuthCubit()),
        const UserListScreen(),
      ];
}
