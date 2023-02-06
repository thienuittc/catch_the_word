import 'package:uuid/uuid.dart';

class CrossWordModelUI {
  String id = const Uuid().v4();
  String value;
  bool isSelected;

  CrossWordModelUI({
    required this.value,
    this.isSelected = false,
  });
}
