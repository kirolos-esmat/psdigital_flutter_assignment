class RestaurantItem {
  final int itemID;
  final String itemName;
  final String itemDescription;
  final double itemPrice;
  final String restaurantName;
  final int restaurantID;
  final String imageUrl;

  RestaurantItem({
    required this.itemID,
    required this.itemName,
    required this.itemDescription,
    required this.itemPrice,
    required this.restaurantName,
    required this.restaurantID,
    required this.imageUrl,
  });

  factory RestaurantItem.fromJson(Map<String, dynamic> json) {
    return RestaurantItem(
      itemID: json['itemID'] ?? 0,
      itemName: json['itemName'] ?? '',
      itemDescription: json['itemDescription'] ?? '',
      itemPrice: (json['itemPrice'] ?? 0.0).toDouble(),
      restaurantName: json['restaurantName'] ?? '',
      restaurantID: json['restaurantID'] ?? 0,
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemID': itemID,
      'itemName': itemName,
      'itemDescription': itemDescription,
      'itemPrice': itemPrice,
      'restaurantName': restaurantName,
      'restaurantID': restaurantID,
      'imageUrl': imageUrl,
    };
  }
}
