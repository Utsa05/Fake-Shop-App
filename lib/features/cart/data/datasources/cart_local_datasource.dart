import 'package:sqflite/sqflite.dart';

import '../models/cart_model.dart';

abstract class CartLocalDataSource {
  Future<List<CartItemModel>> getCartItems();
  Future<void> addCartItem(CartItemModel item);
  Future<void> updateCartItem(CartItemModel item);
  Future<void> removeCartItem(int id);
  Future<void> clearCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final Database database;

  CartLocalDataSourceImpl({required this.database});

  @override
  Future<List<CartItemModel>> getCartItems() async {
    final List<Map<String, dynamic>> maps = await database.query('cart');
    return maps.map((map) => CartItemModel.fromMap(map)).toList();
  }

  @override
  Future<void> addCartItem(CartItemModel item) async {
    await database.insert('cart', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> updateCartItem(CartItemModel item) async {
    await database
        .update('cart', item.toMap(), where: 'id = ?', whereArgs: [item.id]);
  }

  @override
  Future<void> removeCartItem(int id) async {
    await database.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> clearCart() async {
    await database.delete('cart');
  }
}
