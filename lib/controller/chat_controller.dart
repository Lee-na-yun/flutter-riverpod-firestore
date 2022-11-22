// Provider 필요
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_firestore_stream/core/routes_enum.dart';
import 'package:riverpod_firestore_stream/domain/chat/chat_firestore_repository.dart';
import 'package:riverpod_firestore_stream/dto/chat/chat_req_dto.dart';

final chatControllerProvider = Provider((ref) {
  return ChatController(ref);
});

class ChatController {
  Ref _ref;

  ChatController(this._ref);

  void insert(ChatInsertReqDto dto) {
    Future<DocumentReference> futureDoc = _ref.read(chatFirestoreRepositoryProvider).insert(dto);
    //print("디버그: ${futureDoc.snapshots()}");
    //print("디버그: ${futureDoc.id}");

    // if (doc.id.isEmpty) {
    //   // insert 안됐으면! AlertDialog 띄우기
    // } else {
    //   // insert 됐으면 main페이지로 화면이동하기 (비즈니스처리)
    // }

    futureDoc.then(
      (value) {
        print("디버그: ${value.id}");
        // 화면이동
        //Navigator.pushNamed(context, Routes.login.path); // 뒤 화면을 앞화면 위에 띄울 때 사용!
        //Navigator.popAndPushNamed(context, routeName); // 현재화면을 꺼내고 넣음 (=뒤화면이 없음) ex)로그인
        //Navigator.pop(context); // 현재화면을 빠져나옴
        //Navigator.pushNamedAndRemoveUntil(context, Routes.login.path, (route) => false); // 새로운 화면을 띄우면서 밑에 깔린 화면 전체 다 없애기
      },
    ).onError(
      (error, stackTrace) {
        print("error: ${error}");
      },
    );
  }
}
