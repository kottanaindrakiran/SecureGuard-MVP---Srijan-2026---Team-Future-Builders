import 'package:flutter/material.dart';


class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  bool _isAnalyzing = true;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Simulate analysis delay
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() => _isAnalyzing = false);
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("INCOMING CALL", style: TextStyle(letterSpacing: 4, color: Colors.white54)),
              const SizedBox(height: 10),
              const Text("+91 98765 43210", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text("Possible Spoofing Detected", style: TextStyle(color: Color(0xFFFF4444))),
              const Spacer(),
              _buildAnalysisUI(),
              const Spacer(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnalysisUI() {
    if (_isAnalyzing) {
      return Column(
        children: [
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF00FF88).withValues(alpha: 1 - _pulseController.value),
                    width: 4 * _pulseController.value,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF161B22),
                    ),
                    child: const Icon(Icons.mic, size: 60, color: Color(0xFF00FF88)),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 30),
          const Text("ANALYZING VOICE BIOMETRICS...", style: TextStyle(color: Color(0xFF00FF88), fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const LinearProgressIndicator(
            backgroundColor: Colors.white10,
            color: Color(0xFF00FF88),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF161B22),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFFF4444)),
            ),
            child: const Column(
              children: [
                Icon(Icons.report_problem, size: 60, color: Color(0xFFFF4444)),
                SizedBox(height: 20),
                Text("VERDICT: AI FAKE", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFFF4444))),
                Text("Confidence: 94%", style: TextStyle(color: Colors.white60)),
                Divider(height: 30),
                Text(
                  "Voice patterns do not match saved profile for this number. High probability of deepfake spoofing.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCircleButton(Icons.call_end, Colors.red, "Reject", () => Navigator.pop(context)),
        _buildCircleButton(Icons.call, Colors.green, "Answer", () {}),
        _buildCircleButton(Icons.block, Colors.white24, "Block", () {}),
      ],
    );
  }

  Widget _buildCircleButton(IconData icon, Color color, String label, VoidCallback onPressed) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            backgroundColor: color,
            foregroundColor: Colors.white,
          ),
          child: Icon(icon),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.white54)),
      ],
    );
  }
}
