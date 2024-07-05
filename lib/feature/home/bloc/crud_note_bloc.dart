import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/data/entity/note_entity.dart';
import 'package:note_app/data/repository/crud_repository.dart';
import 'package:note_app/data/repository/note_repository.dart';

class CrudNoteBloc extends Cubit implements CrudRepository<NoteEntity, int> {
  CrudNoteBloc({
    required this.noteRepository,
  }) : super(dynamic);

  final NoteRepository noteRepository;

  @override
  Future<NoteEntity> create(NoteEntity item) {
    return noteRepository.create(item);
  }

  @override
  Future<bool> delete(NoteEntity item) {
    return noteRepository.update(item.copyWith(isDeleted: true)).then((value) => true);
  }

  @override
  Future<NoteEntity> read(int id) {
    return noteRepository.read(id);
  }

  @override
  Future<NoteEntity> update(NoteEntity item) {
    return noteRepository.update(item);
  }

  void checkDone(bool isDone, NoteEntity item) {
    update(item.copyWith(isDone: isDone));
  }
}
