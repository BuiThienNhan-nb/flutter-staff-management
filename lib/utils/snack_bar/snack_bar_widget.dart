import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

bool _isShowSnakbar = false;

showSnackbar(title, message, valid) {
  if (!_isShowSnakbar) {
    _isShowSnakbar = true;
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 15,
      backgroundColor: Colors.white,
      duration: Duration(seconds: 3),
      icon: valid
          ? Icon(
              Icons.check_circle,
              color: Colors.green,
            )
          : Icon(
              Icons.error_outlined,
              color: Colors.red,
            ),
      onTap: (snack) {
        Get.back();
      },
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    );
    Future.delayed(Duration(seconds: 3))
        .then((value) => _isShowSnakbar = false);
  }
}

showActionSnackBar(BuildContext context, String mesage) {
  final snackBar = SnackBar(
    duration: Duration(milliseconds: 400),
    content: Text(
      mesage,
      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
