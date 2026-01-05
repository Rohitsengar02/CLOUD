class AddonModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String duration;
  final String imageUrl;
  final List<String> category;
  final bool isActive;

  AddonModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
    required this.imageUrl,
    required this.category,
    required this.isActive,
  });

  factory AddonModel.fromJson(Map<String, dynamic> json) {
    return AddonModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      duration: json['duration'] ?? '0',
      imageUrl: json['imageUrl'] ?? '',
      category: List<String>.from(json['category'] ?? []),
      isActive: json['isActive'] ?? true,
    );
  }
}
