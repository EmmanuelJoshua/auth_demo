import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../widgets/button_grid.dart';

class PinAuthScreen extends ConsumerWidget {
  const PinAuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
          ),
          onPressed: context.pop,
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 70,
          ),
          const Center(
            child: Text(
              'Enter your PIN',
              style: TextStyle(
                fontSize: 27,
                color: Color(0xff9AA8C1),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            height: 35,
            child: ListView.separated(
              itemCount: 4,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(
                width: 30,
              ),
              itemBuilder: (context, index) {
                return AnimatedContainer(
                  height: 17,
                  width: 17,
                  duration: const Duration(milliseconds: 400),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xff9AA8C1), width: 1.6),
                    shape: BoxShape.circle,
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          ButtonGrid(
            onPressed: _onPressed,
          )
        ],
      ),
    );
  }

  void _onPressed({
    required String buttonText,
  }) {
    if (buttonText == 'delete') {
    } else {}
  }
}
