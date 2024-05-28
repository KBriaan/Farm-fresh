import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future adduserDetail(Map<String, dynamic> userInfoMap, String Id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(Id)
        .set(userInfoMap);
  }

  Future addFoodItems(Map<String, dynamic> userInfoMap, String name) async {
    return await FirebaseFirestore.instance.collection(name).add(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> searchFoodItem(String name,) async {
   return FirebaseFirestore.instance.collection(name).snapshots();
  }

  Future addFoodtoCart(Map<String, dynamic> userInfoMap, String Id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(Id)
        .collection('Cart')
        .add(userInfoMap);
  }
   Future<Stream<QuerySnapshot>> getFoodItem(String category, [Map<String, dynamic> options = const {}]) async {
    // ... your logic to fetch items based on category and options
    // If category is 'All', retrieve all items
    if (category == 'All') {
      return FirebaseFirestore.instance.collection('foodItems').snapshots();
    } else {
      // Build query based on category and optional options
      Query query = FirebaseFirestore.instance.collection('foodItems').where('category', isEqualTo: category);
      // Apply additional options if provided
      options.forEach((key, value) {
        query = query.where(key, isEqualTo: value);
      });
      return query.snapshots();
    }
  }

  Future<Stream<QuerySnapshot>> getFoodCart(String id, String searchText) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('Cart')
        .snapshots();
  }

  UpdateUserwallet(String id, String amount) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'Wallet': amount});
  }
  Future updateAdmindetails(Map<String, dynamic> userInfoMap, String Id) async {
    return await FirebaseFirestore.instance
        .collection('Admin')
        .doc(Id)
        .collection('Phone')
        .add(userInfoMap);
  }
}
