import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/base_presentation/page/base_page.dart';
import 'package:note_app/data/entity/note_entity.dart';
import 'package:note_app/feature/home/bloc/search_bloc.dart';
import 'package:note_app/feature/home/widget/note_check_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends BasePageState<SearchPage> {
  final SearchBloc searchBloc = SearchBloc();
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textEditingController.addListener(onTextChange);
  }

  void onTextChange() {
    searchBloc.onSearchChange(textEditingController.text);
  }

  @override
  void dispose() {
    textEditingController.removeListener(onTextChange);
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => searchBloc,
      child: super.build(context),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Hero(
              tag: 'search_view',
              child: SearchBar(
                autoFocus: true,
                controller: textEditingController,
                leading: AnimatedBuilder(
                  animation: textEditingController,
                  builder: (context, child) {
                    if (textEditingController.text.isEmpty) {
                      return const BackButton();
                    }
                    return child!;
                  },
                  child: IgnorePointer(
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    ),
                  ),
                ),
                trailing: [
                  AnimatedBuilder(
                    animation: textEditingController,
                    builder: (context, child) {
                      if (textEditingController.text.isEmpty) {
                        return const SizedBox();
                      }
                      return child!;
                    },
                    child: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        textEditingController.clear();
                      },
                    ),
                  ),
                ],
                hintText: 'Search notes...',
              ),
            ),
          ),
          Expanded(
            child: BlocSelector<SearchBloc, SearchState, List<NoteEntity>?>(
              selector: (state) => state.notes,
              builder: (context, notes) {
                if (textEditingController.text.isEmpty) {
                  return const Center(child: Text('Enter keywords...'));
                }

                if (notes?.isEmpty ?? false) {
                  return const Center(
                    child: Text('Find not found'),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 160),
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return NoteCard(
                      note: note,
                      showGroup: true,
                      showDelete: false,
                      showCheckDone: false,
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: notes!.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
