import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ljubljana/app/state/authentication_store/authentication_store.dart';
import 'package:ljubljana/app/utils/modal_helper.dart';
import 'package:ljubljana/routing/routes.dart';

import '../../../common_widgets/common_button.dart';
import '../../../common_widgets/common_text_field.dart';
import '../../../theme/color_helper.dart';
import '../../locator.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage(this.store, {Key? key}) : super(key: key);

  final AuthenticationStore store;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/grey_background.png'), fit: BoxFit.cover)),
      child: Scaffold(body: _buildBody(context), bottomNavigationBar: _buildBottomButton(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SizedBox(height: double.infinity, child: ListView(shrinkWrap: true, children: [_buildHeadline(context)]));
  }

  Widget _buildHeadline(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Row(
            children: [
              IconButton(
                  onPressed: () => Navigator.of(context).pushNamed(loginScreen, arguments: locator<AuthenticationStore>()),
                  icon: const Icon(Icons.arrow_back_ios, size: 40)),
            ],
          ),
          Image.asset('assets/ic_forgot_headline.png', height: MediaQuery.of(context).size.height / 2.3),
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
        Text('forgot_pass_email.cant_remember'.tr(), style: Theme.of(context).textTheme.bodyText1!.copyWith(color: ColorHelper.darkGrey.color)),
        Text('forgot_pass_email.password'.tr(), style: Theme.of(context).textTheme.caption!.copyWith(color: ColorHelper.darkGrey.color)),
        const SizedBox(height: 5),
        _buildEmailField(context),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return FOSTextFormField(controller: store.emailFPController, onChange: (String? value) {}, hintText: 'forgot_pass_email.email_field_hint'.tr());
  }

  Widget _buildBottomButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      height: 100,
      child: FOSButton(
        onPressed: () {
          final String? emailValid = store.emailValid(store.emailFPController.text);
          if (emailValid != null) {
            ModalHelper().returnErrorModalOrFn(context, emailValid);
          } else {
            store.generateResetCode().then((String? error) => ModalHelper()
                .returnErrorModalOrFn(context, error, function: () => Navigator.of(context).pushNamed(forgotPassCodeScreen, arguments: store)));
          }
        },
        btnType: BtnType.grey,
        buttonTitle: 'forgot_pass_email.btn_text'.tr(),
      ),
    );
  }
}
