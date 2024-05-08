import 'package:hive/hive.dart';
part 'vehicle_sm_hive.g.dart';

@HiveType(typeId: 0)
class VehicleSingleModel extends HiveObject {
  @HiveField(0)
  String? iId;
  @HiveField(1)
  String? bankName;
  @HiveField(2)
  String? branch;
  @HiveField(3)
  String? agreementNo;
  @HiveField(4)
  String? customerName;
  @HiveField(5)
  String? regNo;
  @HiveField(6)
  String? chasisNo;
  @HiveField(7)
  String? engineNo;
  @HiveField(8)
  String? maker;
  @HiveField(9)
  String? dlCode;
  @HiveField(10)
  String? bucket;
  @HiveField(11)
  String? emi;
  @HiveField(12)
  String? color;
  @HiveField(13)
  String? callCenterNo1;
  @HiveField(14)
  String? callCenterNo1Name;
  @HiveField(15)
  String? callCenterNo2;
  @HiveField(16)
  String? callCenterNo2Name;
  @HiveField(17)
  String? lastDigit;
  @HiveField(18)
  String? month;
  @HiveField(19)
  String? status;
  @HiveField(20)
  String? loadStatus;
  @HiveField(21)
  String? fileName;
  @HiveField(22)
  int? iV;
  @HiveField(23)
  String? createdAt;
  @HiveField(24)
  String? updatedAt;

  VehicleSingleModel(
      this.iId,
      this.bankName,
      this.branch,
      this.agreementNo,
      this.customerName,
      this.regNo,
      this.chasisNo,
      this.engineNo,
      this.maker,
      this.dlCode,
      this.bucket,
      this.emi,
      this.color,
      this.callCenterNo1,
      this.callCenterNo1Name,
      this.callCenterNo2,
      this.callCenterNo2Name,
      this.lastDigit,
      this.month,
      this.status,
      this.loadStatus,
      this.fileName,
      this.iV,
      this.createdAt,
      this.updatedAt);
}
