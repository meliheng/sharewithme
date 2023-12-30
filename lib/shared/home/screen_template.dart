import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/custom_navigation_bar.dart';
import 'package:sharewithme/export.dart';

class ScreenTemplate extends StatelessWidget {
  final Widget? body;
  final VoidCallback? onFloatActionButtonPressed;
  const ScreenTemplate({
    super.key,
    this.body,
    this.onFloatActionButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final PageCubit cubit = PageCubit();
    return BlocConsumer<PageCubit, PageState>(
      bloc: cubit,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            appBar: AppBar(),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                height: MediaQuery.of(context).size.height,
                child: body ?? cubit.getCurrentScreen,
              ),
            ),
          ),
          floatingActionButton: cubit.showFloatActionButton(context),
          extendBody: true,
          extendBodyBehindAppBar: true,
          bottomNavigationBar: CustomNavigationBar(
            cubit: cubit,
          ),
        );
      },
    );
  }
}
