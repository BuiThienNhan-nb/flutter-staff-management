import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:staff_management/models/addition.dart';
import 'package:staff_management/models/employee.dart';
import 'package:staff_management/models/notification.dart';
import 'package:staff_management/models/position.dart';
import 'package:staff_management/models/quota.dart';
import 'package:staff_management/models/unit.dart';
import 'package:staff_management/services/notificationRepo.dart';

class NotificationController extends GetxController {
  static NotificationController instance = Get.find();

  RxList<Notifications> _listNotification = <Notifications>[].obs;

  //get function
  List<Notifications> get listNotifications => _listNotification.value;

  @override
  void onInit() {
    super.onInit();
    _listNotification.bindStream(NotificationRepo().notificationStream());
  }

  Future<void> addPositionNotification(Position position) async {
    Notifications notifications = Notifications(
      uid: "uid",
      title: "Thêm mới một ChứC vụ",
      description:
          "Thêm mới chức vụ ${position.name} với phụ cấp chức vụ hiện tại là ${position.allowancePoints}",
      userName: "",
      time: Timestamp.fromDate(DateTime.now()),
    );
    await addNotification(notifications);
  }

  Future<void> addUnitNotification(Unit unit) async {
    Notifications notifications = Notifications(
      uid: "uid",
      title: "Thêm mới một Đơn vị",
      description:
          "Thêm mới ${unit.name} với địa chỉ là ${unit.address} và hotline là ${unit.hotline}",
      userName: "",
      time: Timestamp.fromDate(DateTime.now()),
    );
    await addNotification(notifications);
  }

  Future<void> addQuotaNotification(Quota quota) async {
    Notifications notifications = Notifications(
      uid: "uid",
      title: "Thêm mới một Ngạch",
      description:
          "Thêm mới ${quota.name} với hệ số cao nhất là ${quota.ranks.last}",
      userName: "",
      time: Timestamp.fromDate(DateTime.now()),
    );
    await addNotification(notifications);
  }

  Future<void> addAdditionNotification(Addition addition) async {
    String content = addition.isReward ? "được khen thưởng" : "bị kỷ luật";
    Notifications notifications = Notifications(
      uid: "uid",
      title: "Thêm mới danh sách Khen thưởng - Kỷ luật",
      description:
          "Thêm mới danh sách các nhân viên $content ${addition.content} trong tháng này",
      userName: "",
      time: Timestamp.fromDate(DateTime.now()),
    );
    await addNotification(notifications);
  }

  Future<void> createAdditionNotification(Addition addition) async {
    String content = addition.isReward ? "Khen thưởng" : "Kỷ luật";
    Notifications notifications = Notifications(
      uid: "uid",
      title: "Thêm mới một $content",
      description:
          "Thêm mới một $content được quy thành tiền để cập nhật lương tháng của các nhân viên",
      userName: "",
      time: Timestamp.fromDate(DateTime.now()),
    );
    await addNotification(notifications);
  }

  Future<void> addUpdateEmployeeNotification(Employee employee) async {
    Notifications notifications = Notifications(
      uid: "uid",
      title: "Cập nhật Nhân viên",
      description:
          "Cập nhật lại thông tin của nhân viên ${employee.name}, hiện đang giữ chức ${employee.workHistory.first.position.value.name} từ ${employee.workHistory.first.unit.value.name}",
      userName: "",
      time: Timestamp.fromDate(DateTime.now()),
    );
    await addNotification(notifications);
  }

  Future<void> addEmployeeNotification(Employee employee) async {
    Notifications notifications = Notifications(
      uid: "uid",
      title: "Thêm mới Nhân viên",
      description:
          "Thêm mới một nhân viên ${employee.name} giữ chức ${employee.workHistory.first.position.value.name} từ ${employee.workHistory.first.unit.value.name}",
      userName: "",
      time: Timestamp.fromDate(DateTime.now()),
    );
    await addNotification(notifications);
  }

  Future<bool> addNotification(Notifications notification) async {
    bool result = false;
    // String userName = "";
    String email = FirebaseAuth.instance.currentUser!.email!;
    notification.userName = email.split("@").first;
    await NotificationRepo()
        .addNotification(notification)
        .then((value) => result = true);
    return result;
  }
}
