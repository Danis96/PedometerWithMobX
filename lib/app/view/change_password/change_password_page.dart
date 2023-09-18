import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ljubljana/app/locator.dart';
import 'package:ljubljana/app/state/authentication_store/authentication_store.dart';
import 'package:ljubljana/app/utils/modal_helper.dart';

import '../../../common_widgets/common_button.dart';
import '../../../common_widgets/common_modal.dart';
import '../../../common_widgets/common_text_field.dart';
import '../../../theme/color_helper.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({Key? key}) : super(key: key);

  final AuthenticationStore authStore = locator<AuthenticationStore>();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/grey_background.png'), fit: BoxFit.cover)),
        child: Scaffold(body: _buildBody(context), bottomNavigationBar: _buildBottomButton(context)));
  }

  Widget _buildBody(BuildContext context) {
    return SizedBox(height: double.infinity, child: ListView(shrinkWrap: true, children: [_buildHeadline(context)]));
  }

  Widget _buildHeadlineAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_ios, size: 40)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text('change_pass.change_your'.tr(), style: Theme.of(context).textTheme.bodyText1!.copyWith(color: ColorHelper.darkGrey.color)),
            Text('change_pass.password'.tr(), style: Theme.of(context).textTheme.caption!.copyWith(color: ColorHelper.darkGrey.color)),
          ],
        ),
      ],
    );
  }

  Widget _buildHeadline(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          const SizedBox(height: 50),
          _buildHeadlineAppBar(context),
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
        _buildOldPasswordField(context),
        const SizedBox(height: 10),
        _buildPasswordField(context),
        const SizedBox(height: 10),
        _buildConfirmPasswordField(context),
      ],
    );
  }

  Widget _buildOldPasswordField(BuildContext context) {
    return FOSTextFormField(
      hintText: 'change_pass.old'.tr(),
      controller: authStore.oldPasswordCPController,
      onChange: (String? value) {},
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return FOSTextFormField(
      hintText: 'change_pass.new'.tr(),
      controller: authStore.newPasswordCPController,
      onChange: (String? value) {},
    );
  }

  Widget _buildConfirmPasswordField(BuildContext context) {
    return FOSTextFormField(
      hintText: 'change_pass.confirm'.tr(),
      controller: authStore.confirmPasswordCPController,
      onChange: (String? value) {},
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    void showSuccessModal(BuildContext context) {
      fOSSimpleDialog(context,
          title: 'change_pass.success'.tr(),
          content: 'change_pass.modal_body'.tr(),
          buttonText: 'Ok',
          onButtonPressed: () => Navigator.of(context).pop());
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      height: 100,
      child: FOSButton(
        onPressed: () {
          final String? passCharLengthValidation = authStore.passMinCarValidation(authStore.confirmPasswordCPController.text);
          final String? arePasswordsSame = authStore.passConfirmValidation(authStore.newPasswordCPController, authStore.confirmPasswordCPController);
          if (passCharLengthValidation != null) {
            ModalHelper().returnErrorModalOrFn(context, passCharLengthValidation);
          } else {
            if (arePasswordsSame != null) {
              ModalHelper().returnErrorModalOrFn(context, arePasswordsSame);
            } else {
              authStore
                  .changePassword()
                  .then((String? error) => ModalHelper().returnErrorModalOrFn(context, error, function: () => showSuccessModal(context)));
            }
          }
        },
        btnType: BtnType.grey,
        buttonTitle: 'change_pass.btn_save'.tr(),
      ),
    );
  }
}
