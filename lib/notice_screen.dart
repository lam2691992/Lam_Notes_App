import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NoticeScreen extends StatefulWidget {
  final TextEditingController noticeController;

  const NoticeScreen({super.key, required this.noticeController});
  @override
  _ImportantScreenState createState() => _ImportantScreenState();
}

class _ImportantScreenState extends State<NoticeScreen> {
  late final Box<String> hiveBox;
  late final TextEditingController noticeController;

  @override
  void initState() {
    super.initState();
    _openHiveBox();
    noticeController = TextEditingController();
  }

  Future<void> _openHiveBox() async {
    hiveBox = await Hive.openBox<String>('notice_data');
    noticeController.text = hiveBox.get('notice', defaultValue: '')!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notice",
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.orange),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Stack(alignment: Alignment.bottomRight, children: [
          TextField(
            maxLines: null, // Đặt maxLines cho phép nhiều dòng
            keyboardType: TextInputType
                .multiline, // TextInputType.multiline để hỗ trợ nhiều dòng
            textInputAction: TextInputAction
                .newline, //Enter sẽ xuống dòng thay vì chuyển sang ô kế tiếp
            controller: noticeController,
            decoration: InputDecoration(
              labelText: 'Notice',
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 200),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              fillColor: Colors.orange,
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
                            noticeController.clear();
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
