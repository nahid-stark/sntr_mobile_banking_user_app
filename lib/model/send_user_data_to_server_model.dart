import 'dart:io';
import 'package:sntr_mobile_banking_user_app/data/account_creation_user_data.dart';

class SendUserDataToServerModel{
  Map<String, dynamic> textualDataModel = <String, dynamic>{
    "accountUserId" : AccountCreationUserData.accountUserId,
    "firstName" : AccountCreationUserData.firstName,
    "lastName" : AccountCreationUserData.lastName,
    "email" : AccountCreationUserData.email,
    "phoneNo" : AccountCreationUserData.phoneNo,
    "nidNo" : AccountCreationUserData.nidNo,
    "postalCode" : AccountCreationUserData.postalCode,
    "address" : AccountCreationUserData.address,
    "gender" : AccountCreationUserData.gender,
    "password" : AccountCreationUserData.password,
    "creationDate" : AccountCreationUserData.creationDate,
    "accountOkay" : false,
  };
  File? profilePicture = AccountCreationUserData.profilePicture;
  File? nidFrontSide = AccountCreationUserData.nidFrontSide;
  File? nidBackSide = AccountCreationUserData.nidBackSide;
}