import 'package:flutter/material.dart';
import 'call_screen.dart';
import 'contacts_screen.dart';
import '../widgets/risk_badge.dart';
import '../models/call_result.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isProtected = true;

  final List<CallResult> _logs = [
    CallResult(
      callerNumber: "+1 234 567 890",
      callerName: "John Doe",
      biometricScore: 0.92,
      anomalyScore: 95,
      finalVerdict: Verdict.safe,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    CallResult(
      callerNumber: "+91 98765 43210",
      callerName: "Unknown",
      biometricScore: 0.12,
      anomalyScore: 30,
      finalVerdict: Verdict.fake,
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SecureGuard', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.people),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const ContactsScreen())),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildShieldHeader(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Text("Recent Activity", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _logs.length,
              itemBuilder: (context, index) => _buildCallLogItem(_logs[index]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const CallScreen())),
        label: const Text("Simulate Incoming Call"),
        icon: const Icon(Icons.call_received),
        backgroundColor: const Color(0xFF00FF88),
        foregroundColor: Colors.black,
      ),
    );
  }

  Widget _buildShieldHeader() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: _isProtected ? const Color(0xFF00FF88) : Colors.grey.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Icon(
            _isProtected ? Icons.shield : Icons.shield_outlined,
            size: 80,
            color: _isProtected ? const Color(0xFF00FF88) : Colors.grey,
          ),
          const SizedBox(height: 20),
          Text(
            _isProtected ? "Active Protection" : "Protection Disabled",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            _isProtected 
                ? "SecureGuard is monitoring incoming calls for spoofing and deepfakes."
                : "Real-time call screening is turned off.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
          ),
          const SizedBox(height: 20),
          Switch(
            value: _isProtected,
            onChanged: (v) => setState(() => _isProtected = v),
            activeThumbColor: const Color(0xFF00FF88),
          ),
        ],
      ),
    );
  }

  Widget _buildCallLogItem(CallResult log) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white10,
          child: Icon(Icons.person, color: Colors.white.withValues(alpha: 0.5)),
        ),
        title: Text(log.callerName ?? log.callerNumber),
        subtitle: Text(log.callerNumber),
        trailing: RiskBadge(verdict: log.finalVerdict),
      ),
    );
  }
}
