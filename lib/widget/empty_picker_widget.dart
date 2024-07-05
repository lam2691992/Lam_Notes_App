import 'package:flutter/material.dart';
import 'package:note_app/base_presentation/view/view.dart';
import 'package:note_app/data/entity/app_file.dart';
import 'package:note_app/resource/string.dart';
import 'package:note_app/widget/file_picker.dart';

class EmptyPickerWidget extends StatelessWidget {
  const EmptyPickerWidget({
    super.key,
    required this.canPickMultipleFile,
    required this.onGetFiles,
  });

  final bool canPickMultipleFile;
  final ValueChanged<List<AppFile>> onGetFiles;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openPickerDialog,
      child: ColoredBox(
        color: Colors.transparent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_circle_outline,
                size: 200,
              ),
              const SizedBox(height: 16),
              Text("canPickMultipleFile"
                  // ? ConvertPageLocalization.tapToSelectFiles
                  // : ConvertPageLocalization.tapToSelectFiles,
                  ),
            ],
          ),
        ),
      ),
    );
  }

  void _openPickerDialog() async {
    AnyFilePicker(allowMultiple: canPickMultipleFile).opeFilePicker().then((appFiles) {
      setFiles(appFiles ?? []);
    }).catchError((error) {
      //todo: handle error if necessary
    });
  }

  void setFiles(List<AppFile> filePaths) {
    onGetFiles(filePaths);
  }
}
