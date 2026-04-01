import 'package:floor/floor.dart';

@entity
class ShoppingItem {

  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String name;
  final int qty;

  ///Constructor for creating a shopping item
  ///Updates idCounter so it stays ahead of existing IDs
  ShoppingItem(this.name, this.qty, {this.id}) ;
  }
