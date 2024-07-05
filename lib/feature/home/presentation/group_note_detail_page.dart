import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:note_app/base_presentation/page/base_page.dart';
import 'package:note_app/data/entity/note_entity.dart';
import 'package:note_app/data/observer_data/note_observer_data_impl.dart';
import 'package:note_app/data/repository/note_repository_impl.dart';
import 'package:note_app/feature/home/bloc/crud_note_bloc.dart';
import 'package:note_app/feature/home/bloc/group_detail_bloc.dart';

import 'package:note_app/feature/home/presentation/add_note_detail_page.dart';
import 'package:note_app/feature/home/widget/note_check_widget.dart';
import 'package:note_app/util/list_util.dart';
import 'package:share_plus/share_plus.dart';

class GroupNoteDetailPage extends StatefulWidget {
  const GroupNoteDetailPage({super.key, required this.group});
  final NoteGroupEntity group;

  @override
  _GroupNoteDetailPageState createState() => _GroupNoteDetailPageState();
}

class _GroupNoteDetailPageState extends BasePageState<GroupNoteDetailPage> {
  late final GroupDetailBloc groupDetailBloc = GroupDetailBloc(
    group: widget.group,
    noteObserverData: ListNoteByGroupObserverDataIsar(group: widget.group),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => groupDetailBloc,
      child: super.build(context),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(widget.group.name ?? ''),
      actions: [
        BlocSelector<GroupDetailBloc, GroupDetailState, bool>(
          selector: (state) => state.isDeleteMode ?? false,
          builder: (context, state) {
            return Row(
              children: [
                Icon(
                  Icons.delete,
                  color: state ? null : Theme.of(context).disabledColor,
                ),
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: state,
                    onChanged: (value) {
                      groupDetailBloc.switchDeleteMode(value);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    final theme = Theme.of(context);

    return BlocSelector<GroupDetailBloc, GroupDetailState, bool>(
      selector: (state) => state.isDeleteMode ?? false,
      builder: (context, showDelete) {
        return BlocSelector<GroupDetailBloc, GroupDetailState, List<NoteEntity>?>(
          selector: (state) => state.notes?.reversed.toList(),
          builder: (context, notes) {
            if (!notes.isNotNullAndNotEmpty) {
              return GestureDetector(
                onTap: () {
                  addNewNote();
                },
                child: Center(
                  child: Icon(
                    Icons.add,
                    size: 200,
                    color: theme.hintColor,
                  ),
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 160),
              itemBuilder: (context, index) {
                final item = notes[index];

                return NoteCard(
                  note: item,
                  onTap: () => editNote(item),
                  showDelete: showDelete,
                  showGroup: false,
                );
              },
              separatorBuilder: (context, index) => const Divider(height: 0),
              itemCount: notes!.length,
            );
          },
        );
      },
    );
  }

  @override
  Widget? buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        addNewNote();
      },
      child: Icon(Icons.add),
    );
  }

  void addNewNote() {
    AddNoteDetailPage(
      initNoteGroup: widget.group,
    ).showBottomSheet(context).then(
      (note) {
        if (note != null) {
          context.read<CrudNoteBloc>().create(note);
        }
      },
    );
  }

  void editNote(NoteEntity note) {
    AddNoteDetailPage(
      initNote: note,
      initNoteGroup: widget.group,
    ).showBottomSheet(context).then(
      (note) {
        if (note != null) {
          context.read<CrudNoteBloc>().update(note);
        }
      },
    );
  }
}
