import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/base_presentation/page/base_page.dart';
import 'package:note_app/data/entity/note_entity.dart';
import 'package:note_app/data/observer_data/note_observer_data_impl.dart';
import 'package:note_app/data/repository/note_repository_impl.dart';
import 'package:note_app/feature/home/bloc/deleted_list_bloc.dart';
import 'package:note_app/feature/home/widget/note_check_widget.dart';
import 'package:note_app/util/list_util.dart';

class DeletedPage extends StatefulWidget {
  const DeletedPage({Key? key}) : super(key: key);

  @override
  State<DeletedPage> createState() => _DeletedPageState();
}

class _DeletedPageState extends BasePageState<DeletedPage> {
  final DeletedListBloc deletedListBloc = DeletedListBloc(
    noteObserverData: DeletedListNoteByGroupObserverDataIsar(),
    noteRepository: NoteRepositoryImpl(),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => deletedListBloc,
      child: super.build(context),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('History'),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return BlocSelector<DeletedListBloc, DeletedListState, List<NoteEntity>?>(
      selector: (state) => state.notes,
      builder: (context, notes) {
        if (!notes.isNotNullAndNotEmpty) {
          return Container(
            height: 200,
            alignment: Alignment.center,
            child: Text(
              'Have no data',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final item = notes[index];

            return Row(
              children: [
                Expanded(
                  child: NoteCard(
                    note: item,
                    showGroup: true,
                    isReadOnly: true,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    deletedListBloc.restore(item);
                  },
                  icon: Icon(Icons.restore),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) => const Divider(height: 0),
          itemCount: notes!.length,
        );
      },
    );
  }
}
