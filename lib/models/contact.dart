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
}
