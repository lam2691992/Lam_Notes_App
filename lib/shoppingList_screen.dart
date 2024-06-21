import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ShoppingListScreen extends StatefulWidget {
  final TextEditingController shoppingListController;

  const ShoppingListScreen({super.key, required this.shoppingListController});
  @override
  // ignore: library_private_types_in_public_api
  _ShoppingListScreenState createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  late final Box<String> hiveBox;
  late final TextEditingController shoppingListController;

  @override
  void initState() {
    super.initState();
    _openHiveBox();
    shoppingListController = TextEditingController();
  }

  Future<void> _openHiveBox() async {
    hiveBox = await Hive.openBox<String>('shoppingList_data');
    shoppingListController.text =
        hiveBox.get('shoppingList', defaultValue: '')!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Shopping List",
          style: TextStyle(
              fontWeight: FontWeight.w700, color: Colors.orangeAccent),
        ),
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
            controller: shoppingListController,
            decoration: InputDecoration(
              labelText: 'Shopping List',
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
              fillColor: Colors.orangeAccent,
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
                            shoppingListController.clear();
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
