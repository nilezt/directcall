import 'package:flutter/material.dart';
import '../models/contact.dart';
import 'contact_form_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import '../services/contact_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Contact> contacts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    final loadedContacts = await ContactService().getContacts();
    if (!mounted) return;
    setState(() {
      contacts = loadedContacts;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Contacts', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator())
          : contacts.isEmpty
              ? _buildEmptyState()
              : _buildContactGrid(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ContactFormScreen()),
          );
          if (result == true) {
            _loadContacts();
          }
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 36),
      ),
    );
  }

  Widget _buildEmptyState() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            child: const Text(
              'Welcome to DirectCall. We make it easy to call your family with just one tap.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 48),
          Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person_add_alt_1, size: 80, color: Colors.white),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Add Your First\nContact',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 32,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              'Tap the button below to add\nyour first quick-dial contact.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Color(0xFF333333)),
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: const Color(0xFFE8EEF5), // Light grey-blue background
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Getting Started',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Divider(color: Colors.grey.shade300, thickness: 1),
                  const SizedBox(height: 16),
                  _buildStepRow(
                    context,
                    number: '1',
                    text: RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
                        children: [
                          TextSpan(text: 'Tap the '),
                          TextSpan(text: 'plus (+)', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: ' button below to add a contact.'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildStepRow(
                    context,
                    number: '2',
                    text: RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
                        children: [
                          TextSpan(text: 'Choose a '),
                          TextSpan(text: 'photo', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: ' and enter their '),
                          TextSpan(text: 'number', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildStepRow(
                    context,
                    number: '3',
                    text: RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
                        children: [
                          TextSpan(text: 'Your '),
                          TextSpan(text: 'quick-dial icon', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: ' will be ready!'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 100), // Extra padding for FAB
        ],
      ),
    );
  }

  Widget _buildStepRow(BuildContext context, {required String number, required Widget text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          margin: const EdgeInsets.only(top: 2),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(child: text),
      ],
    );
  }

  Widget _buildContactGrid() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Find a contact',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.8,
              crossAxisSpacing: 16,
              mainAxisSpacing: 24,
            ),
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return GestureDetector(
                onTap: () async {
                  final Uri launchUri = Uri(
                    scheme: 'tel',
                    path: contact.phoneNumber,
                  );
                  if (await canLaunchUrl(launchUri)) {
                    await launchUrl(launchUri);
                  }
                },
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: contact.imageUrl != null ? ResizeImage(FileImage(File(contact.imageUrl!)), width: 200) : null,
                          backgroundColor: Colors.grey.shade300,
                          child: contact.imageUrl == null
                              ? const Icon(Icons.person, size: 50, color: Colors.white)
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      contact.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
