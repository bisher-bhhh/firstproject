import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFF4F4F4)),
      ),
      child: IconButton(
        onPressed: () {
          context.popRoute();
        },
        icon: const Icon(
          Icons.arrow_back,
          size: 22,
        ),
      ),
    );
  }
}
