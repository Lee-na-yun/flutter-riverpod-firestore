// Provider 필요
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_firestore_stream/domain/chat/chat.dart';
import 'package:riverpod_firestore_stream/dto/chat/chat_req_dto.dart';

// 리턴 = Stream<List<Chat>>을 하는 것임!
final chatStreamProvider = StreamProvider<List<Chat>>((ref) {
  final db = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> stream = db.collection("chat").snapshots(); //리턴
  return stream.map((snapshot) => snapshot.docs.map((doc) => Chat.fromJson(doc.data())).toList()); //파싱
});

final chatFirestoreRepositoryProvider = Provider((ref) {
  return ChatFirestoreRepository();
});

class ChatFirestoreRepository {
  final db = FirebaseFirestore.instance;

  Future<DocumentReference> insert(ChatInsertReqDto dto) {
    return db.collection("chat").add(dto.toJson());
  }
}
