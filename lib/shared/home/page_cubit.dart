import 'package:bloc/bloc.dart';
import 'package:sharewithme/shared/home/page_state.dart';

class PageCubit extends Cubit<PageState> {
  PageCubit() : super(PageState.initial());

  void updateShowing(bool value) {
    emit(
      state.copyWith(showNavigationBar: value),
    );
  }

  static PageCubit instance() {
    return PageCubit();
  }
}
