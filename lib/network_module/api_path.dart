enum ApiPath {
  login_user,
  check_email,
  create_password,
  create_user_details,
  delete_token,
  answer_questions,
  user_details,
  reset_code,
  reset_password,
  change_password,
  edit_profile,
  delete_profile,
  get_photo,
  delete_photo,
  upload_photo,
  get_municipalities,
  setDistance,
  getDistances,
  getTopDistances,

}

class ApiPathHelper {
  static String getValue(ApiPath path, {String concatValue = '', String secondConcatValue = '', String thirdConcatValue = ''}) {
    switch (path) {
      case ApiPath.login_user:
        return 'api/account/Login';
      case ApiPath.check_email:
        return 'api/account/CheckEmail?email=$concatValue';
      case ApiPath.create_password:
        return 'api/account/CreatePassword';
      case ApiPath.create_user_details:
        return 'api/account/CreateUserDetail';
      case ApiPath.delete_token:
        return 'api/account/DeleteToken?email=$concatValue';
      case ApiPath.answer_questions:
        return 'api/questions/answer';
      case ApiPath.user_details:
        return 'api/account/GetUserDetails?email=$concatValue';
      case ApiPath.reset_code:
        return 'api/account/GenerateResetCode';
      case ApiPath.reset_password:
        return 'api/account/ResetPassword';
      case ApiPath.change_password:
        return 'api/account/ChangePassword';
      case ApiPath.edit_profile:
        return 'api/account/EditProfile';
      case ApiPath.delete_profile:
        return 'api/account/DeleteAccount?email=$concatValue';
      case ApiPath.get_photo:
        return 'api/account/GetPhoto?email=$concatValue';
      case ApiPath.delete_photo:
        return 'api/account/RemovePhoto?email=$concatValue';
      case ApiPath.upload_photo:
        return 'api/account/UploadPhoto';
      case ApiPath.get_municipalities:
        return 'api/municipality/GetMunicipalities';
      case ApiPath.setDistance:
        return 'api/distances/SetDistance';
      case ApiPath.getDistances:
        return 'api/distances/GetDistances?email=$concatValue';
      case ApiPath.getTopDistances:
        return 'api/distances/GetTopDistances?email=$concatValue';
      default:
        return '';
    }
  }
}
