import 'package:flutter/material.dart';

class ListItemsScreen extends StatefulWidget {
  final List<String>? items;
  final void Function()? onPress;
  const ListItemsScreen({super.key, this.items, this.onPress});

  @override
  State<ListItemsScreen> createState() => _ListItemsScreenState();
}

class _ListItemsScreenState extends State<ListItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: widget.items?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    leading: const Icon(Icons.list),
                    trailing: Text(
                      index.toString(),
                      style: const TextStyle(color: Colors.green, fontSize: 15),
                    ),
                    title: Text(widget.items?[index] ?? ''));
              }),
        ),
        TextButton(
          onPressed: widget.onPress,
          child: const Text('dene'),
        ),
      ],
    );
  }
}
