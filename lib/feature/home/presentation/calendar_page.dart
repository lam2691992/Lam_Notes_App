import 'dart:collection';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:note_app/base_presentation/page/base_page.dart';
import 'package:note_app/data/entity/note_entity.dart';
import 'package:note_app/data/observer_data/note_observer_data.dart';
import 'package:note_app/data/observer_data/note_observer_data_impl.dart';
import 'package:note_app/feature/home/widget/note_check_widget.dart';
import 'package:table_calendar/table_calendar.dart';

extension DateString on DateTime {
  String dateString() => toString().split(' ').first;
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends BasePageState<CalendarPage> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar();
  }

  DateTime _focusedDay = DateTime.now();
  late DateTime _selectedDay = _focusedDay;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        TableCalendar<int>(
          firstDay: DateTime(1900),
          lastDay: DateTime(3000),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, day, events) {
              return _CountNotesByDate(key: ValueKey(day.dateString()), date: day);
            },
          ),
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
        ),
        Text(
          'Selected date: ' + _selectedDay.dateString(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Expanded(
          child: _NoteListByDate(
            key: ValueKey(_selectedDay.dateString()),
            date: _selectedDay,
          ),
        ),
      ],
    );
  }
}

class _NoteListByDate extends StatefulWidget {
  const _NoteListByDate({super.key, required this.date});

  final DateTime date;

  @override
  State<_NoteListByDate> createState() => _NoteListByDateState();
}

class _NoteListByDateState extends State<_NoteListByDate> {
  late final NoteObserverData noteObserverData = ListNoteByDateObserverDataIsar(date: widget.date);

  List<NoteEntity> notes = [];

  @override
  void initState() {
    super.initState();
    noteObserverData.listener(
      (value) {
        notes = value;
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    noteObserverData.cancelListen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (notes.isEmpty) {
      return Text(
        'Have no note',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).hintColor,
            ),
      );
    }

    return ListView.separated(
      itemBuilder: (context, index) {
        return NoteCard(
          note: notes[index],
        );
      },
      separatorBuilder: (context, index) => const Divider(height: 0),
      itemCount: notes.length,
    );
  }
}

class _CountNotesByDate extends StatefulWidget {
  const _CountNotesByDate({super.key, required this.date});

  final DateTime date;

  @override
  State<_CountNotesByDate> createState() => _CountNotesByDateState();
}

class _CountNotesByDateState extends State<_CountNotesByDate> {
  late final NoteCountObserverData noteCountObserverData = NoteCountByDateObserverDataIsar(date: widget.date);

  int count = 0;

  @override
  void initState() {
    super.initState();
    noteCountObserverData.listener((count) {
      this.count = count;
      setState(() {});
    });
  }

  @override
  void dispose() {
    noteCountObserverData.cancelListen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (count == 0) {
      return const SizedBox();
    }

    return Container(
      width: 4,
      height: 4,
      decoration: const BoxDecoration(
        color: Colors.cyan,
        shape: BoxShape.circle,
      ),
    );
  }
}
