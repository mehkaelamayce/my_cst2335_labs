import 'package:floor/floor.dart';

@entity
class ToDoItem {

  @primaryKey
    final int id;

    final String name;

    static int ID = 1;

    ToDoItem(this.id, this.name) {
      if (id >= ID) {
        ID = id + 1;
      }
    }
}