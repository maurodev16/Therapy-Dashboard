

import 'PaymentModel.dart';
import 'RelatedDocumentsModel.dart';
import 'ServiceTypeModel.dart';
import 'UserModel.dart';

class AppointmentModel {
  String? id;
  DateTime? date;
  DateTime? time;
  String? notes;
  UserModel? userModel;
  List<ServiceTypeModel>? serviceTypeModel;
  List<PaymentModel>? paymentModel;
  List<RelatedDocumentsModel>? relatedDocumentsModel;
  bool? isCanceled;
  String? status;

  AppointmentModel({
    this.id,
    this.date,
    this.time,
    this.notes,
    this.userModel,
    this.serviceTypeModel,
    this.paymentModel,
    this.relatedDocumentsModel,
    this.isCanceled,
    this.status,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['_id'],
      date:json['date'] != null
          ? DateTime.parse(json['date'])
          : null,
          time:json['time'] != null
          ? DateTime.parse(json['time'])
          : null,
      notes: json['notes'],
      userModel: UserModel.fromJson(json['user_obj']),

         serviceTypeModel: json['service_type_obj'] != null
        ? (json['service_type_obj'] as List<dynamic>)
            .map((serviceTypeJson) => ServiceTypeModel.fromJson(serviceTypeJson))
            .toList()
        : null,

      paymentModel:  json['Payment_obj'] != null
        ? (json['Payment_obj'] as List<dynamic>)
            .map((payment) => PaymentModel.fromJson(payment))
            .toList()
        : null,

      relatedDocumentsModel:
          json['related_documents_obj'],
      isCanceled: json['is_canceled'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'date': date!.toIso8601String(),
      'time': time!.toIso8601String(),
      'notes': notes,
      'user_obj': userModel!.toJson(),
       'service_type_obj': serviceTypeModel?.map((serviceType) => serviceType.toJson()).toList(),
      'Payment_obj': paymentModel?.map((payment) => payment.toJson()).toList(),
      'related_documents_obj': relatedDocumentsModel,
      'is_canceled': isCanceled,
      'status': status,
    };
  }
}
