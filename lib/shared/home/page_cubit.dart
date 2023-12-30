import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';

class PageCubit extends Cubit<PageState> {
  PageCubit() : super(PageState.initial());

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
      index == state.currentIndex ? ColorConstants.greenV1 : null;
  List<Widget> get screens => [
        ActivityScreen(authCubit: AuthCubit()),
        Container(),
      ];
}
