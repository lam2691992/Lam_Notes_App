import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/data/entity/note_entity.dart';
import 'package:note_app/data/repository/search_repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Cubit<SearchState> {
  SearchBloc() : super(SearchState()) {
    _streamSubscription =
        stream.map((event) => event.searchInput?.trim()).debounceTime(const Duration(microseconds: 500)).listen(
      (searchInput) {
        if (searchInput == null || searchInput.isEmpty) {
          emit(SearchState(searchInput: searchInput));
        } else {
          searchRepositoryImpl.search(searchInput).then(
            (notes) {
              emit(state.copyWith(notes: notes));
            },
          );
        }
      },
    );
  }

  late final StreamSubscription<String?> _streamSubscription;

  final SearchRepositoryImpl searchRepositoryImpl = SearchRepositoryImpl();

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }

  void onSearchChange(String? input) {
    emit(state.copyWith(search: input));
  }
}

class SearchState extends Equatable {
  final String? searchInput;

  final List<NoteEntity>? notes;

  const SearchState({
    this.searchInput,
    this.notes,
  });

  @override
  List<Object?> get props => [
        searchInput,
        notes.hashCode,
      ];

  SearchState copyWith({
    String? search,
    List<NoteEntity>? notes,
  }) {
    return SearchState(
      searchInput: search ?? this.searchInput,
      notes: notes ?? this.notes,
    );
  }
}
