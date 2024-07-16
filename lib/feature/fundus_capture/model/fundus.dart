class Fundus {
  final int id;
  final String imagePath;
  final bool verified;
  final String status;
  final String condition;
  final DateTime createdAt;

  Fundus({
    required this.id,
    required this.imagePath,
    required this.verified,
    required this.status,
    required this.condition,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagePath': imagePath,
      'verified': verified,
      'status': status,
      'condition': condition,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static Fundus fromMap(Map<String, dynamic> map) {
    return Fundus(
      id: map['id'] as int,
      imagePath: map['imagePath'] as String,
      verified: map['verified'] as bool,
      status: map['status'] as String,
      condition: map['condition'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }
}
