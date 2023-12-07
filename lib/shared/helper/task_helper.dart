// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sharewithme/shared/_shared_exporter.dart';
import 'package:sharewithme/shared/failures/base_failure.dart';

class TaskHelper<T> {
  void executeTask({
    required BuildContext context,
    required TaskEither<BaseFailure, T> task,
    void Function(BaseFailure)? onLeftOverride,
    void Function(T)? onRight,
    bool disableSuccessToast = false,
  }) async {
    showLoadingDialog(context);
    await Future.delayed(const Duration(milliseconds: 50));
    var result = await task.run();
    Navigator.pop(context);
    result.fold(
      (l) {
        if (onLeftOverride != null) {
          onLeftOverride(l);
          return;
        }
        CustomDialog.error(
          context: context,
          message: l.message,
        );
      },
      (r) {
        onRight?.call(r);
      },
    );
  }

  void executeTaskWithoutError({
    required BuildContext context,
    required TaskEither<Unit, T> task,
    void Function(T)? onRight,
    bool disableSuccessToast = false,
  }) async {
    showLoadingDialog(context);
    await Future.delayed(const Duration(milliseconds: 50));
    var result = await task.run();
    Navigator.pop(context);
    result.fold(
      (l) {
        return;
      },
      (r) {
        onRight?.call(r);
      },
    );
  }

  Future<dynamic> showLoadingDialog(BuildContext context) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const Dialog(
          backgroundColor: Colors.red,
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
