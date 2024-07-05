import 'package:flutter/material.dart';
import 'package:note_app/data/entity/note_entity.dart';
import 'package:note_app/feature/home/presentation/calendar_page.dart';
import 'package:note_app/feature/home/presentation/deleted_page.dart';
import 'package:note_app/feature/home/presentation/group_note_detail_page.dart';
import 'package:note_app/feature/home/presentation/home_page.dart';
import 'package:note_app/feature/home/presentation/listing_note_group_page.dart';
import 'package:note_app/feature/home/presentation/search_page.dart';

sealed class AppPage {
  final String path;

  AppPage(this.path);

  Widget? getPage(Object? arguments);
}

class GetHomePage extends AppPage {
  GetHomePage() : super('/home');

  @override
  Widget? getPage(Object? arguments) {
    return const MainLayout();
  }
}

class GetDeletedPage extends AppPage {
  GetDeletedPage() : super('/deleted-history');

  @override
  Widget? getPage(Object? arguments) {
    return const DeletedPage();
  }
}

class GetGroupNoteDetailPage extends AppPage {
  GetGroupNoteDetailPage() : super('/group-detail');

  @override
  Widget? getPage(Object? arguments) {
    return GroupNoteDetailPage(
      group: arguments as NoteGroupEntity,
    );
  }
}

class GetSearchPage extends AppPage {
  GetSearchPage() : super('/search');

  @override
  Widget? getPage(Object? arguments) {
    return SearchPage();
  }
}

class GetCalendarPage extends AppPage {
  GetCalendarPage() : super('/calendar');

  @override
  Widget? getPage(Object? arguments) {
    return const CalendarPage();
  }
}

class GetListingNoteGroupPage extends AppPage {
  GetListingNoteGroupPage() : super('/group-note/listing');

  @override
  Widget? getPage(Object? arguments) {
    return const ListingNoteGroupPage();
  }
}
