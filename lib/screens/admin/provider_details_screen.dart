import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProviderDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> provider;
  const ProviderDetailsScreen({super.key, required this.provider});

  @override
  State<ProviderDetailsScreen> createState() => _ProviderDetailsScreenState();
}

class _ProviderDetailsScreenState extends State<ProviderDetailsScreen> {
  late Map<String, dynamic> _providerData;

  @override
  void initState() {
    super.initState();
    _providerData = widget.provider;
    _fetchProviderDetails();
  }

  Future<void> _fetchProviderDetails() async {
    try {
      final response = await http.get(
        Uri.parse('https://serveeaseserver-production.up.railway.app/api/admin/service-providers/${_providerData['id']}'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        setState(() {
          _providerData = json.decode(response.body);
        });
      }
    } catch (e) {
      print('Error fetching provider details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the status
    String status = 'PENDING';
    if (_providerData['status'] != null) {
      status = _providerData['status'].toString().toUpperCase();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue.shade100,
                child: const Icon(Icons.person, size: 50, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 24),
            _buildInfoCard(
              title: 'Basic Information',
              content: Column(
                children: [
                  _buildInfoRow('Name', _providerData['name'] ?? 'N/A'),
                  _buildInfoRow('Email', _providerData['email'] ?? 'N/A'),
                  _buildInfoRow('Phone', _providerData['phone'] ?? 'N/A'),
                  _buildInfoRow('Service Type', _providerData['serviceType'] ?? 'N/A'),
                  _buildInfoRow('Location', _providerData['location'] ?? 'N/A'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: 'Service Details',
              content: Column(
                children: [
                  _buildInfoRow('Experience', '${_providerData['experience'] ?? 'N/A'} years'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: 'Additional Information',
              content: Column(
                children: [
                  _buildInfoRow('Status', status),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({required String title, required Widget content}) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            const SizedBox(height: 8),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}