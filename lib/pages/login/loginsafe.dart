import 'package:ceshi1/widgets/public/pub_bg.dart';
import 'package:flutter/material.dart';

class LoginSafe extends StatefulWidget {
  const LoginSafe({super.key});

  @override
  State<LoginSafe> createState() => _LoginSafeState();
}

class _LoginSafeState extends State<LoginSafe> {
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Pub_Bg()
      ],
    );
  }
}