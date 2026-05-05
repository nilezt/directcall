import 'package:flutter/material.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Guide', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildGuideCard(
            context,
            icon: Icons.person_add,
            title: 'Adding a Contact',
            description: 'Tap the large "+" button on the Home screen to add a new contact. You can add a photo, name, and phone number.',
          ),
          const SizedBox(height: 16),
          _buildGuideCard(
            context,
            icon: Icons.touch_app,
            title: 'Making a Call',
            description: 'Simply tap on a person\'s face on the Home screen to immediately start calling them.',
          ),
          const SizedBox(height: 16),
          _buildGuideCard(
            context,
            icon: Icons.star,
            title: 'Emergency Favorites',
            description: 'When adding a contact, you can mark them as an Emergency Favorite for quicker access.',
          ),
        ],
      ),
    );
  }

  Widget _buildGuideCard(BuildContext context, {required IconData icon, required String title, required String description}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium,
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
