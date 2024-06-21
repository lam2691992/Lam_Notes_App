import 'package:flutter/material.dart';
import 'package:note_app/calendar_Dialog.dart';
import 'package:note_app/housework_screen.dart';
import 'package:note_app/important_screen.dart';
import 'package:note_app/notice_screen.dart';
import 'package:note_app/shoppingList_screen.dart';
import 'package:note_app/todolist_screen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({
    super.key,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class TextFieldControllerPair {
  final String type;
  final TextEditingController controller;
  final FocusNode focusNode;

  TextFieldControllerPair(this.type, this.controller, this.focusNode);
}

class _HomeScreenState extends State<Homescreen> {
  TextEditingController searchController = TextEditingController();
  TextEditingController importantController = TextEditingController();
  TextEditingController toDoListController = TextEditingController();
  TextEditingController shoppingListController = TextEditingController();
  TextEditingController houseworkController = TextEditingController();
  TextEditingController noticeController = TextEditingController();

  String _searchResult = '';
  List<FocusNode> _focusNodes = [];
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNodeImportant = FocusNode();
  final FocusNode _focusNodeToDoList = FocusNode();
  final FocusNode _focusNodeShoppingList = FocusNode();
  final FocusNode _focusNodeHousework = FocusNode();
  final FocusNode _focusNodeNotice = FocusNode();

  @override
  void initState() {
    super.initState();
    // Khởi tạo FocusNode cho mỗi TextField
    _focusNodes = [
      _focusNode1,
      _focusNode2,
      _focusNodeImportant,
      _focusNodeToDoList,
      _focusNodeShoppingList,
      _focusNodeHousework,
      _focusNodeNotice,
    ];
  }

  @override
  void dispose() {
    // Giải phóng tài nguyên FocusNode khi Widget bị hủy
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notes",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              child: IconButton(
                                icon: const Icon(Icons.search),
                                color: Colors.blue,
                                onPressed: () {
                                  _performSearchAndUpdate();
                                },
                              ),
                            ),
                          ),
                          hintText: "Search for notes",
                        ),
                        onSubmitted: (value) {
                          _performSearchAndUpdate();
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showCalendarDialog(context);
                      },
                      child: CircleAvatar(
                        radius: 35.0,
                        backgroundImage: const AssetImage('assets/lich.png'),
                        backgroundColor: Colors.grey[350],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 40,
              child: ListView(scrollDirection: Axis.horizontal, children: [
                const SizedBox(width: 5),
                TextButton(
                  onPressed: () {
                    _buildImportantScreen(
                        context, "Important", importantController);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: const Text('Important'),
                ),
                const SizedBox(width: 5),
                TextButton(
                  onPressed: () {
                    _buildTodoScreen(context, "To-do List", toDoListController);
                    // Xử lý khi nhấn nút To-do List
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: const Text('To-do List'),
                ),
                const SizedBox(width: 5),
                TextButton(
                  onPressed: () {
                    _buildShoppingListScreen(
                        context, "Important", shoppingListController);
                    // Xử lý khi nhấn nút
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: const Text('Shopping List'),
                ),
                const SizedBox(width: 5),
                TextButton(
                  onPressed: () {
                    _buildHouseworkScreen(
                        context, "Housework", houseworkController);
                    // Xử lý khi nhấn nút
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: const Text('Housework'),
                ),
                const SizedBox(width: 5),
                TextButton(
                  onPressed: () {
                    _buildNoticeScreen(context, "Notice", noticeController);
                    // Xử lý khi nhấn nút
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: const Text('Notice'),
                ),
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: importantController,
                    focusNode: _focusNodes[0],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 50.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true, // Đặt màu nền
                      fillColor: Colors.blue[100],
                      labelText: 'Important',
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onChanged: (_) => _clearSearchResult(),
                    textAlignVertical: TextAlignVertical.top,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextField(
                    controller: toDoListController,
                    focusNode: _focusNodes[1],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 50.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 248, 187, 242),
                      labelText: 'To-do List',
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onChanged: (_) => _clearSearchResult(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: shoppingListController,
                    focusNode: _focusNodes[2],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 50.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.orangeAccent,
                      labelText: 'Shopping List',
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onChanged: (_) => _clearSearchResult(),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextField(
                    controller: houseworkController,
                    focusNode: _focusNodes[3],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 50.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.green,
                      labelText: 'Housework',
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onChanged: (_) => _clearSearchResult(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                SizedBox(
                  width: 187,
                  child: TextField(
                    controller: noticeController,
                    focusNode: _focusNodes[4],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 50.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.orange,
                      labelText: 'Notice',
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onChanged: (_) => _clearSearchResult(),
                  ),
                ),
                const SizedBox(width: 56),
              ],
            ),
          )
        ]),
      ),
    );
  }

  void _showCalendarDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CalendarDialog(
          selectedDay: DateTime.now(), // Chọn một ngày cụ thể
          focusedDay: DateTime.now(), // Chọn một ngày cụ thể
          events: const {},
          onEventsUpdated: (Map<DateTime, List<Event>>
              updatedEvents) {}, // Đổi thành danh sách sự kiện thích hợp
        );
      },
    );
  }

  void _performSearchAndUpdate() {
    String searchQuery = searchController.text;
    String result = _performSearch(searchQuery);
    setState(() {
      _searchResult = result;
    });

    if (_searchResult.isNotEmpty) {
      // Tìm kiếm dữ liệu trùng lặp và tập trung vào nó
      _focusOnTextFieldContainingResult(context);
    }
  }

  void _clearSearchResult() {
    setState(() {
      _searchResult = '';
    });
  }

  String _performSearch(String searchQuery) {
    // Kiểm tra xem có khớp với bất kỳ giá trị nào trong danh sách không
    for (TextFieldControllerPair pair in _textFieldControllerPairs) {
      if (_containsSubstring(pair.controller.text, searchQuery)) {
        return 'Found a match: ${pair.controller.text}';
      }
    }
    return 'No match found';
  }

  List<TextFieldControllerPair> get _textFieldControllerPairs => [
        TextFieldControllerPair(
            'Important', importantController, _focusNodes[0]),
        TextFieldControllerPair(
            'To-do list', toDoListController, _focusNodes[1]),
        TextFieldControllerPair(
            'Shopping list', shoppingListController, _focusNodes[2]),
        TextFieldControllerPair(
            'Housework', houseworkController, _focusNodes[3]),
        TextFieldControllerPair('Notice', noticeController, _focusNodes[4]),
      ];

  void _focusOnTextFieldContainingResult(BuildContext context) {
    // Nếu không có kết quả hoặc truy vấn tìm kiếm rỗng, không chuyển focus
    if (_searchResult.isEmpty || searchController.text.isEmpty) {
      return;
    }

    for (TextFieldControllerPair pair in _textFieldControllerPairs) {
      if (_containsSubstring(pair.controller.text, searchController.text)) {
        FocusScope.of(context).requestFocus(pair.focusNode);
        break;
      }
    }
  }

  bool _containsSubstring(String text, String query) {
    return RegExp(query, caseSensitive: false).hasMatch(text);
  }
}

void _buildImportantScreen(
    BuildContext context, String title, TextEditingController controller) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ImportantScreen(
        importantController: controller,
      ),
    ),
  );
}

void _buildTodoScreen(
    BuildContext context, String title, TextEditingController controller) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => TodoListScreen(todoListController: controller),
    ),
  );
}

void _buildShoppingListScreen(
    BuildContext context, String title, TextEditingController controller) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>
          ShoppingListScreen(shoppingListController: controller),
    ),
  );
}

void _buildHouseworkScreen(
    BuildContext context, String title, TextEditingController controller) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => HouseworkScreen(houseworkController: controller),
    ),
  );
}

void _buildNoticeScreen(
    BuildContext context, String title, TextEditingController controller) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => NoticeScreen(noticeController: controller),
    ),
  );
}
