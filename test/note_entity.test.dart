import 'package:flutter_test/flutter_test.dart';
import 'package:note_app/data/entity/note_entity.dart';

void main() {
  group(
    'test_share_data',
    () {
      test(
        'content of null note',
        () {
          final NoteEntity note = NoteEntity.defaultNote();
          expect(note.getShareData(null), '');
        },
      );

      test(
        'content without group - just have description',
        () {
          final NoteEntity note = NoteEntity.defaultNote().copyWith(
            description: 'description',
          );
          expect(note.getShareData(null), 'description');
        },
      );

      test(
        'content without group - done status',
        () {
          final NoteEntity note = NoteEntity.defaultNote().copyWith(
            description: 'description',
            isDone: true,
          );
          expect(note.getShareData(null), 'description - Đã hoàn tất');
        },
      );

      test(
        'content without group - have date',
        () {
          final NoteEntity note = NoteEntity.defaultNote().copyWith(
            description: 'description',
            isDone: true,
            date: DateTime(2024, 7, 4),
          );
          expect(note.getShareData(null), 'description - Đã hoàn tất - 2024-07-04');
        },
      );

      test(
        'full data',
        () {
          final NoteEntity note = NoteEntity.defaultNote().copyWith(
            description: 'description',
            isDone: true,
            date: DateTime(2024, 7, 4),
          );
          expect(note.getShareData(const NoteGroupEntity(name: 'group-name')),
              'group-name - description - Đã hoàn tất - 2024-07-04');
        },
      );
    },
  );
}
