
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/core/services/data_base_service.dart';

class FireStoreService implements DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<void> addData({
    required String collectionPath,
    required Map<String, dynamic> data,
    String? documentid,
  }) async {
    if (documentid != null) {
      await firestore.collection(collectionPath).doc(documentid).set(data);
    } else {
      await firestore.collection(collectionPath).add(data);
    }
  }

  @override
  Future<dynamic> getData({
    required String path,
    String? documentid,
    Map<String, dynamic>? query,
  }) async {
    if (documentid != null) {
      var data = await firestore.collection(path).doc(documentid).get();

      return data.data();
    } else {
      Query<Map<String, dynamic>> data = firestore.collection(path);
      if (query != null) {
        if (query['orderBy'] != null) {
          var orderByField = query['orderBy'];
          var descending = query['descending'];
          data = data.orderBy(orderByField, descending: descending);
        }
        if (query['limit'] != null) {
          var limit = query['limit'];
          data = data.limit(limit);
        }
      }
      var result = await data.get();
      return result.docs.map((e) => e.data()).toList();
    }
  }

  @override
  Future<bool> chechIfDataExists({
    required String path,
    String? documentid,
  }) async {
    if (documentid == null) {
      return false;
    }
    var data = await firestore.collection(path).doc(documentid).get();
    return data.exists;
  }

  @override
  Future<void> updateData({
    required String path,
    required String documentid,
    required Map<String, dynamic> data,
  }) async {
    await firestore.collection(path).doc(documentid).update(data);
  }
}
