import 'package:flutter/material.dart';

import 'input_button.dart';

class ButtonGrid extends StatelessWidget {
  final CustomButtonTapCallback onPressed;

  const ButtonGrid({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 10,
      height: 500,
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        padding: const EdgeInsets.only(left: 30, right: 30),
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 40.0,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          ...List.generate(
            9,
            (index) {
              int i = index + 1;
              return InputButton(
                text: '$i',
                onTap: onPressed,
              );
            },
          ),
          Container(),
          InputButton(
            text: '0',
            onTap: onPressed,
          ),
          InputButton(
            onTap: onPressed,
            isClear: true,
          ),
        ],
      ),
    );
  }
}
