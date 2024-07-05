import 'package:flutter/material.dart';
import 'package:note_app/util/navigator/app_navigator.dart';
import 'package:note_app/util/navigator/app_page.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key, this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        AppNavigator.to(GetSearchPage());
      },
      child: const AbsorbPointer(
        absorbing: true,
        child: Hero(
          tag: 'search_view',
          child: SearchBar(
            padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(horizontal: 16.0)),
            leading: Icon(Icons.search),
            hintText: 'Search notes...',
          ),
        ),
      ),
    );
  }
}
