import 'package:flutter/material.dart';
import 'package:note_app/base_presentation/page/base_page.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends BasePageState<AddNotePage> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar();
  }

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [],
    );
  }
}
