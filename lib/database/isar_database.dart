import 'package:isar/isar.dart';
import 'package:note_app/data/collection/note_collection.dart';
import 'package:note_app/database/database.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatabase extends Database {
  @override
  Future initialize() {
    return Isar.initializeIsarCore().whenComplete(() {
      return getApplicationDocumentsDirectory().then(
        (dir) {
          return Isar.open(
            [
              NoteGroupCollectionSchema,
              NoteCollectionSchema,
            ],
            directory: dir.path,
          );
        },
      );
    });
  }
}
