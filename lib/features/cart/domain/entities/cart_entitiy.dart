import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final int? id;
  final String name;
  final double price;
  final int quantity;
  final String image;

  const CartItem({
    required this.image,
    this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  @override
  List<Object> get props => [id!, name, price, quantity];
}
