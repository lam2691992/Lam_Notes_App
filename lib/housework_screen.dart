import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HouseworkScreen extends StatefulWidget {
  const HouseworkScreen(
      {super.key, required TextEditingController houseworkController});

  @override
  _HouseworkScreenState createState() => _HouseworkScreenState();
}

class _HouseworkScreenState extends State<HouseworkScreen> {
  TextEditingController houseworkController = TextEditingController();
  late final Box<String> hiveBox;

 @override
void initState() {
  super.initState();
  _openHiveBox(); // Mở hộp dữ liệu trong initState()
  houseworkController = TextEditingController(); // Khởi tạo houseworkController
}
Future<void> _openHiveBox() async {
    hiveBox = await Hive.openBox<String>('housework_data');
    houseworkController.text = hiveBox.get('housework', defaultValue: '')!;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Housework",
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.green),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                TextField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  controller: houseworkController,
                  decoration: InputDecoration(
                    labelText: "Housework",
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
                    fillColor: Colors.green,
                  ),
                  onChanged: (value) {
                    _saveData(value);
                  },
                ),
                
                Container(
                  margin: const EdgeInsets.all(4),
                  height: 30,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey,
                  ),
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.clear),
                      iconSize: 20,
                      onPressed: () {
                        // Hiển thị dialog khi nút "X" được nhấn
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: const Text(
                                  'Are you sure you want to delete?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Đóng dialog
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _saveData(String data) {
    hiveBox.put('housework', data);
  }

  void _clearData() {
    hiveBox.delete('housework');
    houseworkController.clear();
  }
}
