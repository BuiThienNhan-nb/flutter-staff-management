import 'package:get/get.dart';
import 'package:staff_management/models/quota.dart';
import 'package:staff_management/models/quotaHistories.dart';
import 'package:staff_management/services/quotaRepo.dart';

class QuotaController extends GetxController {
  static QuotaController instance = Get.find();

  RxList<Quota> _listQuota = <Quota>[].obs;

  //get function
  List<Quota> get listQuotas => _listQuota.value;
  late List<String> listQuotaName;

  @override
  void onInit() {
    super.onInit();
    _listQuota.bindStream(QuotaRepo().quotaStream());
  }

  void initListQuoataName() {
    listQuotaName = [];
    listQuotas.forEach((element) => listQuotaName.add(element.name));
  }

  List<QuotaHistory> quotasInRange(
      List<QuotaHistory> list, DateTime begin, DateTime end) {
    List<QuotaHistory> _newList = [];
    list.forEach((element) {});
    int index = 0;
    // create list quotas in the range
    while (index < list.length) {
      // if this is current quota
      if (index == 0) {
        if (list[index].joinDate.toDate().isBefore(end)) {
          _newList.add(list[index]);
          // if this is the only quota in this range
          if (list[index].joinDate.toDate().isBefore(begin)) {
            break;
          }
          // else, just skip those bellow code
          index++;
          continue;
        }
      }
      // if this is the only quota in this range
      if (list[index].joinDate.toDate().compareTo(end) < 1 &&
          list[index].dismissDate.toDate().compareTo(begin) > -1) {
        _newList.add(list[index]);
        break;
      }
      // if this quota is in this range
      if (list[index].joinDate.toDate().isBefore(end) &&
          list[index].dismissDate.toDate().isAfter(begin)) {
        _newList.add(list[index]);
      }
      index++;
    }
    return _newList;
  }

  // quotaInRange -> quotaPointInRange -> justOneQuotaInRange
  List<QuotaPoint> quotaInRange(
      List<QuotaHistory> list, DateTime begin, DateTime end) {
    List<QuotaHistory> _newList = [];
    int index = 0;
    // create list quotas in the range
    while (index < list.length) {
      // if this is current quota
      if (index == 0) {
        if (list[index].joinDate.toDate().isBefore(end)) {
          _newList.add(list[index]);
          // if this is the only quota in this range
          if (list[index].joinDate.toDate().isBefore(begin)) {
            break;
          }
          // // else, just skip those bellow code
          // index++;
          // continue;
        }
      } else {
        // if this is the only quota in this range
        if (list[index].joinDate.toDate().compareTo(begin) < 1 &&
            list[index].dismissDate.toDate().compareTo(end) > -1) {
          _newList.add(list[index]);
          break;
        }
        // if this quota is in this range
        else if (list[index].joinDate.toDate().isBefore(end) &&
            list[index].dismissDate.toDate().isAfter(begin)) {
          _newList.add(list[index]);
        }
      }
      index++;
    }
    return quotaPointInRange(_newList, begin, end);
  }

  List<QuotaPoint> quotaPointInRange(
      List<QuotaHistory> list, DateTime begin, DateTime end) {
    List<QuotaPoint> _newList = [];
    for (int index = 0; index < list.length; index++) {
      if (index == 0) {
        // if this is the first quota in range
        if (end.difference(list[index].joinDate.toDate()).inDays / 365 <=
            list[index].quota.value.duration) {
          // if this quota has just in the first rank
          _newList.add(QuotaPoint(
              quotaPoint: list[index].quota.value.ranks[0],
              joinDate: list[index].joinDate.toDate(),
              dismissDate: end));
        } else {
          _newList.addAll(justOneQuotaInRange(
              list[index], list[index].joinDate.toDate(), end));
        }
      } else if (index == list.length - 1) {
        // if this is the last quota in range
        if (list[index]
                    .dismissDate
                    .toDate()
                    .difference(list[index].joinDate.toDate())
                    .inDays /
                365 <=
            list[index].quota.value.duration) {
          // if this quota has just in the first rank
          _newList.add(QuotaPoint(
              quotaPoint: list[index].quota.value.ranks[0],
              joinDate: begin,
              dismissDate: list[index].dismissDate.toDate()));
        } else {
          _newList.addAll(justOneQuotaInRange(
              list[index], begin, list[index].dismissDate.toDate()));
        }
      } else {
        // if this quota is in the range
        if (list[index]
                    .dismissDate
                    .toDate()
                    .difference(list[index].joinDate.toDate())
                    .inDays /
                365 <=
            list[index].quota.value.duration) {
          // if this quota has just in the first rank
          _newList.add(QuotaPoint(
              quotaPoint: list[index].quota.value.ranks[0],
              joinDate: list[index].joinDate.toDate(),
              dismissDate: list[index].dismissDate.toDate()));
        } else {
          _newList.addAll(justOneQuotaInRange(list[index],
              list[index].joinDate.toDate(), list[index].dismissDate.toDate()));
        }
      }
    }
    return _newList;
  }

  List<QuotaPoint> justOneQuotaInRange(
      QuotaHistory quotaHistory, DateTime begin, DateTime end) {
    List<QuotaPoint> _newList = [];
    DateTime jDate = quotaHistory.joinDate.toDate();
    // DateTime joinDate = begin;
    int rankIndex = 0;
    // if quota join date before the begin of the range
    if (jDate.compareTo(begin) < 0) {
      do {
        jDate =
            jDate.add(Duration(days: 365 * quotaHistory.quota.value.duration));
        rankIndex++;
      } while (jDate.compareTo(begin) < 0);
      rankIndex--;
    }
    while (jDate.compareTo(end) < 1) {
      _newList.add(QuotaPoint(
          quotaPoint: quotaHistory.quota.value.ranks[rankIndex],
          joinDate: (jDate.compareTo(begin) != 0 &&
                  jDate
                          .add(Duration(
                              days: -(365 * quotaHistory.quota.value.duration)))
                          .compareTo(begin) <
                      0)
              ? begin
              : jDate,
          dismissDate: jDate
                  .add(Duration(days: 365 * quotaHistory.quota.value.duration))
                  .isAfter(end)
              ? end
              : jDate));
      jDate =
          jDate.add(Duration(days: 365 * quotaHistory.quota.value.duration));
      rankIndex++;
    }
    _newList.sort((a, b) => b.dismissDate.compareTo(a.dismissDate));
    return _newList;
  }
}
