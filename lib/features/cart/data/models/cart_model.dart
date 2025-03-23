import '../../domain/entities/cart_entitiy.dart';

class CartItemModel extends CartItem {
  const CartItemModel(
      {super.id,
      required super.name,
      required super.price,
      required super.quantity,
      required super.image});

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'],
      name: map['name'],
      price: map['price'].toDouble(),
      quantity: map['quantity'],
      image: map['image'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
      'image': image,
    };
  }
}
