import 'package:flutter/material.dart';
import 'login.dart';
import 'home.dart';
import 'chat.dart';
import 'list.dart';
import 'favorite_list.dart';
import 'dislike_list.dart';
import 'favorite_restaurants.dart';
import 'random.dart';
import 'roulette.dart';
import 'ladder.dart';
import 'ball_pick.dart';
import 'plan.dart';
import 'my_page.dart';
import 'alarm.dart';
import 'register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '오늘 뭐 먹지',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginPage(),
      routes: {
        '/home': (context) => HomePage(),
        '/chat': (context) => ChatPage(),
        '/list': (context) => ListPage(),
        '/favoriteList': (context) => FavoriteListPage(),
        '/dislikeList': (context) => DislikeListPage(),
        '/favoriteRestaurants': (context) => FavoriteRestaurantsPage(),
        '/random': (context) => RandomPage(),
        '/roulette': (context) => RoulettePage(),
        '/ladder': (context) => LadderPage(),
        '/ballPick': (context) => BallPickPage(),
        '/plan': (context) => PlanPage(),
        '/mypage': (context) => MyPage(),
        '/alarm': (context) => AlarmPage(),
        '/register': (context) => RegisterPage(),
      },
    );
  }
}
