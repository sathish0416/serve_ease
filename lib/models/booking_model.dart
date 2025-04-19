import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String bookingId;
  final String customerId;
  final String serviceProviderId;
  final String serviceType;
  final String description;
  final String status;
  final String bookingDate;
  final String scheduledDate;
  final String scheduledTime;

  BookingModel({
    required this.bookingId,
    required this.customerId,
    required this.serviceProviderId,
    required this.serviceType,
    required this.description,
    required this.status,
    required this.bookingDate,
    required this.scheduledDate,
    required this.scheduledTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'booking_id': bookingId,
      'customer_id': customerId,
      'service_provider_id': serviceProviderId,
      'service_type': serviceType,
      'description': description,
      'status': status,
      'bookingDate': bookingDate,
      'scheduledDate': scheduledDate,
      'scheduledTime': scheduledTime,
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      bookingId: map['booking_id'] ?? '',
      customerId: map['customer_id'] ?? '',
      serviceProviderId: map['service_provider_id'] ?? '',
      serviceType: map['service_type'] ?? '',
      description: map['description'] ?? '',
      status: map['status'] ?? '',
      bookingDate: map['bookingDate'] ?? '',
      scheduledDate: map['scheduledDate'] ?? '',
      scheduledTime: map['scheduledTime'] ?? '',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BookingModel && other.bookingId == bookingId;
  }

  @override
  int get hashCode => bookingId.hashCode;

  @override
  String toString() {
    return 'BookingModel{bookingId: $bookingId, customerId: $customerId, '
        'serviceProviderId: $serviceProviderId, serviceType: $serviceType, '
        'description: $description, status: $status, bookingDate: $bookingDate, '
        'scheduledDate: $scheduledDate, scheduledTime: $scheduledTime}';
  }
}