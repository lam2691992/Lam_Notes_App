import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/data/entity/note_entity.dart';
import 'package:note_app/data/observer_data/note_observer_data.dart';
import 'package:note_app/data/repository/crud_repository.dart';
import 'package:note_app/data/repository/note_repository.dart';

class ListNoteGroupCubit extends Cubit<ListNoteGroupState> implements CrudRepository<NoteGroupEntity, int> {
  ListNoteGroupCubit({
    required NoteGroupRepository groupRepository,
    required NoteGroupObserverData groupObserverData,
  }) : super(ListNoteGroupState.init()) {
    _groupRepository = groupRepository;
    _groupObserverData = groupObserverData;
    _groupObserverData.listener(
      (groups) {
        emit(ListNoteGroupState(groups: groups));
      },
    );
  }

  late final NoteGroupRepository _groupRepository;

  late final NoteGroupObserverData _groupObserverData;

  Future<NoteGroupEntity> createByName(String name) {
    return _groupRepository.create(NoteGroupEntity(name: name));
  }

  @override
  Future<NoteGroupEntity> create(NoteGroupEntity item) {
    return _groupRepository.create(item);
  }

  @override
  Future<bool> delete(NoteGroupEntity item) {
    return _groupRepository.delete(item);
  }

  @override
  Future<NoteGroupEntity> read(int id) {
    return _groupRepository.read(id);
  }

  @override
  Future<NoteGroupEntity> update(NoteGroupEntity item) {
    return _groupRepository.update(item);
  }
}

class ListNoteGroupState extends Equatable {
  final List<NoteGroupEntity>? groups;

  const ListNoteGroupState({this.groups});

  factory ListNoteGroupState.init() {
    return const ListNoteGroupState();
  }

  @override
  List<Object?> get props => [
        groups.hashCode,
      ];

  ListNoteGroupState copyWith({
    List<NoteGroupEntity>? groups,
  }) {
    return ListNoteGroupState(
      groups: groups ?? this.groups,
    );
  }
}
