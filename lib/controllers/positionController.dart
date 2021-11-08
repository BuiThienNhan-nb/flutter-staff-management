import 'package:get/get.dart';
import 'package:staff_management/models/position.dart';
import 'package:staff_management/services/positionRepo.dart';

class PositionController extends GetxController {
  static PositionController instance = Get.find();

  RxList<Position> _listPosition = <Position>[].obs;

  //get function
  List<Position> get listPositions => _listPosition.value;

  @override
  void onInit() {
    super.onInit();
    _listPosition.bindStream(PositionRepo().positionStream());
  }
}
