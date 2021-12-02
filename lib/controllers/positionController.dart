import 'package:get/get.dart';
import 'package:staff_management/models/position.dart';
import 'package:staff_management/models/workHistory.dart';
import 'package:staff_management/services/positionRepo.dart';

class PositionController extends GetxController {
  static PositionController instance = Get.find();

  RxList<Position> _listPosition = <Position>[].obs;

  //get function
  List<Position> get listPositions => _listPosition.value;
  late List<String> listPositionName;

  @override
  void onInit() {
    super.onInit();
    _listPosition.bindStream(PositionRepo().positionStream());
  }

  void initListPositionName() {
    listPositionName = [];
    listPositions.forEach((element) => listPositionName.add(element.name));
  }

  List<WorkHistory> positionInRange(
      List<WorkHistory> list, DateTime begin, DateTime end) {
    List<WorkHistory> _newList = [];
    int index = 0;
    // create list positions in the range
    while (index < list.length) {
      // if this is current position
      if (index == 0) {
        if (list[index].joinDate.toDate().isBefore(end)) {
          _newList.add(list[index]);
          // if this is the only position in this range
          if (list[index].joinDate.toDate().isBefore(begin)) {
            break;
          }
        }
      } else {
        // if this is the only position in this range
        if (list[index].joinDate.toDate().compareTo(end) < 1 &&
            list[index].dismissDate.toDate().compareTo(begin) > -1) {
          _newList.add(list[index]);
          break;
        }
        // if this position is in this range
        else if (list[index].joinDate.toDate().isBefore(end) &&
            list[index].dismissDate.toDate().isAfter(begin)) {
          _newList.add(list[index]);
        }
      }
      index++;
    }
    return _newList;
  }
}
