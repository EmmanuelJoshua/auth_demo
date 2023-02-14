import 'package:cakewallet_task/core/providers/auth_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../widgets/button_grid.dart';

class PinAuthScreen extends ConsumerStatefulWidget {
  const PinAuthScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PinAuthScreenState();
}

class _PinAuthScreenState extends ConsumerState<PinAuthScreen> {
  late int pinLength;
  @override
  void initState() {
    super.initState();
    ref.read(authViewModel).getPin();
  }

  @override
  Widget build(BuildContext context) {
    final authVm = ref.watch(authViewModel);

    // set context for alert dialog
    authVm.context = context;

    pinLength = authVm.isPin6 ? 6 : 4;
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
              itemCount: pinLength,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(
                width: 30,
              ),
              itemBuilder: (context, index) {
                // check if input is filled
                bool hasInput = authVm.hasInput(index);
                return AnimatedContainer(
                  height: 17,
                  width: 17,
                  duration: const Duration(milliseconds: 400),
                  decoration: BoxDecoration(
                    color:
                        hasInput ? const Color(0xff735AE8) : Colors.transparent,
                    border: Border.all(
                      color: hasInput
                          ? const Color(0xff735AE8)
                          : const Color(0xff9AA8C1),
                      width: 1.6,
                    ),
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
    final authVm = ref.read(authViewModel);

    if (buttonText == 'delete') {
      authVm.deleteValue();
    } else {
      authVm.addValue(pinLength, buttonText);
    }

    authVm.handlePinInput(pinLength);
  }
}
