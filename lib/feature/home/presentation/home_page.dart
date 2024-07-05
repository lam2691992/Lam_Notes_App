import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:note_app/base_presentation/page/base_page.dart';
import 'package:note_app/base_presentation/view/view.dart';

import 'package:note_app/feature/home/widget/group_note_card_list.dart';
import 'package:note_app/feature/home/widget/note_group_card.dart';
import 'package:note_app/feature/home/widget/note_group_list_widget.dart';
import 'package:note_app/resource/string.dart';
import 'package:note_app/util/navigator/app_navigator.dart';
import 'package:note_app/util/navigator/app_page.dart';
import 'package:note_app/widget/search_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomePage> {
  @override
  Widget buildBody(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildSearchBar(),
          // _buildNoteGroupList(),
          Expanded(
            child: _buildListGroupCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: SearchView(),
    );
  }

  Widget _buildNoteGroupList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const NoteGroupListWidget(),
      ],
    );
  }

  Widget _buildListGroupCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: const GroupNoteCardList()),
      ],
    );
  }
}

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const HomePage(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(bottom: 30, left: 32, right: 32),
              child: BottomBarFloating(
                borderRadius: BorderRadius.circular(40),
                backgroundColor: Theme.of(context).cardColor,
                items: items,
                indexSelected: 0,
                paddingVertical: 17,
                onTap: (int index) {
                  if (index == 1) {
                    AppNavigator.to(GetCalendarPage());
                  } else if (index == 2) {
                    AppNavigator.to(GetDeletedPage());
                  }
                },
                color: Colors.black,
                colorSelected: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const List<TabItem> items = [
  TabItem(icon: Icons.home),
  TabItem(icon: Icons.calendar_month_outlined),
  TabItem(icon: Icons.auto_delete_outlined),
];
