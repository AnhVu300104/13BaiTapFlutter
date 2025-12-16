class Product {
  int id;
  String title;
  dynamic price;
  String description;
  String category;
  String image;
  double rate;
  int count;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rate,
    required this.count,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      price: json['price'] ?? 0,
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      image: json['image'] ?? '',
      rate: (json['rating']?['rate'] ?? 0).toDouble(),
      count: (json['rating']?['count'] ?? 0),
    );
  }
}
