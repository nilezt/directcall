class Contact {
  final String id;
  final String name;
  final String phoneNumber;
  final String? imageUrl;
  final bool isEmergencyFavorite;

  Contact({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.imageUrl,
    this.isEmergencyFavorite = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
      'isEmergencyFavorite': isEmergencyFavorite,
    };
  }

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      imageUrl: json['imageUrl'],
      isEmergencyFavorite: json['isEmergencyFavorite'] ?? false,
    );
  }
}
