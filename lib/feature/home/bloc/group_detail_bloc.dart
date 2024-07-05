import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/data/entity/note_entity.dart';
import 'package:note_app/data/observer_data/note_observer_data.dart';
import 'package:note_app/data/repository/crud_repository.dart';
import 'package:note_app/data/repository/note_repository.dart';

class GroupDetailBloc extends Cubit<GroupDetailState> {
  GroupDetailBloc({
    required this.group,
    required this.noteObserverData,
  }) : super(GroupDetailState.initialState()) {
    noteObserverData.listener(
      (notes) {
        emit(state.copyWith(notes: notes));
      },
    );
  }

  final NoteGroupEntity group;
  final NoteObserverData noteObserverData;

  @override
  Future<void> close() {
    noteObserverData.cancelListen();
    return super.close();
  }

  void switchDeleteMode(bool value) {
    emit(state.copyWith(isDeleteMode: value));
  }
}

class GroupDetailState extends Equatable {
  const GroupDetailState({
    this.notes,
    this.isDeleteMode,
  });

  final List<NoteEntity>? notes;
  final bool? isDeleteMode;

  factory GroupDetailState.initialState() {
    return const GroupDetailState();
  }

  @override
  List<Object?> get props => [
        notes.hashCode,
        isDeleteMode,
      ];

  GroupDetailState copyWith({
    List<NoteEntity>? notes,
    bool? isDeleteMode,
  }) {
    return GroupDetailState(
      notes: notes ?? this.notes,
      isDeleteMode: isDeleteMode ?? this.isDeleteMode,
    );
  }
}
