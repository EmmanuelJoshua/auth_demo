import 'package:cakewallet_task/core/mixins/pin_mixin.dart';
import 'package:cakewallet_task/core/models/pin_model.dart';
import 'package:cakewallet_task/core/services/storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final setPinViewModel = ChangeNotifierProvider.autoDispose((ref) {
  return SetPinViewModel(ref);
});

class SetPinViewModel extends ChangeNotifier with PinMixin {
  SetPinViewModel(this.ref);

  final Ref ref;

  // unconventional method, but had to use for speed
  late BuildContext context;

  List<String> pins = [];

  // defaults to false -- pin is 4 digits
  bool _isPin6 = false;
  bool get isPin6 => _isPin6;
  void toggleIsPin6() {
    _isPin6 = !_isPin6;
    // clear and refresh everything
    clear();
    refreshAll();
    notifyListeners();
  }

  // defaults to false
  bool _hasEnteredPin = false;
  bool get hasEnteredPin => _hasEnteredPin;
  set setHasEnteredPin(bool val) {
    _hasEnteredPin = val;
    notifyListeners();
  }

  // defaults to false
  bool _hasConfirmedPin = false;
  bool get hasConfirmedPin => _hasConfirmedPin;
  set sethasConfirmedPin(bool val) {
    _hasConfirmedPin = val;
    notifyListeners();
  }

  // handle pin button tap event
  void handlePinInput(int pinLength) async {
    if (isInputFull(pinLength)) {
      // add a little delay before the field is cleared
      await Future.delayed(const Duration(milliseconds: 150)).then((value) {
        pins.add(pinInput.join(''));

        clear();

        notifyListeners();
      });

      if (!_hasEnteredPin) {
        setHasEnteredPin = true;
      } else if (!_hasConfirmedPin) {
        sethasConfirmedPin = true;
      }
    }

    validatePin();

    notifyListeners();
  }

  void validatePin() {
    // check if both pins has been entered
    if (hasEnteredPin && hasConfirmedPin) {
      // validate pins
      if (pins[0] == pins[1]) {
        _showAlertDialog(
          context,
          title: 'Your pin has been set up successfully!',
          onPressed: () {
            // save pin locally
            PinModel pinModel = PinModel(pin: pins[0], isPin6: isPin6);
            setPin(pinModel);

            refreshAll();
            Navigator.pop(context);
            Navigator.pop(context);
          },
        );
      } else {
        _showAlertDialog(
          context,
          title: 'Your pin does not match',
          onPressed: () {
            refreshAll();
            Navigator.pop(context);
          },
        );
      }
    }
  }

  // refresh all values on event of non-matching pins
  void refreshAll() {
    setHasEnteredPin = false;
    sethasConfirmedPin = false;
  }

  // save pin to hive
  setPin(PinModel model) async {
    ref.read(storageServiceProvider).savePinLocally(model: model);
  }

  // show dialog
  void _showAlertDialog(
    BuildContext context, {
    required String title,
    required VoidCallback onPressed,
  }) {
    showCupertinoModalPopup<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: onPressed,
            child: const Text(
              'OK',
              style: TextStyle(
                color: Color(0xff735AE8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
