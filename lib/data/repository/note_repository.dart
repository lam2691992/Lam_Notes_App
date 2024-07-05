import 'package:note_app/data/entity/note_entity.dart';
import 'package:note_app/data/repository/crud_repository.dart';

abstract class NoteGroupRepository extends CrudRepository<NoteGroupEntity, int> {}

abstract class NoteRepository extends CrudRepository<NoteEntity, int> {}
