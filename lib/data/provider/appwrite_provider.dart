import 'package:appwrite/appwrite.dart';
import 'package:todoflutterapp/core/utils/appwrite_constants.dart';

class AppWriteProvider {
  Client client = Client();
  Account? account;
  Databases? databases;


  AppWriteProvider(
    
  ){
    client.setEndpoint(AppWriteConstants.endpoint).setProject(AppWriteConstants.projectId).setSelfSigned(status: true);
     account = Account(client);
     databases = Databases(client);
  }
}
