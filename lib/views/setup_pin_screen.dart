import 'package:cakewallet_task/widgets/button_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/providers/set_pin_vm.dart';

class SetupPinScreen extends ConsumerStatefulWidget {
  const SetupPinScreen({super.key});

  @override
  ConsumerState<SetupPinScreen> createState() => _SetupPinScreenState();
}

class _SetupPinScreenState extends ConsumerState<SetupPinScreen> {
  late int pinLength;

  @override
  Widget build(BuildContext context) {
    final setPinVm = ref.watch(setPinViewModel);

    bool isPin6 = setPinVm.isPin6;

    bool hasEnteredPin = setPinVm.hasEnteredPin;

    // set context for alert dialog
    setPinVm.context = context;

    pinLength = isPin6 ? 6 : 4;

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
              // inverse values -- toggle if pin is 6
              ref.read(setPinViewModel).toggleIsPin6();

              // clear input array
              ref.read(setPinViewModel).clear();
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
          Center(
            child: Text(
              hasEnteredPin ? 'Re-enter your PIN' : 'Create PIN',
              style: const TextStyle(
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
                bool hasInput = setPinVm.hasInput(index);

                return AnimatedContainer(
                  height: 17,
                  width: 17,
                  duration: const Duration(milliseconds: 200),
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
    final setPinVm = ref.read(setPinViewModel);

    if (buttonText == 'delete') {
      setPinVm.deleteValue();
    } else {
      setPinVm.addValue(pinLength, buttonText);
    }

    setPinVm.handlePinInput(pinLength);
  }
}
