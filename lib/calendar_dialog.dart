import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarDialog extends StatelessWidget {
  final DateTime selectedDay;
  final DateTime focusedDay;
  final Map<DateTime, List<Event>>
      events; //Danh sasch suwj kieejn dduowjc lieen keest vowsi mooxi ngafy
  final Function(Map<DateTime, List<Event>>)
      onEventsUpdated; // Hafm caajp nhaajt suwj kieejn

  const CalendarDialog({
    super.key,
    required this.selectedDay,
    required this.focusedDay,
    required this.events,
    required this.onEventsUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        width: 500,
        height: 500,
        child: Column(
          children: [
            AppBar(
              title: const Text(
                'Calendar',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TableCalendar(
                focusedDay: focusedDay,
                firstDay: DateTime(2024, 1, 1),
                lastDay: DateTime(2024, 12, 31),
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: const HeaderStyle(
                  titleTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  formatButtonVisible: false,
                ),
                eventLoader: (day) =>
                    events[day] ?? [], // Tari suwj kieejn cho mooxi ngafy
                onDaySelected: (selectedDate, focusedDay) {
                  _createEvent(context, selectedDate,
                      focusedDay); // Mowr dialog tajo suwj kieejn khi chojn ngafy
                },
                
              ),
            ),
          ],
        ),
      ),
    );
  }

// Tajo suwj kieejn mowsi
void _createEvent(BuildContext context, DateTime selectedDate, DateTime focusedDay) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      String eventTitle = '';
      return AlertDialog(
        title: const Text('Create Event'),
        content: TextField(
          onChanged: (value) {
            eventTitle = value;
          },
          decoration: const InputDecoration(hintText: 'Enter Event Title'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Đóng hộp thoại khi nhấn nút "Cancel"
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (eventTitle.isNotEmpty) {
                // Tạo một bản sao có thể thay đổi của events
                Map<DateTime, List<Event>> updatedEvents = Map.from(events);

                // Lấy danh sách sự kiện của ngày được chọn
                List<Event> dayEvents = updatedEvents[selectedDate] ?? [];

                // Thêm sự kiện mới vào danh sách sự kiện
                dayEvents.add(Event(eventTitle));

                // Cập nhật events với danh sách sự kiện đã thay đổi
                updatedEvents[selectedDate] = dayEvents;

                // Gọi hàm onEventsUpdated để thông báo về việc cập nhật events
                onEventsUpdated(updatedEvents);

                // Đóng hộp thoại khi nhấn nút "Save"
                Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
}

// Cập nhật giao diện
void updateCalendarUI(Map<DateTime, List<Event>> events) {
  setState(() {
    // Lặp qua các ngày có sự kiện được tạo
    events.forEach((day, events) {
      // Kiểm tra nếu ngày hiện tại có trong danh sách các ngày có sự kiện được tạo
      if (events.isNotEmpty) {
        // Cập nhật UI của ngày trong Table Calendar
        // Đây chỉ là một ví dụ, bạn cần tìm cách cập nhật phần hiển thị của ngày tương ứng trong Table Calendar của bạn
        // Ví dụ: tableCalendar.setDayAttributes(day, attributes: {'background': Colors.red});
      }
    });
  });
}

void setState(Null Function() param0) {
}

// Lớp đại diện cho một sự kiện
class Event {
  final String title;

  Event(this.title);
}
