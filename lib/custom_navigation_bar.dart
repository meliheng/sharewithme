import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              padding: const EdgeInsets.all(18),
              onPressed: () {},
              icon: const SizedBox(
                height: 36,
                width: 36,
                child: Icon(CupertinoIcons.house_fill),
              ),
            ),
            IconButton(
              padding: const EdgeInsets.all(18),
              onPressed: () {},
              icon: const SizedBox(
                height: 36,
                width: 36,
                child: Icon(CupertinoIcons.search),
              ),
            ),
            IconButton(
              padding: const EdgeInsets.all(18),
              onPressed: () {},
              icon: const SizedBox(
                height: 36,
                width: 36,
                child: Icon(CupertinoIcons.person_alt_circle_fill),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const SizedBox(
                height: 36,
                width: 36,
                child: Icon(CupertinoIcons.settings),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
