import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:note_app/base_presentation/page/base_page.dart';
import 'package:note_app/data/entity/app_file.dart';
import 'package:note_app/data/entity/note_entity.dart';
import 'package:note_app/util/theme_util.dart';
import 'package:note_app/widget/file_picker.dart';
import 'package:note_app/widget/show_bottom_sheet.dart';
import 'package:open_file_plus/open_file_plus.dart';

class AddNoteDetailPage extends StatefulWidget with ShowBottomSheet<NoteEntity> {
  const AddNoteDetailPage({super.key, this.initNoteGroup, this.initNote});

  final NoteGroupEntity? initNoteGroup;
  final NoteEntity? initNote;

  @override
  State<AddNoteDetailPage> createState() => _AddNoteDetailPageState();
}

class _AddNoteDetailPageState extends BasePageState<AddNoteDetailPage> with ThemeUtil {
  final TextEditingController _controller = TextEditingController();

  bool get haveText => _controller.text.trim().isNotEmpty;

  NoteGroupEntity? group;

  DateTime? date;

  ///check if init note is not null, it's mean this view is using for editing
  bool get isEditView => widget.initNote != null;

  NoteEntity get initNote => widget.initNote!;

  ///use HashSet to storage AppFile list in which each object can occur only once.
  Set<AppFile> files = HashSet(
    equals: (p0, p1) {
      return p0.name == p1.name;
    },
    hashCode: (p0) => p0.name.hashCode,
  );

  @override
  void initState() {
    super.initState();

    group = widget.initNoteGroup;

    ///set initial data for input form
    if (isEditView) {
      _controller.text = initNote.description ?? '';
      date = initNote.date;
      files.addAll([...?initNote.attachments?.where((e) => e.file != null).map((e) => e.file!)]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration.collapsed(hintText: 'Note description...'),
            autofocus: true,
            onSubmitted: (value) {
              //handle for enter by keyboard
              if (haveText) {
                onSave();
              }
            },
          ),
        ),
        const SizedBox(height: 4),
        Flexible(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (date != null)
                    InputChip(
                      label: Text(date!.toString().split(' ').first),
                      onPressed: _showDatePicker,
                      deleteIcon: const Icon(
                        Icons.close_rounded,
                        size: 18,
                      ),
                      onDeleted: () {
                        date = null;
                        setState(() {});
                      },
                    ),
                  if (files.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      children: [
                        ...files.map(
                          (e) {
                            return InputChip(
                              label: Text(e.name),
                              onPressed: () {
                                OpenFile.open(e.path);
                              },
                              deleteIcon: const Icon(
                                Icons.close_rounded,
                                size: 18,
                              ),
                              onDeleted: () {
                                files.remove(e);
                                setState(() {});
                              },
                            );
                          },
                        )
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              IconButton(onPressed: _showDatePicker, icon: const Icon(Icons.calendar_month_outlined)),
              IconButton(
                  onPressed: () {
                    const AnyFilePicker(
                      allowMultiple: true,
                    ).opeFilePicker().then(
                      (selectedFiles) {
                        if (selectedFiles != null) {
                          files.addAll(selectedFiles);
                          setState(() {});
                        }
                      },
                    );
                  },
                  icon: const Icon(Icons.attach_file_outlined)),
              const Spacer(),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: !haveText ? null : onSave,
                      icon: Text(
                        'Save',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: haveText ? null : theme.disabledColor,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  void onSave() {
    if (isEditView) {
      Navigator.of(context).pop(
        initNote.copyWith2(
          groupId: group?.id,
          description: _controller.text.trim(),
          date: date,
          attachments: files.map((e) => AttachmentEntity(file: e)).toList(),
        ),
      );
    } else {
      Navigator.of(context).pop(
        NoteEntity(
          id: null,
          isDone: null,
          isDeleted: null,
          updatedDateTime: null,
          groupId: group?.id,
          description: _controller.text.trim(),
          date: date,
          attachments: files.map((e) => AttachmentEntity(file: e)).toList(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(3000),
      initialDate: date ?? DateTime.now(),
    ).then(
      (selectedDate) {
        if (selectedDate != null) {
          date = selectedDate;
          setState(() {});
        }
      },
    );
  }
}
