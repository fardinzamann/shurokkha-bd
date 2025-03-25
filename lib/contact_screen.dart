import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController _phoneController = TextEditingController();
  List<String> contacts = [];

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      contacts = prefs.getStringList('emergency_contacts') ?? [];
    });
  }

  Future<void> _saveContacts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('emergency_contacts', contacts);
  }

  void _addContact() {
    final number = _phoneController.text.trim();
    if (number.isNotEmpty && !contacts.contains(number)) {
      setState(() {
        contacts.add(number);
        _phoneController.clear();
      });
      _saveContacts();
    }
  }

  void _removeContact(String number) {
    setState(() {
      contacts.remove(number);
    });
    _saveContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Emergency Contacts")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Phone number",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addContact,
              child: const Text("Add Contact"),
            ),
            const SizedBox(height: 20),
            const Text("Saved Contacts", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final number = contacts[index];
                  return ListTile(
                    title: Text(number),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _removeContact(number),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
