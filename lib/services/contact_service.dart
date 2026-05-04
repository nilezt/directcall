import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/contact.dart';

class ContactService {
  static const String _contactsKey = 'contacts_list';

  Future<List<Contact>> getContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? contactsJsonString = prefs.getString(_contactsKey);
    
    if (contactsJsonString == null) {
      return [];
    }

    try {
      final List<dynamic> decodedList = json.decode(contactsJsonString);
      return decodedList.map((item) => Contact.fromJson(item)).toList();
    } catch (e) {
      print('Error decoding contacts: $e');
      return [];
    }
  }

  Future<void> saveContact(Contact newContact) async {
    final contacts = await getContacts();
    contacts.add(newContact);
    await _saveContactsList(contacts);
  }

  Future<void> updateContact(Contact updatedContact) async {
    final contacts = await getContacts();
    final index = contacts.indexWhere((c) => c.id == updatedContact.id);
    if (index != -1) {
      contacts[index] = updatedContact;
      await _saveContactsList(contacts);
    }
  }

  Future<void> deleteContact(String id) async {
    final contacts = await getContacts();
    contacts.removeWhere((c) => c.id == id);
    await _saveContactsList(contacts);
  }

  Future<void> _saveContactsList(List<Contact> contacts) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedList = json.encode(contacts.map((c) => c.toJson()).toList());
    await prefs.setString(_contactsKey, encodedList);
  }
}
