import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';
import 'package:sharewithme/shared/home/page_cubit.dart';

class HomeScreen extends StatefulWidget {
  final AuthCubit authCubit;
  const HomeScreen({super.key, required this.authCubit});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageCubit cubit = PageCubit();
  @override
  Widget build(BuildContext context) {
    return const Text("hellooo");
  }
}
