import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TodoListScreen extends StatefulWidget {
  final TextEditingController todoListController;

  const TodoListScreen({super.key, required this.todoListController});
  @override
  // ignore: library_private_types_in_public_api
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  late final Box<String> hiveBox;
  late final TextEditingController todoListController;

  @override
  void initState() {
    super.initState();
    _openHiveBox();
    todoListController = TextEditingController();
  }

  Future<void> _openHiveBox() async {
    hiveBox = await Hive.openBox<String>('todoList_data');
    todoListController.text = hiveBox.get('todoList', defaultValue: '')!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-do List",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 248, 187, 242))),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(alignment: Alignment.bottomRight, children: [
          TextField(
            maxLines: null, // Đặt maxLines cho phép nhiều dòng
            keyboardType: TextInputType
                .multiline, // TextInputType.multiline để hỗ trợ nhiều dòng
            textInputAction: TextInputAction
                .newline, //Enter sẽ xuống dòng thay vì chuyển sang ô kế tiếp
            controller: todoListController,
            decoration: InputDecoration(
              labelText: 'To-do List',
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: const EdgeInsets.symmetric(vertical: 200),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              fillColor: const Color.fromARGB(255, 248, 187, 242),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
            child: IconButton(
              icon: const Icon(Icons.clear),
              iconSize: 20,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Text('Are you sure you want to delete?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            todoListController.clear();
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
