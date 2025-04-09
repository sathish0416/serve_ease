import 'package:flutter/material.dart';

class ServiceProviderDashboardScreen extends StatelessWidget {
  const ServiceProviderDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Provider Dashboard'),
        backgroundColor: const Color(0xFF1E3C72),
      ),
      body: const Center(
        child: Text('Welcome to Service Provider Dashboard'),
      ),
    );
  }
}