import 'package:flutter/material.dart';
import 'package:note_app/base_presentation/page/base_page.dart';
import 'package:note_app/data/entity/note_entity.dart';
import 'package:note_app/util/navigator/app_navigator.dart';
import 'package:note_app/util/theme_util.dart';
import 'package:note_app/widget/custom_text_field.dart';
import 'package:note_app/widget/show_bottom_sheet.dart';

///[AddGroupNotePage] this widget is a view to create new group information
class AddGroupNotePage extends StatefulWidget with ShowBottomSheet<String> {
  const AddGroupNotePage({Key? key}) : super(key: key);

  @override
  State<AddGroupNotePage> createState() => _AddGroupNotePageState();
}

class _AddGroupNotePageState extends BasePageState<AddGroupNotePage> with ThemeUtil {
  final TextEditingController _controller = TextEditingController();

  bool get haveText => _controller.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  @override
  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration.collapsed(hintText: 'Input new group...'),
              autofocus: true,
              onSubmitted: (value) {
                //handle for enter by keyboard
                if (haveText) {
                  Navigator.of(context).pop(_controller.text);
                }
              },
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: !haveText
                        ? null
                        : () {
                            Navigator.of(context).pop(_controller.text);
                          },
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
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
