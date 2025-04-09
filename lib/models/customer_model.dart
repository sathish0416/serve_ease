import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerModel {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final Map<String, String> address;
  final String role;
  final DateTime createdAt;

  CustomerModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.address,
    this.role = 'customer',
    DateTime? createdAt,
  }) : this.createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'address': address,
      'role': role,
      'createdAt': createdAt,
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map, String uid) {
    return CustomerModel(
      uid: uid,
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      address: Map<String, String>.from(map['address'] ?? {}),
      role: map['role'] ?? 'customer',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}