import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';

class TextFieldWithIcon extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? inputType;
  final TextEditingController? controller;
  const TextFieldWithIcon({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.onChanged,
    this.validator,
    this.inputType,
    this.obscureText = false,
    this.controller,
  }) : super(key: key);

  @override
  State<TextFieldWithIcon> createState() => _TextFieldWithIconState();
}

class _TextFieldWithIconState extends State<TextFieldWithIcon> {
  final ValueNotifier<Color> colorNotifier =
      ValueNotifier<Color>(ColorConstants.grayV1);
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ValueListenableBuilder(
          valueListenable: colorNotifier,
          builder: (context, value, child) {
            return Icon(
              widget.icon,
              color: colorNotifier.value,
            );
          },
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          flex: 10,
          child: Focus(
            focusNode: _focusNode,
            onFocusChange: _onFocusChange,
            child: TextFormField(
              obscureText: widget.obscureText,
              controller: widget.controller,
              onChanged: widget.onChanged,
              keyboardType: widget.inputType,
              validator: widget.validator,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: const TextStyle(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorConstants.primaryBlue,
                    width: 2,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorConstants.grayV1,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onFocusChange(bool value) {
    colorNotifier.value =
        value ? ColorConstants.primaryBlue : ColorConstants.grayV1;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    colorNotifier.dispose();
    super.dispose();
  }
}
