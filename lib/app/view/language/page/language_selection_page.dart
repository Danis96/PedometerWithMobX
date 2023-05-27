import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../theme/color_helper.dart';

import '../../../utils/language_helper.dart';
import '../widgets/language_selection_item.dart';

class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({Key? key}) : super(key: key);

  @override
  _LanguageSelectionPageState createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/grey_background.png'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          body: _buildBody(context),
        ));
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
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: <Widget>[
        const SizedBox(height: 30),
        Row(
          children: [
            IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_ios, size: 40)),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('language_selection.change_title'.tr(), style: Theme.of(context).textTheme.caption!.copyWith(color: ColorHelper.blue.color)),
          ],
        ),
        const SizedBox(height: 30),
        LanguageSelectionItem(language: AppLanguages.si),
        LanguageSelectionItem(language: AppLanguages.en),
      ],
    );
  }
}
