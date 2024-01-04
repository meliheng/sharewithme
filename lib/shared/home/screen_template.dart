import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharewithme/export.dart';

class ScreenTemplate extends StatefulWidget {
  final VoidCallback? onFloatActionButtonPressed;
  const ScreenTemplate({
    super.key,
    this.onFloatActionButtonPressed,
  });

  @override
  State<ScreenTemplate> createState() => _ScreenTemplateState();
}

class _ScreenTemplateState extends State<ScreenTemplate> {
  final NavigationBarCubit cubit = NavigationBarCubit();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavigationBarCubit, NavigationBarState>(
      bloc: cubit,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorConstant.kGrayV2,
          appBar: CustomAppBar(
            appBar: AppBar(),
          ),
          body: SafeArea(
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                child: PageView(
                  controller: cubit.pageController,
                  children: cubit.screens,
                ),
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
