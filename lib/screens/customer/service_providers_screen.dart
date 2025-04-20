import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serve_ease_new/screens/customer/provider_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:serve_ease_new/screens/customer/booking_status_screen.dart';
import 'package:serve_ease_new/screens/customer/booking_screen.dart';  // Add this import

class ServiceProvidersScreen extends StatefulWidget {
  final String serviceType;

  const ServiceProvidersScreen({
    super.key,
    required this.serviceType,
  });

  @override
  State<ServiceProvidersScreen> createState() => _ServiceProvidersScreenState();
}

class _ServiceProvidersScreenState extends State<ServiceProvidersScreen> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _providers = [];

  @override
  void initState() {
    super.initState();
    _fetchProviders();
  }

  Future<void> _fetchProviders() async {
    setState(() => _isLoading = true);
    try {
      print('Fetching providers for service: ${widget.serviceType}'); // Debug print

      final querySnapshot = await FirebaseFirestore.instance
          .collection('serviceProviders')
          .where('services', arrayContains: widget.serviceType)
          .where('approvalStatus', isEqualTo: 'APPROVED') // Changed from 'PENDING' to 'APPROVED'
          .where('active', isEqualTo: true) // Added active check
          .get();

      print('Found ${querySnapshot.docs.length} providers'); // Debug print

      setState(() {
        _providers = querySnapshot.docs.map((doc) {
          final data = doc.data();
          print('Provider data: $data'); // Debug print
          return {
            'id': doc.id,
            'name': data['name'] ?? 'N/A',
            'email': data['email'] ?? 'N/A',
            'phone': data['phone'] ?? 'N/A',
            'rating': data['rating'] ?? 0,
            'experience': data['experience'] ?? 0,
          };
        }).toList();
      });
    } catch (e) {
      print('Error fetching providers: $e'); // Debug print
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load providers: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.serviceType} Providers'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _providers.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('No providers available'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _fetchProviders,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _providers.length,
                  itemBuilder: (context, index) {
                    final provider = _providers[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProviderDetailsScreen(
                                provider: provider,
                                serviceType: widget.serviceType,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      provider['name'] ?? 'N/A',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(provider['email'] ?? 'N/A'),
                                    Text('Experience: ${provider['experience'] ?? 0} years'),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Modify the ElevatedButton onPressed in the build method
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                  minimumSize: const Size(100, 36),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookingScreen(
                                        provider: provider,
                                        serviceType: widget.serviceType,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Book',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}