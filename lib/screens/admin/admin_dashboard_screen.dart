import 'package:flutter/material.dart';
import 'package:serve_ease_new/screens/admin/admin_customers_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

// In the class _AdminDashboardScreenState
class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _totalCustomers = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCustomersCount();
  }

  void _navigateToCustomersScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AdminCustomersScreen(),
      ),
    ).then((_) => _fetchCustomersCount()); // Refresh count when returning
  }

  Future<void> _fetchCustomersCount() async {
    try {
      final response = await http.get(
        Uri.parse('https://serveeaseserver-production.up.railway.app/api/admin/customers'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final customers = json.decode(response.body);
        setState(() {
          _totalCustomers = customers.length;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching customers: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.people),
            onPressed: _navigateToCustomersScreen,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Overview',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AdminCustomersScreen(),
                            ),
                          ).then((_) => _fetchCustomersCount());
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.people,
                                color: Color(0xFF9C27B0),
                                size: 32,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Total Customers',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              _isLoading
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Color(0xFF9C27B0),
                                      ),
                                    )
                                  : Text(
                                      '$_totalCustomers',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF9C27B0),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}