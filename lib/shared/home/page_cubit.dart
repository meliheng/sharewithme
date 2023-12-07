import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sharewithme/activity/presentation/activity_screen.dart';
import 'package:sharewithme/auth/application/_application_exporter.dart';
import 'package:sharewithme/shared/constants/color_constants.dart';
import 'package:sharewithme/shared/home/page_state.dart';

class PageCubit extends Cubit<PageState> {
  PageCubit() : super(PageState.initial());

  void changeIndex(int index) {
    emit(state.copyWith(currentIndex: index));
  }

  Widget get getCurrentScreen => screens[state.currentIndex];
  Color? iconColor(int index) =>
      index == state.currentIndex ? ColorConstants.greenV1 : null;
  List<Widget> get screens => [
        ActivityScreen(authCubit: AuthCubit()),
        Container(),
      ];
}
