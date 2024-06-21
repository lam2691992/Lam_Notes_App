import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ImportantScreen extends StatefulWidget {
  const ImportantScreen(
      {super.key, required TextEditingController importantController});

  @override
  _ImportantScreenState createState() => _ImportantScreenState();
}

class _ImportantScreenState extends State<ImportantScreen> {
  late final Box<String> hiveBox;
  late final TextEditingController importantController;

  @override
  void initState() {
    super.initState();
    _openHiveBox();
    importantController = TextEditingController();
  }

  Future<void> _openHiveBox() async {
    hiveBox = await Hive.openBox<String>('important_data');
    importantController.text = hiveBox.get('important', defaultValue: '')!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Important",
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.blue),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            TextField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              controller: importantController,
              decoration: InputDecoration(
                labelText: "Important",
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
                fillColor: Colors.blue[100],
              ),
              onChanged: (value) {
                _saveData(value);
              },
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
                              _clearData();
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
          ],
        ),
      ),
    );
  }

  void _saveData(String data) {
    hiveBox.put('important', data);
  }

  void _clearData() {
    hiveBox.delete('important');
    importantController.clear();
  }
}
