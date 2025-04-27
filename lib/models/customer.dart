class Customer {
  final String customerId;
  final String name;
  final String email;
  final String? phone;
  final String? address;
  final String registrationDate;
  final bool verified;

  Customer({
    required this.customerId,
    required this.name,
    required this.email,
    this.phone,
    this.address,
    required this.registrationDate,
    required this.verified,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      customerId: json['customer_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      registrationDate: json['registrationDate'],
      verified: json['verified'] ?? false,
    );
  }
}