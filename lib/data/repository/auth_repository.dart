import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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
}

class AuthRepo implements IAuthRepository {
  final AppWriteProvider _appWriteProvider = locator<AppWriteProvider>();
  final InternetConnectionChecker _internetConnectionChecker =
      locator<InternetConnectionChecker>();

  @override
  Future<Either<Failure, User>> register(
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) async {
    try {
      if ( await _internetConnectionChecker.hasConnection) {
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
      } else {
        return left(Failure('internet not found'));
      }
    } on AppwriteException catch (e) {
      return left(Failure(e.message.toString()));
    } on ServerException catch (e) {
      return left(Failure(e.message.toString()));
    }
  }
}
