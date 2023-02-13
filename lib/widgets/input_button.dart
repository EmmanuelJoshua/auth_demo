import 'package:flutter/material.dart';

typedef CustomButtonTapCallback = void Function({required String buttonText});

class InputButton extends StatelessWidget {
  final String? text;
  final bool isClear;
  final CustomButtonTapCallback onTap;

  const InputButton({
    required this.onTap,
    this.text,
    this.isClear = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (isClear) {
      return FloatingActionButton(
        heroTag: null,
        onPressed: () => onTap(buttonText: 'delete'),
        elevation: 0,
        highlightElevation: 0,
        backgroundColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: const Icon(
          Icons.backspace,
          color: Color(0xff0d2133),
          size: 24,
        ),
      );
    } else {
      return FloatingActionButton(
        heroTag: null,
        onPressed: () => onTap(buttonText: text!),
        elevation: 0,
        highlightElevation: 0,
        backgroundColor: const Color(0xffF5F6F9),
        splashColor: Colors.transparent,
        child: Text(
          text!,
          style: const TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w400,
            color: Color(0xff7C90AD),
          ),
        ),
      );
    }
  }
}
