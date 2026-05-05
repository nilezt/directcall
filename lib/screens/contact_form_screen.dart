import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../models/contact.dart';
import '../services/contact_service.dart';

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
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50, // Compress to 50% quality
      maxWidth: 600,    // Limit width
      maxHeight: 600,   // Limit height
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

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
                      backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                      child: _imageFile == null
                          ? const Icon(Icons.person, size: 60, color: Colors.white)
                          : null,
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
                          onPressed: _pickImage,
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
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a name';
                  }
                  if (value.trim().length < 2) {
                    return 'Name must be at least 2 characters';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!.trim(),
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
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a phone number';
                  }
                  final phoneRegExp = RegExp(r'^\+?\d+$');
                  if (!phoneRegExp.hasMatch(value.trim())) {
                    return 'Please enter a valid phone number (+ and digits only)';
                  }
                  if (value.trim().replaceAll('+', '').length < 3) {
                    return 'Phone number is too short';
                  }
                  return null;
                },
                onSaved: (value) => _phone = value!.trim(),
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
                  activeThumbColor: Theme.of(context).colorScheme.primary,
                  onChanged: (bool value) {
                    setState(() {
                      _isEmergencyFavorite = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    
                    final newContact = Contact(
                      id: const Uuid().v4(),
                      name: _name,
                      phoneNumber: _phone,
                      imageUrl: _imageFile?.path,
                      isEmergencyFavorite: _isEmergencyFavorite,
                    );
                    
                    await ContactService().saveContact(newContact);
                    
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Contact saved successfully!', style: TextStyle(fontSize: 16)),
                          backgroundColor: Colors.green.shade700,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.all(16),
                        ),
                      );
                      Navigator.pop(context, true);
                    }
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
