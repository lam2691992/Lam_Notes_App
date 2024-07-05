import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:note_app/data/entity/app_file.dart';

class AppFilePicker extends StatelessWidget {
  const AppFilePicker({Key? key, required this.allowMultiple, required this.fileType}) : super(key: key);

  final bool allowMultiple;
  final FileType fileType;

  Future<List<AppFile>?> opeFilePicker() {
    return FilePicker.platform.pickFiles(type: fileType, allowMultiple: allowMultiple).then((filePickerResult) {
      return filePickerResult?.files
          .map(
            (file) => AppFile(name: file.name, path: file.path ?? ""),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

class VideoFilePicker extends AppFilePicker {
  const VideoFilePicker({
    super.key,
    required super.allowMultiple,
  }) : super(fileType: FileType.video);
}

class AudioFilePicker extends AppFilePicker {
  const AudioFilePicker({
    super.key,
    required super.allowMultiple,
  }) : super(fileType: FileType.audio);
}

class AnyFilePicker extends AppFilePicker {
  const AnyFilePicker({
    super.key,
    required super.allowMultiple,
  }) : super(fileType: FileType.any);
}
