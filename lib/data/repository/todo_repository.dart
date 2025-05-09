import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';
import 'package:todoflutterapp/core/error/failure.dart';
import 'package:todoflutterapp/core/error/server_exception.dart';
import 'package:todoflutterapp/core/utils/appwrite_constants.dart';
import 'package:todoflutterapp/data/provider/appwrite_provider.dart';

import '../../core/locator/locator.dart';

abstract class ITodoRepository {
  Future<Either<Failure, Document>> addTodos({
    required String userId,
    required String title,
    required String description,
    required bool isCompleted,
  });
  // Future<int> insertTodo(Map<String, dynamic> todo);
  // Future<int> updateTodo(Map<String, dynamic> todo);
  // Future<int> deleteTodo(int id);
}

class TodoRepository implements ITodoRepository {
  final AppWriteProvider _appWriteProvider = locator<AppWriteProvider>();

  @override
  Future<Either<Failure, Document>> addTodos(
      {required String userId,
      required String title,
      required String description,
      required bool isCompleted}) async {
    try {
      String documentId = ID.unique();
      Document document = await _appWriteProvider.databases!.createDocument(
          databaseId: AppWriteConstants.databaseId,
          collectionId: AppWriteConstants.todoCollectionId,
          documentId: documentId,
          data: {
            "userId": userId,
            "title": title,
            "description": description,
            "isCompleted": isCompleted,
            "id": documentId,
          });
      log('doc${document.data.toString()}');
      return right(document);
    } on AppwriteException catch (e) {
      return left(Failure(e.message ?? e.toString()));
    } on ServerException catch (e) {
      return left(Failure(e.message ?? e.toString()));
    }
  }
}
