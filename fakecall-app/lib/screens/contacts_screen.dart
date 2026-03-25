import 'package:flutter/material.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final contacts = [
      {'name': 'Mom', 'phone': '+1 234 500 000', 'enrolled': true},
      {'name': 'Dad', 'phone': '+1 234 500 001', 'enrolled': true},
      {'name': 'Wife', 'phone': '+1 234 500 002', 'enrolled': false},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Trusted Contacts")),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final c = contacts[index];
          final enrolled = c['enrolled'] as bool;
          
          return ListTile(
            leading: CircleAvatar(child: Text(c['name'].toString()[0])),
            title: Text(c['name'].toString()),
            subtitle: Text(c['phone'].toString()),
            trailing: enrolled 
                ? const Icon(Icons.verified, color: Color(0xFF00FF88))
                : TextButton(onPressed: () {}, child: const Text("Enroll Voice")),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF00FF88),
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
