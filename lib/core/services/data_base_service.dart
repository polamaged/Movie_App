abstract class DatabaseService {
  Future<void> addData({
    required String collectionPath,
    required Map<String, dynamic> data,
    String? documentid,
  });
  Future<dynamic> getData({
    required String path,
    String? documentid,
    Map<String, dynamic>? query,
  });
  Future<bool> chechIfDataExists({required String path, String? documentid});

  Future<void> updateData({
    required String path,
    required String documentid,
    required Map<String, dynamic> data,
  });
}
