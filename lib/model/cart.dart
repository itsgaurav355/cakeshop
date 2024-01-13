class Cart {
  late final int? id;
  final String? productId;
  final String? productName;
  final int? initialPrice;
  final int? finalPrice;
  final int? quantity;
  final String? flavour;
  final String? unitTag;
  final String? image;

  Cart({
    required this.id,
    required this.productId,
    required this.productName,
    required this.flavour,
    required this.initialPrice,
    required this.finalPrice,
    required this.quantity,
    required this.unitTag,
    required this.image,
  });

  Cart.fromMap(Map<dynamic, dynamic> res)
      : id = res['id'],
        productId = res['productId'],
        productName = res['productName'],
        flavour = res['flavour'],
        initialPrice = res['initialPrice'],
        finalPrice = res['finalPrice'],
        quantity = res['quantity'],
        unitTag = res['unitTag'],
        image = res['image'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'initialPrice': initialPrice,
      'finalPrice': finalPrice,
      'flavour': flavour,
      'quantity': quantity,
      'unitTag': unitTag,
      'image': image
    };
  }
}
