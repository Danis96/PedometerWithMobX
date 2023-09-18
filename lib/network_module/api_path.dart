enum ApiPath {
  loginUser,
  checkEmail,
  createPassword,
  createUserDetails,
  deleteToken,
  answerQuestions,
  userDetails,
  resetCode,
  resetPassword,
  changePassword,
  editProfile,
  deleteProfile,
  getPhoto,
  deletePhoto,
  uploadPhoto,
  getMunicipalities,
  setDistance,
  getDistances,
  getTopDistances,

}

class ApiPathHelper {
  static String getValue(ApiPath path, {String concatValue = '', String secondConcatValue = '', String thirdConcatValue = ''}) {
    switch (path) {
      case ApiPath.loginUser:
        return 'api/account/Login';
      case ApiPath.checkEmail:
        return 'api/account/CheckEmail?email=$concatValue';
      case ApiPath.createPassword:
        return 'api/account/CreatePassword';
      case ApiPath.createUserDetails:
        return 'api/account/CreateUserDetail';
      case ApiPath.deleteToken:
        return 'api/account/DeleteToken?email=$concatValue';
      case ApiPath.answerQuestions:
        return 'api/questions/answer';
      case ApiPath.userDetails:
        return 'api/account/GetUserDetails?email=$concatValue';
      case ApiPath.resetCode:
        return 'api/account/GenerateResetCode';
      case ApiPath.resetPassword:
        return 'api/account/ResetPassword';
      case ApiPath.changePassword:
        return 'api/account/ChangePassword';
      case ApiPath.editProfile:
        return 'api/account/EditProfile';
      case ApiPath.deleteProfile:
        return 'api/account/DeleteAccount?email=$concatValue';
      case ApiPath.getPhoto:
        return 'api/account/GetPhoto?email=$concatValue';
      case ApiPath.deletePhoto:
        return 'api/account/RemovePhoto?email=$concatValue';
      case ApiPath.uploadPhoto:
        return 'api/account/UploadPhoto';
      case ApiPath.getMunicipalities:
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
