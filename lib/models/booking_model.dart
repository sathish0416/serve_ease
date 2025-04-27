import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String customerId;
  final String serviceProviderId;
  final String serviceType;
  final String description;
  final String scheduledDate;
  final String scheduledTime;

  BookingModel({
    required this.customerId,
    required this.serviceProviderId,
    required this.serviceType,
    required this.description,
    required this.scheduledDate,
    required this.scheduledTime,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      customerId: json['customer_id'] ?? '',
      serviceProviderId: json['service_provider_id'] ?? '',
      serviceType: json['service_type'] ?? '',
      description: json['description'] ?? '',
      scheduledDate: json['scheduledDate'] ?? '',
      scheduledTime: json['scheduledTime'] ?? '',
    );
  }
}