import 'package:flutter/material.dart';

ElevatedButton CustomElevatedButton({
  Function()? onPressed,
  String? text,
  double? width,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
        fixedSize: Size(width ?? 330, 45),
        backgroundColor: const Color(0xff37B8FC)),
    child: Text(
      text ?? '',
      style: const TextStyle(
        fontFamily: 'Quicksand',
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}