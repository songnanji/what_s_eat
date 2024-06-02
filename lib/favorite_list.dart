import 'package:flutter/material.dart';

class FavoriteListPage extends StatefulWidget {
  @override
  _FavoriteListPageState createState() => _FavoriteListPageState();
}

class _FavoriteListPageState extends State<FavoriteListPage> {
  final List<String> favoriteList = [];
  final TextEditingController _controller = TextEditingController();

  void _addItem(String name) {
    if (name.isNotEmpty) {
      setState(() {
        favoriteList.add(name);
        favoriteList.sort();
      });
      _controller.clear();
    }
  }

  void _deleteItem(int index) {
    setState(() {
      favoriteList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      appBar: AppBar(
        title: Text('좋아하는 음식 리스트'),
        backgroundColor: Colors.green,
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
              itemCount: favoriteList.length,
              itemBuilder: (context, index) {
                final item = favoriteList[index];
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

