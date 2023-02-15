import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/theme.dart';

class CustomTextField extends StatefulWidget {
  final Function(String value) onChanged;

  const CustomTextField({
    super.key,
    required this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final TextEditingController _controller;
  final _whiteColor = AppColors.white;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: _controller,
        keyboardType: TextInputType.text,
        onChanged: (value) {
          setState(() {});
          widget.onChanged(value);
        },
        textInputAction: TextInputAction.search,
        cursorColor: _whiteColor,
        style: TextStyle(color: _whiteColor),
        decoration: InputDecoration(
          counterText: '',
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
          alignLabelWithHint: true,
          border: InputBorder.none,
          enabledBorder: colorBorder(),
          focusedBorder: colorBorder(),
          disabledBorder: colorBorder(),
          errorBorder: colorBorder(),
          focusedErrorBorder: colorBorder(),
          labelStyle: TextStyle(color: _whiteColor),
          floatingLabelStyle: TextStyle(color: _whiteColor),
          labelText: 'Digite uma palavra aqui',
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Icon(
              CupertinoIcons.search,
              color: _whiteColor,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minHeight: 24,
            minWidth: 24,
          ),
          suffixIcon: Visibility(
            visible: _controller.text.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: InkWell(
                onTap: () {
                  _controller.clear();
                  widget.onChanged(_controller.text);
                },
                child: Icon(
                  CupertinoIcons.clear_circled,
                  color: _whiteColor,
                ),
              ),
            ),
          ),
          suffixIconConstraints: const BoxConstraints(
            minHeight: 24,
            minWidth: 24,
          ),
        ),
      );

  OutlineInputBorder colorBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: _whiteColor,
        ),
      );
}
