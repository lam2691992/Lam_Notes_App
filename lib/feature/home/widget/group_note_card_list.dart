import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/data/entity/note_entity.dart';
import 'package:note_app/feature/home/bloc/group_bloc.dart';
import 'package:note_app/feature/home/presentation/add_group_note_page.dart';

import 'package:note_app/feature/home/widget/note_group_card.dart';
import 'package:note_app/feature/home/widget/note_group_list_widget.dart';

class GroupNoteCardList extends StatefulWidget {
  const GroupNoteCardList({
    super.key,
  });

  @override
  State<GroupNoteCardList> createState() => _GroupNoteCardListState();
}

class _GroupNoteCardListState extends State<GroupNoteCardList> {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<ListNoteGroupCubit, ListNoteGroupState, List<NoteGroupEntity>?>(
      selector: (state) => state.groups,
      builder: (context, groups) {
        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 60),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemBuilder: (context, index) {
            if (index == 0) {
              ///Show card to create new group
              return const AddNoteGroupWidget();
            }

            return NoteGroupCard(
              group: groups![index - 1],
            );
          },
          itemCount: (groups?.length ?? 0) + 1,
        );
      },
    );
  }
}
