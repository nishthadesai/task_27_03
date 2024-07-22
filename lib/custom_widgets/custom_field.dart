import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_27_03/custom_widgets/text_styles.dart';

import '../color/app_color.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Icon? suffixIcon;
  final String? hintText;
  final IconButton? icon;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefix;
  final FormFieldValidator<String> validation;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? textInputFormat;
  final int? maxLength;
  final int? maxLines;
  final String? initialValue;
  final bool obscureText;
  const CustomTextField(
      {super.key,
      this.contentPadding,
      this.prefix,
      required this.controller,
      required this.keyboardType,
      this.hintText,
      this.icon,
      required this.validation,
      required this.textCapitalization,
      required this.textInputAction,
      this.maxLength,
      required this.obscureText,
      this.textInputFormat,
      this.initialValue,
      this.maxLines,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLength: maxLength,
      maxLines: maxLines,
      // onTapOutside: (PointerDownEvent event) {
      //   FocusScope.of(context).requestFocus(FocusNode());
      // },
      cursorOpacityAnimates: false,
      cursorColor: AppColor.black,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: contentPadding,
        filled: true,
        fillColor: AppColor.fieldGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        counterText: "",
        hintText: hintText,
        hintStyle:
            sfNormal().copyWith(color: AppColor.hintColor, fontSize: 14.spMin),
        suffixIcon: suffixIcon,
        prefixIcon: prefix,
      ),
      inputFormatters: textInputFormat,
      validator: validation,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      controller: controller,
      keyboardType: keyboardType,
    );
  }
}
