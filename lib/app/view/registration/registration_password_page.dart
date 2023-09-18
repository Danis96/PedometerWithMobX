import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ljubljana/app/utils/modal_helper.dart';
import 'package:ljubljana/common_widgets/common_loader.dart';
import 'package:ljubljana/routing/routes.dart';

import '../../../common_widgets/common_button.dart';
import '../../../common_widgets/common_text_field.dart';
import '../../../theme/color_helper.dart';
import '../../state/authentication_store/authentication_store.dart';

class RegistrationPasswordPage extends StatelessWidget {
  const RegistrationPasswordPage(this.auth, {Key? key}) : super(key: key);

  final AuthenticationStore auth;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/grey_background.png'), fit: BoxFit.cover)),
        child: Scaffold(body: _buildBody(context), bottomNavigationBar: _buildBottomButton(context)));
  }

  Widget _buildBody(BuildContext context) =>
      SizedBox(height: double.infinity, child: ListView(shrinkWrap: true, children: [_buildHeadline(context)]));

  Widget _buildHeadline(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Image.asset('assets/ic_reg_pass_headline.png', height: MediaQuery.of(context).size.height / 3),
          const SizedBox(height: 20),
          _buildHeadlineText(context),
        ],
      ),
    );
  }

  Widget _buildHeadlineText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('registration_password.setup_your'.tr(), style: Theme.of(context).textTheme.bodyText1!.copyWith(color: ColorHelper.darkGrey.color)),
        Text('registration_password.password'.tr(), style: Theme.of(context).textTheme.caption!.copyWith(color: ColorHelper.darkGrey.color)),
        const SizedBox(height: 5),
        _buildPasswordField(context),
        const SizedBox(height: 10),
        _buildConfirmPasswordField(context),
      ],
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return FOSTextFormField(
      hintText: 'registration_password.password_field_hint'.tr(),
      type: TextFieldType.passwordType,
      hasTrailingIcon: true,
      onChange: (String? value) {},
      controller: auth.passwordRegistrationController,
      obscureText: true,
    );
  }

  Widget _buildConfirmPasswordField(BuildContext context) {
    return FOSTextFormField(
      hintText: 'registration_password.confirm_password_field_hint'.tr(),
      type: TextFieldType.passwordType,
      hasTrailingIcon: true,
      obscureText: true,
      onChange: (String? value) {},
      controller: auth.confirmPasswordRegistrationController,
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      height: 100,
      child: FOSButton(
        onPressed: () {
          fOSLoaderCircleWhite(context: context);
          final String? passCharLengthValidation = auth.passMinCarValidation(auth.passwordRegistrationController.text);
          final String? arePasswordsSame =
              auth.passConfirmValidation(auth.passwordRegistrationController, auth.confirmPasswordRegistrationController);
          if (passCharLengthValidation != null) {
            Navigator.of(context).pop();
            ModalHelper().returnErrorModalOrFn(context, passCharLengthValidation);
          } else {
            if (arePasswordsSame != null) {
              Navigator.of(context).pop();
              ModalHelper().returnErrorModalOrFn(context, arePasswordsSame);
            } else {
              Navigator.of(context).pop();
              auth.createPassword().then((String? error) {
                ModalHelper().returnErrorModalOrFn(context, error, function: () => Navigator.of(context).pushNamed(loginScreen, arguments: auth));
              });
            }
          }
        },
        btnType: BtnType.grey,
        buttonTitle: 'registration_password.btn_reg_password'.tr(),
      ),
    );
  }
}
