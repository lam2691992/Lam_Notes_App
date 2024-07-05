import 'package:isar/isar.dart';
import 'package:note_app/data/entity/note_entity.dart';

part 'note_collection.g.dart';

@collection
class NoteGroupCollection {
  Id id = Isar.autoIncrement;
  String? name;
  DateTime? updatedDateTime;
  bool? isDeleted;
}

@collection
class NoteCollection {
  Id id = Isar.autoIncrement;
  int? groupId;
  String? description;
  bool? isDone;
  bool? isDeleted;
  DateTime? date;
  DateTime? updatedDateTime;
  List<AttachmentCollection>? attachments;
}

@embedded
class AttachmentCollection {
  final String? path;
  final String? name;

  AttachmentCollection({
    this.path,
    this.name,
  });
}
