import 'ServiceTypeModel.dart';
import 'UserModel.dart';

class AppointmentModel {
  String? id;
  DateTime? date;
  DateTime? time;
  String? notes;
  UserModel? userModel;
  List<ServiceTypeModel>? serviceTypeModel;
  String? status;
  UserModel? canceledBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  AppointmentModel({
    this.id,
    this.date,
    this.time,
    this.notes,
    this.userModel,
    this.canceledBy,
    this.serviceTypeModel,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['_id'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      time: json['time'] != null ? DateTime.parse(json['time']) : null,
      notes: json['notes'],
      userModel: UserModel.fromJson(json['user_obj']),
      canceledBy: json['canceled_by'] != null
          ? UserModel.fromJson(json['canceled_by'])
          : null,
      serviceTypeModel: json['service_type_obj'] != null
          ? (json['service_type_obj'] as List<dynamic>)
              .map((serviceTypeJson) =>
                  ServiceTypeModel.fromJson(serviceTypeJson))
              .toList()
          : null,
      status: json['status'],
      createdAt:json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'date': date!.toIso8601String(),
      'time': time!.toIso8601String(),
      'notes': notes,
      'user_obj': userModel!.toJson(),
      'canceled_by': canceledBy?.adminId,
      'service_type_obj':
          serviceTypeModel?.map((serviceType) => serviceType.toJson()).toList(),
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
