import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/data/entity/note_entity.dart';
import 'package:note_app/data/observer_data/note_observer_data.dart';
import 'package:note_app/data/repository/note_repository.dart';

class DeletedListBloc extends Cubit<DeletedListState> {
  DeletedListBloc({
    required this.noteObserverData,
    required this.noteRepository,
  }) : super(DeletedListState.initialize()) {
    noteObserverData.listener(
      (notes) {
        emit(DeletedListState(notes: notes));
      },
    );
  }

  final NoteObserverData noteObserverData;
  final NoteRepository noteRepository;

  void restore(NoteEntity item) {
    noteRepository.update(item.copyWith(isDeleted: false));
  }

  @override
  Future<void> close() {
    noteObserverData.cancelListen();
    return super.close();
  }
}

class DeletedListState extends Equatable {
  final List<NoteEntity>? notes;

  const DeletedListState({this.notes});

  factory DeletedListState.initialize() {
    return const DeletedListState();
  }

  @override
  List<Object?> get props => [notes.hashCode];
}
