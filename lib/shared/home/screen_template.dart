// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sharewithme/activity/domain/_domain_exporter.dart';
import 'package:sharewithme/custom_navigation_bar.dart';
import 'package:sharewithme/shared/constants/image_constants.dart';
import 'package:sharewithme/shared/constants/string_constants.dart';
import 'package:sharewithme/shared/helper/task_helper.dart';
import 'package:sharewithme/shared/home/page_cubit.dart';
import 'package:sharewithme/shared/home/page_state.dart';

class ScreenTemplate extends StatelessWidget {
  final Widget? body;
  final bool showNavigationBar;
  const ScreenTemplate({
    super.key,
    this.body,
    this.showNavigationBar = true,
  });

  @override
  Widget build(BuildContext context) {
    final PageCubit cubit = PageCubit();
    return BlocConsumer<PageCubit, PageState>(
      bloc: cubit,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: false,
            title: Text(
              StringC.appName,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () async {
                  final pickerFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (pickerFile != null) {
                    File file = File(pickerFile.path);
                    TaskHelper().executeTask(
                      context: context,
                      task: AddActivityUsecase.i.execute(
                        activityEntity:
                            ActivityEntity.def().copyWith(imagePath: file.path),
                        file: file,
                      ),
                    );
                  }
                  // final ImagePicker picker = ImagePicker();
                  // // Pick an image.
                  // final XFile? image =
                  //     await picker.pickImage(source: ImageSource.gallery);
                  // final File file = File(image!.path);
                },
                icon: SvgPicture.asset(ImageC.addIcon),
              ),
            ],
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
          extendBody: true,
          extendBodyBehindAppBar: true,
          bottomNavigationBar: showNavigationBar
              ? CustomNavigationBar(
                  cubit: cubit,
                )
              : null,
        );
      },
    );
  }
}
