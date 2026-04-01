import 'package:floor/floor.dart';

@entity
class ShoppingItem {

  @primaryKey
  final int id;

  final String name;
  final int qty;

  static int idCounter = 1;

  ///Constructor for creating a shopping item
  ///Updates idCounter so it stays ahead of existing IDs
  ShoppingItem(this.id, this.name, this.qty) {
    if (id >= idCounter) {
      idCounter = id + 1;
      }
    }
  }
