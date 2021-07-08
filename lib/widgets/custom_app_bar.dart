import 'package:flutter/material.dart';

AppBar customAppBar(String title){
  return AppBar(
      elevation: 0.0,
      leading: BackButton(
        color: Colors.white,
      ),
      backgroundColor: Colors.transparent,
      title: Text(title),
    );
}