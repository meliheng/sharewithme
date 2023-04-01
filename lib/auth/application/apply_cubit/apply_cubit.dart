import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sharewithme/auth/domain/model/appeal_entity.dart';
import 'package:sharewithme/auth/domain/usecase/apply_usecase.dart';
import 'package:sharewithme/shared/_shared_exporter.dart';

part 'apply_state.dart';

class ApplyCubit extends Cubit<ApplyState> {
  ApplyCubit() : super(ApplyInitial());

  void newApply() async {
    emit(ApplySubmitting());
    var response = await ApplyUsecase.i
        .execute(
          appealEntity: AppealEntity(
            fullname: Name.create("Melih"),
            school: Name.create("Aydin University"),
            department: Name.create("Software Engineering"),
          ),
        )
        .run();
    response.fold((l) {
      print(l.message);
    }, (r) => ApplySubmitted());
  }
}
