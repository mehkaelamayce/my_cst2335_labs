import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'list_page.dart';
import 'shopping_dao.dart';

part 'database.g.dart';

@Database(version: 1, entities: [ShoppingItem])
abstract class AppDatabase extends FloorDatabase {
  ShoppingDao get shoppingDao;
}