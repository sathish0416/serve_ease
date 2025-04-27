import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

class CustomerBookingsScreen extends StatefulWidget {
  const CustomerBookingsScreen({super.key});

  @override
  State<CustomerBookingsScreen> createState() => _CustomerBookingsScreenState();
}

class _CustomerBookingsScreenState extends State<CustomerBookingsScreen> {
  List<dynamic> bookings = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      print('Fetching bookings for user: ${user?.uid}');

      if (user != null) {
        final response = await http.get(
          Uri.parse('https://serveeaseserver-production.up.railway.app/api/bookings/customer/${user.uid}'),
          headers: {
            'Content-Type': 'application/json',
          },
        );

        print('API Response Status: ${response.statusCode}');
        print('API Response Body: ${response.body}');

        if (response.statusCode == 200) {
          setState(() {
            bookings = json.decode(response.body);
            isLoading = false;
          });
        } else {
          throw Exception('Failed to load bookings');
        }
      }
    } catch (e) {
      print('Error fetching bookings: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        backgroundColor: const Color(0xFF185ADB),
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : bookings.isEmpty
              ? const Center(child: Text('No bookings found'))
              : ListView.builder(
                  itemCount: bookings.length,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    final booking = bookings[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        title: Text(
                          booking['service_type'] ?? 'Unknown Service',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF185ADB),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(booking['description'] ?? ''),
                            const SizedBox(height: 4),
                            Text(
                              'Date: ${booking['scheduledDate'] ?? 'Not set'}\n'
                              'Time: ${booking['scheduledTime'] ?? 'Not set'}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        isThreeLine: true,
                      ),
                    );
                  },
                ),
    );
  }
}