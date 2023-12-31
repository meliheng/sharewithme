import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/custom_navigation_bar.dart';
import 'package:sharewithme/export.dart';

class ScreenTemplate extends StatelessWidget {
  final VoidCallback? onFloatActionButtonPressed;
  const ScreenTemplate({
    super.key,
    this.onFloatActionButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final NavigationBarCubit cubit = NavigationBarCubit();
    return BlocConsumer<NavigationBarCubit, NavigationBarState>(
      bloc: cubit,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorConstants.grayV2,
          appBar: CustomAppBar(
            appBar: AppBar(),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                height: MediaQuery.of(context).size.height,
                child: cubit.getCurrentScreen,
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
