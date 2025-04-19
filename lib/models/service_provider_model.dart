import 'package:cloud_firestore/cloud_firestore.dart';

enum Gender { male, female, other }
enum ApprovalStatus { pending, accepted, rejected }

class ServiceProviderModel {
  final String providerId;  // Changed from uid to providerId
  final String name;       // Combined firstName and lastName into name
  final String email;
  final String phone;
  final String adhar;      // Changed from aadharNumber to adhar
  final String address;    // Changed from Map to String
  final String gender;     // Changed from enum to String
  final int age;
  final String about;
  final List<String> services;
  final String approvalStatus;  // Changed from enum to String
  final bool active;      // Added active status
  final double averageRating;  // Added averageRating
  final int totalReviews;     // Added totalReviews
  final List<Review>? reviews; // Added reviews list
  final int experience;  // Added experience field

  ServiceProviderModel({
    required this.providerId,
    required this.name,
    required this.email,
    required this.phone,
    required this.adhar,
    required this.address,
    required this.gender,
    required this.age,
    required this.about,
    required this.services,
    required this.experience,  // Added to constructor
    this.approvalStatus = 'PENDING',
    this.active = false,
    this.averageRating = 0.0,
    this.totalReviews = 0,
    this.reviews,
  });

  Map<String, dynamic> toMap() {
    return {
      'provider_id': providerId,
      'name': name,
      'email': email,
      'phone': phone,
      'adhar': adhar,
      'address': address,
      'gender': gender,
      'age': age,
      'about': about,
      'services': services,
      'experience': experience,  // Added to map
      'approvalStatus': approvalStatus,
      'active': active,
      'averageRating': averageRating,
      'totalReviews': totalReviews,
      'reviews': reviews?.map((review) => review.toMap()).toList(),
    };
  }

  factory ServiceProviderModel.fromMap(Map<String, dynamic> map) {
    return ServiceProviderModel(
      providerId: map['provider_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      adhar: map['adhar'] ?? '',
      address: map['address'] ?? '',
      gender: map['gender'] ?? '',
      age: map['age'] ?? 0,
      about: map['about'] ?? '',
      services: List<String>.from(map['services'] ?? []),
      experience: map['experience'] ?? 0,  // Added to fromMap
      approvalStatus: map['approvalStatus'] ?? 'PENDING',
      active: map['active'] ?? false,
      averageRating: (map['averageRating'] ?? 0.0).toDouble(),
      totalReviews: map['totalReviews'] ?? 0,
      reviews: map['reviews'] != null 
          ? List<Review>.from(map['reviews']?.map((x) => Review.fromMap(x)))
          : null,
    );
  }
}

// Add Review model class
class Review {
  final String reviewId;
  final String customerId;
  final double rating;
  final String comment;
  final DateTime createdAt;

  Review({
    required this.reviewId,
    required this.customerId,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'reviewId': reviewId,
      'customerId': customerId,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      reviewId: map['reviewId'] ?? '',
      customerId: map['customerId'] ?? '',
      rating: (map['rating'] ?? 0.0).toDouble(),
      comment: map['comment'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}