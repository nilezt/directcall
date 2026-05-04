import 'package:flutter/material.dart';
import '../models/contact.dart';
import 'contact_form_screen.dart';
import 'call_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Mock data for demonstration based on the prototype.
  // Initially empty to show empty state, or populated to show grid.
  List<Contact> contacts = [
    Contact(id: '1', name: 'Arthur', phoneNumber: '555-0101', imageUrl: 'https://i.pravatar.cc/150?u=1'),
    Contact(id: '2', name: 'Martha', phoneNumber: '555-0102', imageUrl: 'https://i.pravatar.cc/150?u=2'),
    Contact(id: '3', name: 'George', phoneNumber: '555-0103', imageUrl: 'https://i.pravatar.cc/150?u=3'),
    Contact(id: '4', name: 'Evelyn', phoneNumber: '555-0104', imageUrl: 'https://i.pravatar.cc/150?u=4'),
    Contact(id: '5', name: 'Samuel', phoneNumber: '555-0105', imageUrl: 'https://i.pravatar.cc/150?u=5'),
    Contact(id: '6', name: 'Linda', phoneNumber: '555-0106', imageUrl: 'https://i.pravatar.cc/150?u=6'),
    Contact(id: '7', name: 'Frank', phoneNumber: '555-0107', imageUrl: 'https://i.pravatar.cc/150?u=7'),
    Contact(id: '8', name: 'Alice', phoneNumber: '555-0108', imageUrl: 'https://i.pravatar.cc/150?u=8'),
  ];
  
  // Set this to true to see the empty state like the first prototype screen.
  bool _showEmptyState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu, size: 32),
          onPressed: () {},
        ),
        title: const Text('My Contacts', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: _showEmptyState || contacts.isEmpty
          ? _buildEmptyState()
          : _buildContactGrid(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ContactFormScreen()),
          );
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person_add, size: 80, color: Colors.white),
            ),
            const SizedBox(height: 32),
            Text(
              'Add Your First\nContact',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 28),
            ),
            const SizedBox(height: 16),
            const Text(
              'Tap the button below to add\nyour first quick-dial contact.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
          ],
        ),
      ),
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CallScreen(contact: contact),
                    ),
                  );
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
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(contact.imageUrl ?? ''),
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
