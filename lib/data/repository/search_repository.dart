import 'package:isar/isar.dart';
import 'package:note_app/data/collection/note_collection.dart';
import 'package:note_app/data/entity/collection_mapping.dart';
import 'package:note_app/data/entity/note_entity.dart';

abstract class SearchRepository<T> {
  Future<List<T>> search(String searchInput);
}

class SearchRepositoryImpl extends SearchRepository<NoteEntity> {
  final Isar _isar = Isar.getInstance()!;
  @override
  Future<List<NoteEntity>> search(String searchInput) {
    return _isar.txn(
      () async {
        return _isar.noteCollections.where().filter().descriptionContains(searchInput).findAll().then(
          (collections) {
            return collections.map(MappingNoteCollectionToEntity().to).toList();
          },
        );
      },
    );
  }
}
