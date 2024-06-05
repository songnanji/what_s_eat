import 'package:flutter/material.dart';
import 'Server.dart';

class DislikeListPage extends StatefulWidget {
  @override
  _DislikeListPageState createState() => _DislikeListPageState();
}

class _DislikeListPageState extends State<DislikeListPage> {
  final TextEditingController _controller = TextEditingController();

  void _addItem(String name) {
    if (name.isNotEmpty) {
      setState(() {
        Server().addDislikedFood(name);
      });
      _controller.clear();
    }
  }

  void _deleteItem(int index) {
    setState(() {
      Server().removeDislikedFood(Server().getDislikedFoods()[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      appBar: AppBar(
        title: Text('싫어하는 음식 리스트'),
        backgroundColor: Colors.lightGreen[400],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: '항목을 입력하세요...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _addItem(_controller.text);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: Server().getDislikedFoods().length,
              itemBuilder: (context, index) {
                final item = Server().getDislikedFoods()[index];
                return ListTile(
                  title: Text(item),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteItem(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
