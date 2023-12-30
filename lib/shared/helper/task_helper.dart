// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sharewithme/shared/_shared_exporter.dart';

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

  void executeTaskWithoutLoading({
    required BuildContext context,
    required TaskEither<Unit, T> task,
    void Function(T)? onRight,
    bool disableSuccessToast = false,
  }) async {
    var result = await task.run();
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

  FutureBuilder futureBuilder({
    required BuildContext context,
    required TaskEither<BaseFailure, T> task,
    required Widget Function(BaseFailure) onLeft,
    required Widget Function(T) onRight,
    String? key,
    Option<Widget Function()> loadingBuilder = const None(),
    int? loadingFlex,
  }) {
    return FutureBuilder<Either<BaseFailure, T>>(
      key: key != null ? Key(key) : null,
      future: task.run(),
      builder: (context, s) {
        if (s.connectionState == ConnectionState.waiting) {
          return loadingBuilder.match(
            () {
              if (loadingFlex == null) {
                return const LoadingDialog();
              } else {
                return Expanded(
                  flex: loadingFlex,
                  child: const LoadingDialog(),
                );
              }
            },
            (t) => t(),
          );
        }
        if (s.data == null) {
          return onLeft(AuthFailures.def());
        }
        return s.data!.fold(
          (l) => onLeft(l),
          (r) => onRight(r),
        );
      },
    );
  }
}
