import 'package:cakewallet_task/widgets/button_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/providers/app_provider.dart';

class SetupPinScreen extends ConsumerWidget {
  const SetupPinScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // defaults to false -- pin is 4 digits
    final isPin6 = ref.watch(pinProvider);

    int pinLength = isPin6 ? 6 : 4;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
          ),
          onPressed: context.pop,
        ),
        title: const Text(
          'Setup PIN',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // inverse values
              ref.read(pinProvider.notifier).state = !isPin6;
            },
            child: Text(
              isPin6 ? 'Use 4-digits PIN' : 'Use 6-digits PIN',
              style: const TextStyle(
                fontSize: 18,
                color: Color(0xff9AA8C1),
              ),
            ),
          )
        ],
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
              'Create PIN',
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
              itemCount: pinLength,
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
