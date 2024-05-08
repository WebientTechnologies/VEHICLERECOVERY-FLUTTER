// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_sm_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VehicleSingleModelAdapter extends TypeAdapter<VehicleSingleModel> {
  @override
  final int typeId = 0;

  @override
  VehicleSingleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VehicleSingleModel(
      fields[0] as String?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as String?,
      fields[5] as String?,
      fields[6] as String?,
      fields[7] as String?,
      fields[8] as String?,
      fields[9] as String?,
      fields[10] as String?,
      fields[11] as String?,
      fields[12] as String?,
      fields[13] as String?,
      fields[14] as String?,
      fields[15] as String?,
      fields[16] as String?,
      fields[17] as String?,
      fields[18] as String?,
      fields[19] as String?,
      fields[20] as String?,
      fields[21] as String?,
      fields[22] as int?,
      fields[23] as String?,
      fields[24] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, VehicleSingleModel obj) {
    writer
      ..writeByte(25)
      ..writeByte(0)
      ..write(obj.iId)
      ..writeByte(1)
      ..write(obj.bankName)
      ..writeByte(2)
      ..write(obj.branch)
      ..writeByte(3)
      ..write(obj.agreementNo)
      ..writeByte(4)
      ..write(obj.customerName)
      ..writeByte(5)
      ..write(obj.regNo)
      ..writeByte(6)
      ..write(obj.chasisNo)
      ..writeByte(7)
      ..write(obj.engineNo)
      ..writeByte(8)
      ..write(obj.maker)
      ..writeByte(9)
      ..write(obj.dlCode)
      ..writeByte(10)
      ..write(obj.bucket)
      ..writeByte(11)
      ..write(obj.emi)
      ..writeByte(12)
      ..write(obj.color)
      ..writeByte(13)
      ..write(obj.callCenterNo1)
      ..writeByte(14)
      ..write(obj.callCenterNo1Name)
      ..writeByte(15)
      ..write(obj.callCenterNo2)
      ..writeByte(16)
      ..write(obj.callCenterNo2Name)
      ..writeByte(17)
      ..write(obj.lastDigit)
      ..writeByte(18)
      ..write(obj.month)
      ..writeByte(19)
      ..write(obj.status)
      ..writeByte(20)
      ..write(obj.loadStatus)
      ..writeByte(21)
      ..write(obj.fileName)
      ..writeByte(22)
      ..write(obj.iV)
      ..writeByte(23)
      ..write(obj.createdAt)
      ..writeByte(24)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VehicleSingleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
