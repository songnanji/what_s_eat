import 'package:flutter/material.dart';
import 'Server.dart';

class FavoriteRestaurantsPage extends StatefulWidget {
  @override
  _FavoriteRestaurantsPageState createState() => _FavoriteRestaurantsPageState();
}

class _FavoriteRestaurantsPageState extends State<FavoriteRestaurantsPage> {
  final TextEditingController _controller = TextEditingController();

  void _addItem(String name) {
    if (name.isNotEmpty) {
      setState(() {
        Server().addFavoriteRestaurant(name);
      });
      _controller.clear();
    }
  }

  void _deleteItem(String name) {
    setState(() {
      Server().removeFavoriteRestaurant(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      appBar: AppBar(
        title: Text('단골 음식점 및 맛집 리스트'),
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
              itemCount: Server().getFavoriteRestaurants().length,
              itemBuilder: (context, index) {
                final item = Server().getFavoriteRestaurants()[index];
                return ListTile(
                  title: Text(item),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteItem(item);
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


