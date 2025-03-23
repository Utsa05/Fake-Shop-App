import '../../data/models/product_model.dart';
import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Rating rating;

  const ProductEntity(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image,
      required this.rating});

  @override
  List<Object?> get props => [id, title, category];

  @override
  bool? get stringify =>true;
}
