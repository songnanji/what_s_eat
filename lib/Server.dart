import 'User.dart';

class User {
  final String id;
  final String password;
  final String name;
  List<String> favoriteFoods = [];
  List<String> dislikedFoods = [];
  List<String> favoriteRestaurants = [];
  Map<DateTime, List<String>> dietPlans = {};

  User({
    required this.id,
    required this.password,
    required this.name,
  });
}

class Server {
  static final Server _instance = Server._internal();

  factory Server() {
    return _instance;
  }

  Server._internal();

  List<User> users = [];
  User? currentUser;

  void register(String id, String password, String name) {
    User user = User(
      id: id,
      password: password,
      name: name,
    );
    users.add(user);
  }

  bool login(String id, String password) {
    for (User user in users) {
      if (user.id == id && user.password == password) {
        currentUser = user;
        return true;
      }
    }
    return false;
  }

  String getCurrentUserName() {
    return currentUser?.name ?? 'Guest';
  }

  List<String> getFavoriteFoods() {
    return currentUser?.favoriteFoods ?? [];
  }

  List<String> getDislikedFoods() {
    return currentUser?.dislikedFoods ?? [];
  }

  List<String> getFavoriteRestaurants() {
    return currentUser?.favoriteRestaurants ?? [];
  }

  List<String> getDietPlans(DateTime date) {
    return currentUser?.dietPlans[date] ?? [];
  }

  void addFavoriteFood(String food) {
    currentUser?.favoriteFoods.add(food);
  }

  void removeFavoriteFood(String food) {
    currentUser?.favoriteFoods.remove(food);
  }

  void addDislikedFood(String food) {
    currentUser?.dislikedFoods.add(food);
  }

  void removeDislikedFood(String food) {
    currentUser?.dislikedFoods.remove(food);
  }

  void addFavoriteRestaurant(String restaurant) {
    currentUser?.favoriteRestaurants.add(restaurant);
  }

  void removeFavoriteRestaurant(String restaurant) {
    currentUser?.favoriteRestaurants.remove(restaurant);
  }

  void addDietPlan(DateTime date, String plan) {
    if (currentUser?.dietPlans[date] == null) {
      currentUser?.dietPlans[date] = [];
    }
    currentUser?.dietPlans[date]!.add(plan);
  }

  void removeDietPlan(DateTime date, String plan) {
    currentUser?.dietPlans[date]?.remove(plan);
    if (currentUser?.dietPlans[date]?.isEmpty ?? true) {
      currentUser?.dietPlans.remove(date);
    }
  }

  List<String> getAvailableFoods() {
    List<String> allFoods = [
      '피자', '햄버거', '초밥', '미역국', '샐러드', '샌드위치', '비빔밥', '낙지볶음', '파전', '만두', '갈비',
    ];
    List<String> dislikedFoods = getDislikedFoods();
    return allFoods.where((food) => !dislikedFoods.contains(food)).toList();
  }
}
