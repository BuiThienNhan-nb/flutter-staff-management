import 'package:get/get.dart';
import 'package:staff_management/models/quota.dart';
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

  void initListPositionName() {
    listQuotaName = [];
    listQuotas.forEach((element) => listQuotaName.add(element.name));
  }
}
