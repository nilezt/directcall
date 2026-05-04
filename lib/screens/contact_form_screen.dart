import 'package:flutter/material.dart';

class ContactFormScreen extends StatefulWidget {
  const ContactFormScreen({super.key});

  @override
  State<ContactFormScreen> createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _phone = '';
  bool _isEmergencyFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey.shade300,
                      child: const Icon(Icons.person, size: 60, color: Colors.white),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt, color: Colors.white),
                          onPressed: () {
                            // Add photo logic
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: const TextStyle(fontSize: 18),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: const TextStyle(fontSize: 20),
                validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
                onSaved: (value) => _name = value!,
              ),
              const SizedBox(height: 24),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: const TextStyle(fontSize: 18),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: const TextStyle(fontSize: 20),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? 'Please enter a phone number' : null,
                onSaved: (value) => _phone = value!,
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: SwitchListTile(
                  title: const Text(
                    'Emergency Favorite',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text('Prioritize this contact for quick access'),
                  value: _isEmergencyFavorite,
                  activeColor: Theme.of(context).colorScheme.primary,
                  onChanged: (bool value) {
                    setState(() {
                      _isEmergencyFavorite = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Save contact logic
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Save Contact', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
