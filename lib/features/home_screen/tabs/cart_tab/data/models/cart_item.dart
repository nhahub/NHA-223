class CartItem {
  CartItem({
    required this.title,
    required this.price,
    required this.color,
    required this.size,
    required this.image,
    this.qty = 1,
  });

  final String title;
  final double price;
  final String color;
  final String size;
  final String image;
  int qty;
}
