import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const SubmitButton({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title,
          textAlign: TextAlign.end,
          style: const TextStyle(
            color: Color(0xff262626),
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            width: 56,
            height: 34,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xfff97794), Color(0xff623aa2)],
              ),
            ),
            child: const Icon(
              Icons.arrow_forward_outlined,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
