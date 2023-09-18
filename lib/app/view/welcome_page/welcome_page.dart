import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ljubljana/common_widgets/common_button.dart';

import '../../../routing/routes.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('danis_test'),
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/orange_background.png'), fit: BoxFit.cover)),
        child: Scaffold(body: _buildBody(context), bottomNavigationBar: _buildBottomButton(context)));
  }
}

Widget _buildBody(BuildContext context) {
  return _buildHeadlineImgAndText(context);
}

Widget _buildHeadlineImgAndText(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: MediaQuery.of(context).size.height / 10),
        Container(alignment: Alignment.center, child: Image.asset('assets/ic_welcome_shoe.png')),
        const SizedBox(height: 27),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('welcome.lets'.tr(), style: Theme.of(context).textTheme.bodyText1),
            Text('welcome.walk'.tr(), style: Theme.of(context).textTheme.caption)
          ],
        ),
      ],
    ),
  );
}

Widget _buildBottomButton(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 40),
    height: 140,
    alignment: Alignment.bottomCenter,
    child: FOSButton(
        widgetKey: const Key('welcome_page_button'),
        onPressed: () => Navigator.of(context).pushNamed(registrationScreen),
        buttonTitle: 'welcome.start'.tr()),
  );
}
