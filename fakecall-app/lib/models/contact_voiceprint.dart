class ContactVoiceprint {
  final String? id;
  final String name;
  final String phone;
  final List<double> embedding;
  final DateTime enrolledAt;

  ContactVoiceprint({
    this.id,
    required this.name,
    required this.phone,
    required this.embedding,
    required this.enrolledAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'embedding': embedding.join(','),
      'enrolledAt': enrolledAt.toIso8601String(),
    };
  }

  factory ContactVoiceprint.fromMap(Map<String, dynamic> map) {
    return ContactVoiceprint(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      embedding: (map['embedding'] as String).split(',').map(double.parse).toList(),
      enrolledAt: DateTime.parse(map['enrolledAt']),
    );
  }
}
