import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';
import 'package:todoflutterapp/core/error/failure.dart';
import 'package:todoflutterapp/core/error/server_exception.dart';
import 'package:todoflutterapp/core/locator/locator.dart';
import 'package:todoflutterapp/core/utils/appwrite_constants.dart';
import 'package:todoflutterapp/data/provider/appwrite_provider.dart';

abstract class IAuthRepository {
  Future<Either<Failure, User>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });

  Future<Either<Failure, Session>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, Session>> checkSession();
}

class AuthRepo implements IAuthRepository {
  final AppWriteProvider _appWriteProvider = locator<AppWriteProvider>();
  // final InternetConnectionChecker _internetConnectionChecker =
  //     locator<InternetConnectionChecker>();

  @override
  Future<Either<Failure, User>> register(
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) async {
    try {
      // if ( await _internetConnectionChecker.hasConnection) {
      User user = await _appWriteProvider.account!.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: "$firstName $lastName",
      );

      await _appWriteProvider.databases!.createDocument(
          databaseId: AppWriteConstants.databaseId,
          collectionId: AppWriteConstants.userCollectionId,
          documentId: user.$id,
          data: {
            "id": user.$id,
            "first_name": firstName,
            "last_name": lastName,
            "full_name": "$firstName $lastName",
            "email": email,
          });

      return right(user);
      // } else {
      //   return left(Failure('internet not found'));
      // }
    } on AppwriteException catch (e) {
      return left(Failure(e.message.toString()));
    } on ServerException catch (e) {
      return left(Failure(e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, Session>> login(
      {required String email, required String password}) async {
    try {
      // if ( await _internetConnectionChecker.hasConnection) {
      Session session = await _appWriteProvider.account!.createEmailSession(
        email: email,
        password: password,
      );
      User user = await _appWriteProvider.account!.get();
      return right(session);
      // } else {
      //   return left(Failure('internet not found'));
      // }
    } on AppwriteException catch (e) {
      return left(Failure(e.message.toString()));
    } on ServerException catch (e) {
      return left(Failure(e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, Session>> checkSession() async {
    try {
      Session session =
          await _appWriteProvider.account!.getSession(sessionId: "current");
      return right(session);
    } on AppwriteException catch (e) {
      return left(Failure(e.message.toString()));
    } on ServerException catch (e) {
      return left(Failure(e.message.toString()));
    }
  }
}
