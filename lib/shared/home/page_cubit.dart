import 'package:bloc/bloc.dart';
import 'package:sharewithme/shared/home/page_state.dart';

class PageCubit extends Cubit<PageState> {
  PageCubit() : super(PageState.initial());

  void updateActiveTab(int index) {
    emit(
      state.copyWith(activeTabIndex: index),
    );
  }

  static PageCubit instance() {
    return PageCubit();
  }
}
