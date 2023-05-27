import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ljubljana/app/state/authentication_store/authentication_store.dart';
import 'package:ljubljana/routing/routes.dart';

import '../../../common_widgets/common_button.dart';
import '../../../common_widgets/common_tappable_text.dart';
import '../../../common_widgets/common_text_field.dart';
import '../../../theme/color_helper.dart';
import '../../utils/modal_helper.dart';

class ForgotPasswordCodePage extends StatelessWidget {
  const ForgotPasswordCodePage(this.authStore, {Key? key}) : super(key: key);

  final AuthenticationStore authStore;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/grey_background.png'), fit: BoxFit.cover)),
        child: Scaffold(body: _buildBody(context), bottomNavigationBar: _buildBottomButton(context)));
  }

  Widget _buildBody(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: ListView(
        shrinkWrap: true,
        children: [
          _buildHeadline(context),
        ],
      ),
    );
  }

  Widget _buildHeadline(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Row(children: [IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_ios, size: 40))]),
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
        Text('forgot_pass_code.enter_your'.tr(), style: Theme.of(context).textTheme.bodyText1!.copyWith(color: ColorHelper.darkGrey.color)),
        Text('forgot_pass_code.code'.tr(), style: Theme.of(context).textTheme.caption!.copyWith(color: ColorHelper.darkGrey.color)),
        const SizedBox(height: 5),
        _buildCodeField(context),
        const SizedBox(height: 40),
        Center(child: _buildTappableResend(context)),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildCodeField(BuildContext context) {
    return FOSTextFormField(
      hintText: 'forgot_pass_code.code_field_hint'.tr(),
      onChange: (String? value) {},
      controller: authStore.codeFPController,
    );
  }

  Widget _buildTappableResend(BuildContext context) {
    return FOSTappableText(
      text: 'forgot_pass_code.resend'.tr(),
      links: 'forgot_pass_code.resend_link'.tr(),
      onPressed: (int? index) => authStore.generateResetCode().then((String? error) => ModalHelper().returnErrorModalOrFn(context, error)),
      defaultStyle: Theme.of(context).textTheme.bodyText2!,
      linkStyle: Theme.of(context).textTheme.bodyText2!.copyWith(color: ColorHelper.orange.color, fontWeight: FontWeight.w400),
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      height: 100,
      alignment: Alignment.bottomCenter,
      child: FOSButton(
        onPressed: () => Navigator.of(context).pushNamed(forgotSetPassScreen, arguments: authStore),
        btnType: BtnType.grey,
        buttonTitle: 'forgot_pass_code.btn_continue'.tr(),
      ),
    );
  }
}
