import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serve_ease_new/screens/customer/provider_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:serve_ease_new/screens/customer/booking_screen.dart';

class ServiceProvidersScreen extends StatelessWidget {
  final String serviceType;
  final List<dynamic> providers;

  const ServiceProvidersScreen({
    super.key,
    required this.serviceType,
    required this.providers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$serviceType Providers'),
      ),
      body: providers.isEmpty
          ? const Center(
              child: Text('No service providers found'),
            )
          : ListView.builder(
              itemCount: providers.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final provider = providers[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProviderDetailsScreen(
                            provider: provider,
                            serviceType: serviceType,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Text(
                                  provider['name'][0].toUpperCase(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  provider['name'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Experience: ${provider["experience"] ?? "Not specified"} years',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Services: ${(provider["services"] as List).join(", ")}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Phone: ${provider["phone"]}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          if (provider['about'] != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              'About: ${provider["about"]}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProviderDetailsScreen(
                                    provider: provider,
                                    serviceType: serviceType,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 45),
                            ),
                            child: const Text('Book Now'),
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