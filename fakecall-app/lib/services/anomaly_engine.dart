import '../models/call_result.dart';

class AnomalyEngine {
  /// Rule-based anomaly detection.
  double calculateAnomalyScore({
    required String number,
    required bool isVoip,
    required bool isUnknown,
  }) {
    double score = 100; // Perfect score at start

    if (isVoip) score -= 30;
    if (isUnknown) score -= 40;
    
    // Check for common spam patterns
    if (number.length < 10) score -= 50;

    return score;
  }

  Verdict getVerdict(double biometricScore, double anomalyScore) {
    double finalScore = (biometricScore * 100 + anomalyScore) / 2;
    
    if (finalScore >= 80) return Verdict.safe;
    if (finalScore >= 50) return Verdict.suspicious;
    return Verdict.fake;
  }
}
