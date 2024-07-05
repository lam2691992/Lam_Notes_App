/*
* Nội dung ghi chú:
- mô tả của ghi chú
- trạng thái hoàn tất
- trạng thái xoá
- thời gian đánh dấu
- thời gian chỉnh sửa
- nội dung đính kèm
*
* */

import 'package:equatable/equatable.dart';
import 'package:note_app/data/entity/app_file.dart';
import 'package:note_app/data/repository/note_repository_impl.dart';
import 'package:note_app/feature/home/presentation/calendar_page.dart';

class NoteEntity extends Equatable implements GetId<int> {
  final int? id;

  ///[groupId] is id of [@NoteGroupEntity]
  final int? groupId;
  final String? description;
  final bool? isDone;
  final bool? isDeleted;
  final DateTime? date;
  final DateTime? updatedDateTime;
  final List<AttachmentEntity>? attachments;

  const NoteEntity({
    required this.id,
    required this.groupId,
    required this.description,
    required this.isDone,
    required this.isDeleted,
    required this.date,
    required this.updatedDateTime,
    required this.attachments,
  });

  factory NoteEntity.defaultNote() {
    return const NoteEntity(
      id: null,
      groupId: null,
      description: null,
      isDone: null,
      isDeleted: null,
      date: null,
      updatedDateTime: null,
      attachments: null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        groupId,
        description,
        isDone,
        isDeleted,
        date,
        updatedDateTime,
        attachments,
      ];

  @override
  int? get getId => id;

  NoteEntity copyWith({
    int? id,
    int? groupId,
    String? description,
    bool? isDone,
    bool? isDeleted,
    DateTime? date,
    DateTime? updatedDateTime,
    List<AttachmentEntity>? attachments,
  }) {
    return NoteEntity(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
      date: date ?? this.date,
      updatedDateTime: updatedDateTime ?? this.updatedDateTime,
      attachments: attachments ?? this.attachments,
    );
  }
}

//Lưu thông tin đính kèm
class AttachmentEntity extends Equatable {
  final AppFile? file;

  AttachmentEntity({required this.file});

  @override
  List<Object?> get props => [file];
}

class NoteGroupEntity extends Equatable implements GetId<int> {
  final int? id;
  final String? name;
  final DateTime? updatedDateTime;
  final bool? isDeleted;

  const NoteGroupEntity({
    this.id,
    this.name,
    this.updatedDateTime,
    this.isDeleted,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        updatedDateTime,
        isDeleted,
      ];

  NoteGroupEntity copyWith({
    int? id,
    String? name,
    DateTime? updatedDateTime,
    bool? isDeleted,
  }) {
    return NoteGroupEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      updatedDateTime: updatedDateTime ?? this.updatedDateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  int? get getId => id;
}

extension ShareNote on NoteEntity {
  ///format
  ///	{group name} - {note description} - {done status} - {date}
  ///	{Phân loại} - {Nội dung ghi chú} - {Trạng thái hoàn tất} - {Thời gian đánh dấu}
  String getShareData(NoteGroupEntity? group) {
    List<String> noteSegment = [
      group?.name != null ? group!.name! : '',
      description ?? '',
      _getStatusString(),
      date?.dateString() ?? '',
    ];

    return noteSegment
        .where(
          (t) => t.isNotEmpty,
        )
        .join(' - ');
  }

  String _getStatusString() {
    if (isDone ?? false) {
      return 'Đã hoàn tất';
    }

    return '';
  }
}
