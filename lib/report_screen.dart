import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final TextEditingController _reportController = TextEditingController();
  String _abuseType = 'Physical';
  bool _anonymous = true;

  void _submitReport() {
    final reportText = _reportController.text;
    final type = _abuseType;
    final isAnonymous = _anonymous;

    if (reportText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your report.")),
      );
      return;
    }

    // Simulate saving (replace with Firebase or file save later)
    print("New Report:");
    print("Type: $type");
    print("Anonymous: $isAnonymous");
    print("Message: $reportText");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Report submitted anonymously.")),
    );

    _reportController.clear();
    setState(() {
      _abuseType = 'Physical';
      _anonymous = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Anonymous Report")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text("Type of Abuse"),
            DropdownButton<String>(
              value: _abuseType,
              isExpanded: true,
              items: ['Physical', 'Verbal', 'Sexual', 'Online', 'Other']
                  .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                  .toList(),
              onChanged: (val) {
                if (val != null) setState(() => _abuseType = val);
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _reportController,
              maxLines: 6,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Describe the incident",
              ),
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text("Submit Anonymously"),
              value: _anonymous,
              onChanged: (val) {
                if (val != null) setState(() => _anonymous = val);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitReport,
              child: const Text("Submit Report"),
            )
          ],
        ),
      ),
    );
  }
}
