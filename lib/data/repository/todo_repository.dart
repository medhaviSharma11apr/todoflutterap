import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';
import 'package:todoflutterapp/core/error/failure.dart';
import 'package:todoflutterapp/core/error/server_exception.dart';
import 'package:todoflutterapp/core/utils/appwrite_constants.dart';
import 'package:todoflutterapp/data/model/todo_model.dart';
import 'package:todoflutterapp/data/provider/appwrite_provider.dart';

import '../../core/locator/locator.dart';

abstract class ITodoRepository {
  Future<Either<Failure, Document>> addTodos({
    required String userId,
    required String title,
    required String description,
    required bool isCompleted,
  });
  Future<Either<Failure, List<TodoModel>>> getTodo({
    required String userId,
  });
  Future<Either<Failure, Document>> editTodos({
    required String documentId,
    required String title,
    required String description,
    required bool isCompleted,
  });

  Future<Either<Failure, dynamic>> deleteTodo({
    required String documentId,
  });
}

class TodoRepository implements ITodoRepository {
  final AppWriteProvider _appWriteProvider = locator<AppWriteProvider>();

  @override
  Future<Either<Failure, Document>> addTodos({
    required String userId,
    required String title,
    required String description,
    required bool isCompleted,
  }) async {
    try {
      // String documentId = ID.unique();
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
      return right(document);
    } on AppwriteException catch (e) {
      return left(Failure(e.message ?? e.toString()));
    } on ServerException catch (e) {
      return left(Failure(e.message ?? e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TodoModel>>> getTodo(
      {required String userId}) async {
    try {
      DocumentList list = await _appWriteProvider.databases!.listDocuments(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.todoCollectionId,
        queries: [Query.equal('userId', userId)],
      );
      Map<String, dynamic> data = list.toMap();
      List listdata = data['documents'].toList();

      List<TodoModel> todoList =
          listdata.map((e) => TodoModel.fromMap(e['data'])).toList();
      return right(todoList);
    } on AppwriteException catch (e) {
      return left(Failure(e.message ?? e.toString()));
    } on ServerException catch (e) {
      return left(Failure(e.message ?? e.toString()));
    }
  }

  @override
  Future<Either<Failure, Document>> editTodos(
      {required String documentId,
      required String title,
      required String description,
      required bool isCompleted}) async {
    try {
      Document document = await _appWriteProvider.databases!.updateDocument(
          databaseId: AppWriteConstants.databaseId,
          collectionId: AppWriteConstants.todoCollectionId,
          documentId: documentId,
          data: {
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

  @override
  Future<Either<Failure, dynamic>> deleteTodo(
      {required String documentId}) async {
    log("Repooid$documentId");
    try {
      var documentD = await _appWriteProvider.databases!.deleteDocument(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.todoCollectionId,
        documentId: documentId,
      );
      return right(documentD);
    } on AppwriteException catch (e) {
      return left(Failure(e.message ?? e.toString()));
    } on ServerException catch (e) {
      return left(Failure(e.message ?? e.toString()));
    }
  }
}
