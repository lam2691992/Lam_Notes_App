import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/data/entity/note_entity.dart';
import 'package:note_app/feature/home/bloc/crud_note_bloc.dart';
import 'package:note_app/feature/home/bloc/group_bloc.dart';
import 'package:note_app/feature/home/presentation/calendar_page.dart';
import 'package:note_app/util/list_util.dart';
import 'package:share_plus/share_plus.dart';

class NoteCheckWidget extends StatelessWidget {
  const NoteCheckWidget({
    super.key,
    required this.note,
    required this.onCheckChanged,
    this.onTap,
  });

  final NoteEntity note;
  final ValueChanged<bool?> onCheckChanged;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Checkbox(
          value: note.isDone ?? false,
          onChanged: onCheckChanged,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.description ?? '',
              style: theme.textTheme.titleMedium,
            ),
            if (note.date != null)
              Text(
                note.date.toString(),
                style: theme.textTheme.labelSmall,
              ),
          ],
        ),
      ],
    );
  }
}

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
    this.onTap,
    this.showDelete = true,
    this.showCheckDone = true,
    this.showGroup = true,
    this.isReadOnly = false,
  });

  final NoteEntity note;
  final VoidCallback? onTap;
  final bool showDelete;
  final bool showCheckDone;
  final bool showGroup;
  final bool isReadOnly;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    bool isShowSubtitle = note.date != null || note.attachments.isNotNullAndNotEmpty;

    return ListTile(
      onTap: onTap,
      leading: showCheckDone
          ? Checkbox(
              value: note.isDone ?? false,
              onChanged: (isDone) {
                if (isDone != null) {
                  context.read<CrudNoteBloc>().checkDone(isDone, note);
                }
              },
            )
          : null,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            note.description ?? '',
            style: theme.textTheme.titleLarge,
          ),
          if (showGroup)

            ///Loading note group information
            FutureBuilder<NoteGroupEntity?>(
              future: Future.sync(
                () {
                  if (note.groupId != null) {
                    return context.read<ListNoteGroupCubit>().read(note.groupId!);
                  }

                  return null;
                },
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data?.name != null) {
                    return Chip(
                      label: Text('${snapshot.data!.name}'),
                      padding: const EdgeInsets.all(4),
                    );
                  }
                }
                return const SizedBox();
              },
            ),
        ],
      ),
      subtitle: !isShowSubtitle
          ? null
          : Column(
              children: [
                if (note.date != null)
                  Row(
                    children: [
                      const Icon(
                        Icons.date_range_outlined,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text('${note.date?.dateString()}'),
                    ],
                  ),
                if (note.attachments.isNotNullAndNotEmpty)
                  Row(
                    children: [
                      const Icon(
                        Icons.attach_file_rounded,
                        size: 14,
                      ),
                      Text('${note.attachments?.length}'),
                    ],
                  ),
              ],
            ),
      contentPadding: EdgeInsets.zero,
      trailing: isReadOnly
          ? const SizedBox()
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () async {
                      //get group information to share data
                      NoteGroupEntity? group;

                      if (note.groupId != null) {
                        group = await context.read<ListNoteGroupCubit>().read(note.groupId!);
                      }

                      Share.share(note.getShareData(group));
                    },
                    icon: const Icon(Icons.share)),
                if (showDelete)
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<CrudNoteBloc>().delete(note);
                    },
                  )
              ],
            ),
    );
  }
}
