import 'package:cloud_firestore/cloud_firestore.dart';

enum Gender { male, female, other }
enum ApprovalStatus { pending, accepted, rejected }

class ServiceProviderModel {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String aadharNumber;
  final Map<String, String> address;
  final Gender gender;
  final int age;
  final String about;
  final List<String> services;
  final ApprovalStatus approvalStatus;
  final int experience;
  final double? rating;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;

  ServiceProviderModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.aadharNumber,
    required this.address,
    required this.gender,
    required this.age,
    required this.about,
    required this.services,
    this.approvalStatus = ApprovalStatus.pending,
    required this.experience,
    this.rating,
    this.role = 'service_provider',
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : this.createdAt = createdAt ?? DateTime.now(),
        this.updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'aadharNumber': aadharNumber,
      'address': address,
      'gender': gender.toString().split('.').last,
      'age': age,
      'about': about,
      'services': services,
      'approvalStatus': approvalStatus.toString().split('.').last,
      'experience': experience,
      'rating': rating,
      'role': role,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory ServiceProviderModel.fromMap(Map<String, dynamic> map, String uid) {
    return ServiceProviderModel(
      uid: uid,
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      aadharNumber: map['aadharNumber'] ?? '',
      address: Map<String, String>.from(map['address'] ?? {}),
      gender: Gender.values.firstWhere(
        (e) => e.toString().split('.').last == map['gender'],
        orElse: () => Gender.other,
      ),
      age: map['age'] ?? 0,
      about: map['about'] ?? '',
      services: List<String>.from(map['services'] ?? []),
      approvalStatus: ApprovalStatus.values.firstWhere(
        (e) => e.toString().split('.').last == map['approvalStatus'],
        orElse: () => ApprovalStatus.pending,
      ),
      experience: map['experience'] ?? 0,
      rating: map['rating']?.toDouble(),
      role: map['role'] ?? 'service_provider',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }

  String get fullName => '$firstName $lastName';
  String get fullAddress => '${address['place']}, ${address['city']}, ${address['state']}';
}