import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ljubljana/app/locator.dart';
import 'package:ljubljana/app/state/authentication_store/authentication_store.dart';
import 'package:ljubljana/app/utils/modal_helper.dart';
import 'package:ljubljana/common_widgets/common_loader.dart';
import 'package:ljubljana/common_widgets/common_tappable_text.dart';
import 'package:ljubljana/common_widgets/common_text_field.dart';
import 'package:ljubljana/common_widgets/common_two_buttons.dart';
import 'package:ljubljana/routing/routes.dart';
import 'package:ljubljana/theme/color_helper.dart';

import '../../../common_widgets/common_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage(this.auth, {Key? key}) : super(key: key);

  final AuthenticationStore auth;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    locator.unregister<AuthenticationStore>;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/grey_background.png'), fit: BoxFit.cover)),
        child: Scaffold(body: _buildBody(context), bottomNavigationBar: _buildBottomButton(context)));
  }

  Widget _buildBody(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SizedBox(
        height: double.infinity,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            _buildHeadline(context),
            const SizedBox(height: 10),
            _buildEmailField(context),
            const SizedBox(height: 10),
            _buildPasswordField(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeadline(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Image.asset('assets/ic_login_headline.png', height: MediaQuery.of(context).size.height / 2.3),
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
        Text('login.have_acc'.tr(), style: Theme.of(context).textTheme.bodyText1!.copyWith(color: ColorHelper.blue.color)),
        Text('login.login'.tr(), style: Theme.of(context).textTheme.caption!.copyWith(color: ColorHelper.blue.color)),
        const SizedBox(height: 5),
        FOSTappableText(
          text: 'login.new_user'.tr(),
          links: 'login.new_user_link'.tr(),
          onPressed: (int? index) => Navigator.of(context).pushNamed(registrationScreen),
          defaultStyle: Theme.of(context).textTheme.bodyText2!,
          linkStyle: Theme.of(context).textTheme.bodyText2!.copyWith(color: ColorHelper.orange.color, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: FOSTextFormField(
        hintText: 'login.login_email_field_hint'.tr(),
        controller: widget.auth.emailLoginController,
        fillColor: const Color.fromRGBO(204, 238, 255, 0.2),
        borderColor: const Color.fromRGBO(204, 238, 255, 1),
        textHintColor: ColorHelper.blue.color!,
        onChange: (String? value) {},
      ),
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: FOSTextFormField(
        hintText: 'login.login_pass_field_hint'.tr(),
        controller: widget.auth.passwordLoginController,
        type: TextFieldType.passwordType,
        fillColor: const Color.fromRGBO(204, 238, 255, 0.2),
        borderColor: const Color.fromRGBO(204, 238, 255, 1),
        obscureText: true,
        hasTrailingIcon: true,
        textHintColor: ColorHelper.blue.color!,
        onChange: (String? value) {},
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      alignment: Alignment.bottomCenter,
      height: 100,
      child: FOSTwoButtons(
        rightBtnText: 'login.login_btn_text'.tr(),
        leftBtnText: 'login.forgot_pass_btn_text'.tr(),
        leftBtnTextColor: ColorHelper.orange.color!,
        rightBtnType: BtnType.blue,
        rightBtnFunction: () async {
          FOSLoaderCircleWhite(context: context);
          final String? emailValid = widget.auth.emailValid(widget.auth.emailLoginController.text);
          final String? passCharLengthValidation = widget.auth.passMinCarValidation(widget.auth.passwordLoginController.text);
          if (emailValid != null) {
            ModalHelper().returnErrorModalOrFn(context, emailValid);
          } else {
            if (passCharLengthValidation != null) {
              Navigator.of(context).pop();
              ModalHelper().returnErrorModalOrFn(context, passCharLengthValidation);
            } else {
              widget.auth.loginUser().then((String? error) {
                Navigator.of(context).pop();
                ModalHelper().returnErrorModalOrFn(context, error, function: () async {
                  widget.auth.getUserData().then((String? error) {
                    if (widget.auth.isOnBoardingFinished) {
                      Navigator.of(context).pushNamed(homeScreen);
                    } else {
                      Navigator.of(context).pushNamed(onBoardingScreen, arguments: widget.auth);
                    }
                  });
                });
              });
            }
          }
        },
        leftBtnFunction: () => Navigator.of(context).pushNamed(forgotPassScreen, arguments: widget.auth),
      ),
    );
  }
}
