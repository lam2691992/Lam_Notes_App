import 'package:flutter/material.dart';

mixin ShowDialog<T> on Widget {
  String? get routeName => 'AppDialog';

  Future<T?> show(BuildContext context) {
    return showDialog(
      context: context,
      useRootNavigator: true,
      routeSettings: RouteSettings(name: routeName),
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: this,
          ),
        );
      },
    );
  }
}

class ConfirmDialog extends StatelessWidget with ShowDialog<dynamic> {
  const ConfirmDialog(
      {super.key, required this.title, this.description, this.onConfirm});

  final String title;
  final String? description;

  final VoidCallback? onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: description != null ? Text(description!) : null,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.red, // Màu chữ
            textStyle: const TextStyle(fontWeight: FontWeight.bold), // Kiểu chữ
          ),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onConfirm?.call();
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue, // Màu nền
            foregroundColor: Colors.white, // Màu chữ
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Bo góc
            ),
          ),
          child: const Text('OK'),
        ),
      ],
    );
  }
}

class DeleteConfirmDialog extends ConfirmDialog {
  const DeleteConfirmDialog({super.key, super.onConfirm})
      : super(
          title: "Delete",
          description: "Are you sure you want to delete this item?",
        );
}
