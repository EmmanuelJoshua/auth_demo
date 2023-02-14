import 'package:cakewallet_task/core/mixins/pin_mixin.dart';
import 'package:cakewallet_task/core/models/pin_model.dart';
import 'package:cakewallet_task/core/services/storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authViewModel = ChangeNotifierProvider.autoDispose((ref) {
  return AuthViewModel(ref);
});

class AuthViewModel extends ChangeNotifier with PinMixin {
  AuthViewModel(this.ref);

  final Ref ref;

  // unconventional method, but had to use for speed
  late BuildContext context;

  PinModel? _pinModel;

  bool _isPin6 = false;
  bool get isPin6 => _isPin6;
  set setIsPin6(bool val) {
    _isPin6 = val;
    notifyListeners();
  }

  // handle pin input
  void handlePinInput(int pinLength) async {
    if (isInputFull(pinLength)) {
      String pin = pinInput.join('');
      validatePin(pin);
    }
    notifyListeners();
  }

  // validate pin
  void validatePin(String pin) {
    if (pin == _pinModel!.pin) {
      _showAlertDialog(
        context,
        title: 'Authentication success',
      );
      clear();
    } else {
      _showAlertDialog(
        context,
        title: 'Authentication failed',
      );
      clear();
    }
  }

  // get pin from storage
  void getPin() async {
    _pinModel = await ref.read(storageServiceProvider).getPin();

    setIsPin6 = _pinModel!.isPin6;
  }

  // show dialog
  void _showAlertDialog(
    BuildContext context, {
    required String title,
  }) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
