import 'package:flutter/material.dart';
import '../models/call_result.dart';

class RiskBadge extends StatelessWidget {
  final Verdict verdict;
  final bool isLarge;

  const RiskBadge({super.key, required this.verdict, this.isLarge = false});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;
    IconData icon;

    switch (verdict) {
      case Verdict.safe:
        color = const Color(0xFF00FF88);
        label = "SAFE";
        icon = Icons.check_circle;
        break;
      case Verdict.suspicious:
        color = const Color(0xFFFFD700);
        label = "SUSPICIOUS";
        icon = Icons.warning;
        break;
      case Verdict.fake:
        color = const Color(0xFFFF4444);
        label = "FAKE CALL";
        icon = Icons.report;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isLarge ? 16 : 8,
        vertical: isLarge ? 8 : 4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: isLarge ? 20 : 14),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: isLarge ? 14 : 10,
            ),
          ),
        ],
      ),
    );
  }
}
