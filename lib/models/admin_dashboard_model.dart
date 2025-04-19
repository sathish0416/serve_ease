class AdminDashboardModel {
  final int totalProviders;
  final int pendingProviders;
  final int totalCustomers;
  final int totalBookings;  // Changed from activeBookings

  AdminDashboardModel({
    required this.totalProviders,
    required this.pendingProviders,
    required this.totalCustomers,
    required this.totalBookings,  // Changed from activeBookings
  });

  Map<String, dynamic> toMap() {
    return {
      'totalProviders': totalProviders,
      'pendingProviders': pendingProviders,
      'totalCustomers': totalCustomers,
      'totalBookings': totalBookings,  // Changed from activeBookings
    };
  }

  factory AdminDashboardModel.fromMap(Map<String, dynamic> map) {
    return AdminDashboardModel(
      totalProviders: map['totalProviders'] ?? 0,
      pendingProviders: map['pendingProviders'] ?? 0,
      totalCustomers: map['totalCustomers'] ?? 0,
      totalBookings: map['totalBookings'] ?? 0,  // Changed from activeBookings
    );
  }
}