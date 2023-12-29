import 'package:flutter/material.dart';
import 'package:sharewithme/export.dart';

class PasswordTextField extends StatefulWidget {
  final String hintText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? inputType;
  final TextEditingController? controller;
  const PasswordTextField({
    Key? key,
    required this.hintText,
    required this.onChanged,
    this.validator,
    this.inputType,
    this.controller,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  final ValueNotifier<Color> colorNotifier =
      ValueNotifier<Color>(ColorConstants.grayV1);
  final ValueNotifier<bool> passwordVisible = ValueNotifier(false);
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
              Icons.lock,
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
            child: ValueListenableBuilder(
              valueListenable: passwordVisible,
              builder: (context, value, child) {
                return TextFormField(
                  obscureText: !value,
                  controller: widget.controller,
                  onChanged: widget.onChanged,
                  keyboardType: widget.inputType,
                  validator: widget.validator,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        passwordVisible.value = !passwordVisible.value;
                      },
                      icon:
                          Icon(value ? Icons.visibility : Icons.visibility_off),
                    ),
                    hintText: widget.hintText,
                  ),
                );
              },
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
