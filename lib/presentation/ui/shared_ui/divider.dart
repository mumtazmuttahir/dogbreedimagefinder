import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final int height;
  const CustomDivider({required this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 10,
    );
  }
}
