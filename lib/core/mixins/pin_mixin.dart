mixin PinMixin {
  List<String> pinInput = [];

  void clear() => pinInput.clear();

  bool isInputFull(int pinLength) => pinInput.length == pinLength;

  void addValue(int pinLength, String buttonText) {
    if (pinInput.length < pinLength) {
      pinInput.add(buttonText);
    }
  }

  void deleteValue() {
    if (pinInput.isNotEmpty) {
      pinInput.removeAt(pinInput.length - 1);
    }
  }

  bool hasInput(int index) {
    return pinInput.asMap().containsKey(index);
  }
}
