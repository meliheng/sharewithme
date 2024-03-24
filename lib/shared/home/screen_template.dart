import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sharewithme/export.dart';

class ScreenTemplate extends StatefulWidget {
  final VoidCallback? onFloatActionButtonPressed;
  final StatefulNavigationShell navigationShell;

  const ScreenTemplate({
    super.key,
    this.onFloatActionButtonPressed,
    required this.navigationShell,
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
          // appBar: CustomAppBar(
          //   appBar: AppBar(),
          // ),
          body: Center(
            child: widget.navigationShell,
          ),
          floatingActionButton: cubit.showFloatActionButton(context),
          extendBody: true,
          extendBodyBehindAppBar: true,
          bottomNavigationBar: CustomNavigationBar(
            cubit: cubit,
            navigationShell: widget.navigationShell,
          ),
        );
      },
    );
  }
}
