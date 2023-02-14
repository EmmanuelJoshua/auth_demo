import 'package:cakewallet_task/core/models/pin_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

class StorageService {
  final storage = const FlutterSecureStorage();

  savePinLocally({required PinModel model}) async =>
      storage.write(key: 'pin', value: model.toJson());

  Future<PinModel?> getPin() async {
    String? pinString = await storage.read(key: 'pin');
    return PinModel.fromJson(pinString!);
  }
}
