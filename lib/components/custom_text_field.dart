import 'package:etourism_app/Utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Function()? onSuffixIconPressed;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final String? hintText;
  final Color? fillColor;
  final Color? borderColor;
  final bool? readOnly;
  final void Function(String)? onChanged;

  const CustomTextField({
    Key? key,
    required this.label,
    this.obscureText = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onSuffixIconPressed,
    this.suffixIcon,
    this.hintText,
    this.fillColor,
    this.validator,
    this.borderColor = CustomColors.gray,
    this.readOnly,
    this.onChanged,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0), // Reduced height
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 5.0),
          TextFormField(
            controller: widget.controller,
            obscureText: _obscureText,
            keyboardType: widget.keyboardType,
            validator: widget.validator,
            readOnly: widget.readOnly ?? false,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0), // Adjust the height
              hintText: widget.hintText,
              fillColor: widget.fillColor ?? Colors.white,
              filled: true,
              errorStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.0),
                borderSide: BorderSide(
                  color: widget.borderColor ?? Colors.black,
                  width: 1.5, // Increase border width
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.0),
                borderSide: BorderSide(
                  color: widget.borderColor ?? Colors.black,
                  width: 1.5, // Increase border width
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.0),
                borderSide: BorderSide(
                  color: widget.borderColor ?? Colors.black,
                  width: 1.5, // Increase border width
                ),
              ),
              suffixIcon: widget.obscureText
                  ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: _togglePasswordVisibility,
              )
                  : widget.suffixIcon != null
                  ? IconButton(
                icon: widget.suffixIcon!,
                onPressed: widget.onSuffixIconPressed,
              )
                  : null,
            ),
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              fontWeight: FontWeight.w400
            ),
          ),
        ],
      ),
    );
  }
}
