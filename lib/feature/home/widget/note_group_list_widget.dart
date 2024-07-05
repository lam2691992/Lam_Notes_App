import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/data/entity/note_entity.dart';
import 'package:note_app/feature/home/bloc/group_bloc.dart';

import 'package:note_app/feature/home/presentation/add_group_note_page.dart';
import 'package:note_app/util/navigator/app_navigator.dart';
import 'package:note_app/util/navigator/app_page.dart';

class AddNoteGroupWidget extends StatefulWidget {
  const AddNoteGroupWidget({super.key});

  @override
  State<AddNoteGroupWidget> createState() => _AddNoteGroupWidgetState();
}

class _AddNoteGroupWidgetState extends State<AddNoteGroupWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        ///show add new group bottom sheet
        const AddGroupNotePage().showBottomSheet(context).then(
          (groupName) {
            if (groupName != null) {
              context.read<ListNoteGroupCubit>().createByName(groupName);
            }
          },
        );
      },
      child: Card(
        color: theme.secondaryHeaderColor,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add,
                  size: 100,
                  color: theme.hintColor,
                ),
                Text(
                  'New Note Group',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.hintColor,
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              top: 0,
              child: BlocSelector<ListNoteGroupCubit, ListNoteGroupState, List<NoteGroupEntity>?>(
                selector: (state) => state.groups,
                builder: (context, groups) {
                  if (groups?.isEmpty ?? true) {
                    return const SizedBox();
                  }

                  return IconButton(
                    onPressed: () {
                      AppNavigator.to(GetListingNoteGroupPage());
                    },
                    icon: const Row(
                      children: [
                        Text('View all'),
                        Icon(Icons.navigate_next),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NoteGroupListWidget extends StatefulWidget {
  const NoteGroupListWidget({Key? key}) : super(key: key);

  @override
  _NoteGroupListWidgetState createState() => _NoteGroupListWidgetState();
}

class _NoteGroupListWidgetState extends State<NoteGroupListWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Expanded(
            child: BlocSelector<ListNoteGroupCubit, ListNoteGroupState, List<NoteGroupEntity>?>(
              selector: (state) => state.groups,
              builder: (context, groups) {
                if (groups?.isEmpty ?? true) {
                  return Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8)),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.add,
                          size: 80,
                        ),
                        SizedBox(width: 16),
                        Text('Add Group')
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Chip(label: Text(groups![index].name ?? ''));
                  },
                  itemCount: groups?.length ?? 0,
                  separatorBuilder: (context, index) => const SizedBox(width: 8),
                );
              },
            ),
          ),
          // OutlinedButton(
          //   onPressed: () {
          //     AddGroupNotePage().showBottomSheet(context).then(
          //       (groupName) {
          //         if (groupName != null) {
          //           context.read<ListNoteGroupCubit>().createByName(groupName);
          //         }
          //       },
          //     );
          //   },
          //   child: const Text('Add'),
          //   style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
          //         backgroundColor: WidgetStateProperty.all(Theme.of(context).primaryColor),
          //       ),
          // )
        ],
      ),
    );
  }
}
