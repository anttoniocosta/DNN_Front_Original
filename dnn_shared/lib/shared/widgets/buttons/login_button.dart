import 'package:flutter/material.dart';
import 'package:dnn_shared/dnn_shared.dart';

class LoginButton extends StatelessWidget {
  final String label;
  final String assetName;
  final VoidCallback onPressed;
  final String? type;

  const LoginButton(
      {super.key,
      required this.label,
      required this.assetName,
      required this.onPressed,
      this.type});

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case 'google':
        return OutlinedButton.icon(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: const Color(0xFF5384EE),
            side: const BorderSide(color: Color(0xFF5384EE), width: 1.0),
          ),
          icon: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(4.0),
            child: const Image(
              image: AssetImage(MediaRes.googleLogo),
              height: 20.0,
              width: 20.0,
            ),
          ),
          label: Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
        );
      case 'apple':
        return OutlinedButton.icon(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.black,
            side: const BorderSide(color: Colors.black, width: 1.0),
          ),
          icon: const Image(
            color: Colors.white,
            image: AssetImage(MediaRes.appleLogo),
            height: 24.0,
            width: 24.0,
          ),
          label: Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
        );
      default:
        return OutlinedButton.icon(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            side: const BorderSide(color: Colors.grey, width: 1.0),
          ),
          icon: Image(
            image: AssetImage(assetName),
            height: 24.0,
            width: 24.0,
          ),
          label: Text(
            label,
            style: const TextStyle(color: Colors.black),
          ),
        );
    }
  }
}
