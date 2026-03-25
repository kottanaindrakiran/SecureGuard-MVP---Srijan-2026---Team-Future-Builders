enum Verdict { safe, suspicious, fake }

class CallResult {
  final String? id;
  final String callerNumber;
  final String? callerName;
  final double biometricScore;
  final double anomalyScore;
  final Verdict finalVerdict;
  final DateTime timestamp;

  CallResult({
    this.id,
    required this.callerNumber,
    this.callerName,
    required this.biometricScore,
    required this.anomalyScore,
    required this.finalVerdict,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'callerNumber': callerNumber,
      'callerName': callerName,
      'biometricScore': biometricScore,
      'anomalyScore': anomalyScore,
      'finalVerdict': finalVerdict.index,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory CallResult.fromMap(Map<String, dynamic> map) {
    return CallResult(
      id: map['id'],
      callerNumber: map['callerNumber'],
      callerName: map['callerName'],
      biometricScore: map['biometricScore'],
      anomalyScore: map['anomalyScore'],
      finalVerdict: Verdict.values[map['finalVerdict']],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
