import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    Key? key,
    this.obscureText,
    this.controller,
    this.onPressed,
    this.hint,
    this.isPassword,
    this.icon,
    this.validator,
    this.keyboardType,
    this.readOnly,
    this.smartDashesType,
    this.smartQuotesType,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController? controller;
  final bool? obscureText;
  final Function()? onPressed;
  final String? hint;
  final bool? isPassword;
  final IconData? icon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      // textAlign: TextAlign.center,
      readOnly: readOnly ?? false,
      validator: validator,
      style: const TextStyle(fontFamily: 'Quicksand', color: Colors.black , fontSize: 18),
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: hint,
        // border: InputBorder.none,
        contentPadding: EdgeInsets.fromLTRB(60.w, 0, 10, 0), // Adjust left padding here
        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        prefixIcon: Container(
          margin: EdgeInsets.only(right: 2.w),
          // padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color(0xFF37B8FC),
          ),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        suffixIcon: isPassword == true
            ? IconButton(
          icon: Icon(
            obscureText == true ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: onPressed,
        )
            : null,
      ),
    );
  }
}