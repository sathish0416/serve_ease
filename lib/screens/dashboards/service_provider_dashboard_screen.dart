import 'package:flutter/material.dart';
import 'package:serve_ease_new/utils/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:serve_ease_new/models/service_provider_model.dart';

class ServiceProviderDashboardScreen extends StatefulWidget {
  const ServiceProviderDashboardScreen({super.key});

  @override
  State<ServiceProviderDashboardScreen> createState() => _ServiceProviderDashboardScreenState();
}

class _ServiceProviderDashboardScreenState extends State<ServiceProviderDashboardScreen> {
  ServiceProviderModel? serviceProvider;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadServiceProviderData();
  }

  Future<void> _loadServiceProviderData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance
            .collection('serviceProviders')
            .doc(user.uid)
            .get();
        
        if (doc.exists) {
          setState(() {
            serviceProvider = ServiceProviderModel.fromMap(doc.data()!);
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      print('Error loading service provider data: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleLogout() async {
    try {
      await FirebaseAuth.instance.signOut();
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to logout')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3C72),
        title: const Text('ServeEase Provider', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: AppTheme.backgroundGradient,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 35, color: Color(0xFF1E3C72)),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    serviceProvider?.name ?? 'Loading...',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    serviceProvider?.email ?? '',
                    style: TextStyle(color: Colors.white.withOpacity(0.8)),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('My Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('Help & Support'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: _handleLogout,
            ),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.business_center,
                    size: 80,
                    color: Color(0xFF1E3C72),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Welcome, ${serviceProvider?.name ?? "Service Provider"}!',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3C72),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Your Service Provider Dashboard',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}