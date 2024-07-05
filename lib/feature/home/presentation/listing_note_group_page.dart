import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/base_presentation/page/base_page.dart';
import 'package:note_app/feature/home/bloc/group_bloc.dart';
import 'package:note_app/util/list_util.dart';

class ListingNoteGroupPage extends StatefulWidget {
  const ListingNoteGroupPage({super.key});

  @override
  State<ListingNoteGroupPage> createState() => _ListingNoteGroupPageState();
}

class _ListingNoteGroupPageState extends BasePageState<ListingNoteGroupPage> {
  bool isShowDeleteMode = false;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Groups'),
      actions: [
        Row(
          children: [
            Icon(
              Icons.delete,
              color: isShowDeleteMode ? null : Theme.of(context).disabledColor,
            ),
            Transform.scale(
              scale: 0.8,
              child: Switch(
                value: isShowDeleteMode,
                onChanged: (value) {
                  isShowDeleteMode = !isShowDeleteMode;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return BlocBuilder<ListNoteGroupCubit, ListNoteGroupState>(
      builder: (context, state) {
        if (!state.groups.isNotNullAndNotEmpty) {
          return const SizedBox();
        }
        final groups = state.groups!;
        return ListView.separated(
          itemBuilder: (context, index) {
            final group = groups[index];
            return ListTile(
              title: Text(group.name ?? ''),
              trailing: !isShowDeleteMode
                  ? null
                  : IconButton(
                      onPressed: () {
                        context.read<ListNoteGroupCubit>().delete(group);
                      },
                      icon: Icon(Icons.delete),
                    ),
            );
          },
          separatorBuilder: (context, index) => Divider(height: 1),
          itemCount: state.groups!.length,
        );
      },
    );
  }
}
