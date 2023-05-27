import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ljubljana/app/utils/modal_helper.dart';
import 'package:ljubljana/common_widgets/common_loader.dart';
import 'package:ljubljana/common_widgets/common_tappable_text.dart';
import 'package:ljubljana/common_widgets/common_text_field.dart';
import 'package:ljubljana/routing/routes.dart';
import 'package:ljubljana/theme/color_helper.dart';

import '../../../common_widgets/common_button.dart';
import '../../locator.dart';
import '../../state/authentication_store/authentication_store.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({Key? key}) : super(key: key);

  final AuthenticationStore auth = locator<AuthenticationStore>();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/grey_background.png'), fit: BoxFit.cover)),
        child: Scaffold(body: _buildBody(context), bottomNavigationBar: _buildBottomButton(context)));
  }

  Widget _buildBody(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SizedBox(height: double.infinity, child: ListView(shrinkWrap: true, children: <Widget>[_buildHeadline(context)])),
    );
  }

  Widget _buildHeadline(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Image.asset('assets/ic_registration_headline.png', height: MediaQuery.of(context).size.height / 3),
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
        Text('registration.new_user'.tr(), style: Theme.of(context).textTheme.bodyText1!.copyWith(color: ColorHelper.darkGrey.color)),
        Text('registration.register'.tr(), style: Theme.of(context).textTheme.caption!.copyWith(color: ColorHelper.darkGrey.color)),
        const SizedBox(height: 5),
        FOSTappableText(
          text: 'registration.have_account'.tr(),
          links: 'registration.have_account_link'.tr(),
          onPressed: (int? index) => Navigator.of(context).pushNamed(loginScreen, arguments: auth),
          defaultStyle: Theme.of(context).textTheme.bodyText2!,
          linkStyle: Theme.of(context).textTheme.bodyText2!.copyWith(color: ColorHelper.orange.color, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 10),
        _buildEmailField(context),
        const SizedBox(height: 10),
        _buildTermsCheckboxAndTappable(context),
      ],
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return FOSTextFormField(
      hintText: 'registration.reg_email_field_hint'.tr(),
      onChange: (String? value) {},
      controller: auth.emailRegistrationController,
    );
  }

  Widget _buildTermsCheckboxAndTappable(BuildContext context) {
    return Row(
      children: <Widget>[
        Observer(builder: (_) {
          return Checkbox(value: auth.agreeTerms, activeColor: ColorHelper.orange.color, onChanged: (bool? value) => auth.setAgreeTerms(value!));
        }),
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: FOSTappableText(
              onPressed: (int? index) => {},
              text: 'registration.reg_terms'.tr(),
              links: 'registration.reg_terms_link'.tr(),
              defaultStyle: Theme.of(context).textTheme.bodyText2!,
              linkStyle: Theme.of(context).textTheme.bodyText2!.copyWith(color: ColorHelper.orange.color, fontWeight: FontWeight.w400, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      height: 100,
      child: FOSButton(
        onPressed: () {
          if (auth.agreeTerms) {
            FOSLoaderCircleWhite(context: context);
            auth.checkEmailExists().then((String? error) {
              Navigator.of(context).pop();
              final String? emailValid = auth.emailValid(auth.emailRegistrationController.text);
              if (emailValid != null) {
                ModalHelper().returnErrorModalOrFn(context, emailValid);
              } else {
                auth.setEmailInShared(auth.emailRegistrationController.text);
                ModalHelper().returnErrorModalOrFn(
                  context,
                  error,
                  function: () => Navigator.of(context).pushNamed(registrationPasswordScreen, arguments: auth),
                );
              }
            });
          }
        },
        btnType: BtnType.grey,
        buttonTitle: 'registration.btn_register'.tr(),
      ),
    );
  }
}
