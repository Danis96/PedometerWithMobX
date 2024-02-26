import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ljubljana/app/locator.dart';
import 'package:ljubljana/app/state/onboarding_store/onboarding_store.dart';
import 'package:ljubljana/common_widgets/common_loader.dart';
import 'package:ljubljana/common_widgets/common_text_field.dart';
import 'package:ljubljana/routing/routes.dart';

import '../../../common_widgets/common_button.dart';
import '../../../theme/color_helper.dart';
import '../../state/authentication_store/authentication_store.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage(this.auth, {Key? key}) : super(key: key);

  final AuthenticationStore auth;

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final OnBoardingStore store = locator<OnBoardingStore>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FOSLoaderCircleWhite(context: context);
      _getInitialData().then((value) {
        Navigator.of(context).pop();
      });
    });
    super.initState();
  }

  Future<void> _getInitialData() async {
    await store.getMunicipalities();
  }

  @override
  void dispose() {
    locator.unregister<OnBoardingStore>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/grey_background.png'), fit: BoxFit.cover)),
        child: Scaffold(body: _buildBody(context), bottomNavigationBar: _buildBottomButton(context)));
  }

  Widget _buildBody(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SizedBox(height: double.infinity, child: ListView(shrinkWrap: true, children: [_buildHeadline(context)])),
    );
  }

  Widget _buildHeadline(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: <Widget>[
        const SizedBox(height: 50),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('onBoarding.personal'.tr(),
                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: ColorHelper.darkGrey.color)),
            Text('onBoarding.data'.tr(),
                style: Theme.of(context).textTheme.caption!.copyWith(color: ColorHelper.darkGrey.color)),
          ],
        ),
        const SizedBox(height: 10),
        _buildHeadlineText(context),
        const SizedBox(height: 25),
        _buildForm(context),
      ],
    );
  }

  Widget _buildHeadlineText(BuildContext context) {
    return Text(
      'onBoarding.headline_text'.tr(),
      style:
          Theme.of(context).textTheme.bodyText2!.copyWith(color: ColorHelper.black.color, fontWeight: FontWeight.w200),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          _buildNameField(context),
          const SizedBox(height: 15),
          _buildLastNameField(context),
          const SizedBox(height: 15),
          _buildGenderDropdown(context),
          const SizedBox(height: 15),
          _buildAgeField(context),
          const SizedBox(height: 15),
          _buildHeightField(context),
          const SizedBox(height: 15),
          _buildWeightField(context),
          const SizedBox(height: 15),
          _buildMunicipalityDropdown(context),
          const SizedBox(height: 15),
          _buildOtherInfoField(context),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  void _showModal(BuildContext context, OnBoardingStore store) {
    showModalBottomSheet<dynamic>(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return _buildDropDownContentWidget(context, store);
        });
  }

  Widget _buildMunicipalityDropdown(BuildContext context) {
    return FOSTextFormField(
      onChange: (String? input) {
        store.municipalityController.text = input.toString();
      },
      readOnly: true,
      controller: store.municipalityController,
      onTap: () => _showModal(context, store),
      dropdownPressFunction: () => _showModal(context, store),
      hintText: store.municipalityController.text.isNotEmpty
          ? store.municipalityController.text
          : 'profile.municipality_hint'.tr(),
    );
  }

  Widget _buildDropDownContentWidget(BuildContext context, OnBoardingStore store) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.2,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                FOSTextFormField(
                  onChange: (String? input) {
                    store.filterMunicipalities(input!);
                  },
                  controller: store.municipalityController,
                  hasTrailingIcon: true,
                  icon: IconButton(
                      onPressed: () => Future.delayed(
                          const Duration(milliseconds: 1500), () => FocusManager.instance.primaryFocus?.unfocus()),
                      icon: const Icon(Icons.check)),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: store.municipalities.length,
                    itemBuilder: (BuildContext context, int index) {
                      String singleMunicipality = store.municipalities[index];
                      return GestureDetector(
                        onTap: () {
                          store.municipalityController.text = singleMunicipality;
                          Navigator.of(context).pop();
                        },
                        child: Container(margin: const EdgeInsets.only(top: 15), child: Text(singleMunicipality)),
                      );
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderDropdown(BuildContext context) {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
      isExpanded: true,
      hint: Text('onBoarding.gender_field_hint'.tr(),
          style: TextStyle(color: ColorHelper.darkGrey.color, fontSize: 18, fontWeight: FontWeight.w200)),
      style: TextStyle(color: ColorHelper.black.color, fontWeight: FontWeight.w400),
      items: store.genderItems
          .map((item) => DropdownMenuItem<String>(value: item, child: Text(item, style: const TextStyle(fontSize: 14))))
          .toList(),
      onChanged: (String? value) {
        store.genderController.text = value.toString();
      },
      onSaved: (String? value) {
        store.genderController.text = value.toString();
      },
    );
  }

  Widget _buildAgeField(BuildContext context) {
    return FOSTextFormField(
      controller: store.ageController,
      hintText: 'onBoarding.age_field_hint'.tr(),
      onChange: (String? value) {},
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildNameField(BuildContext context) {
    return FOSTextFormField(
      controller: store.fNameController,
      onChange: (String? value) {},
      hintText: 'onBoarding.name_field_hint'.tr(),
    );
  }

  Widget _buildLastNameField(BuildContext context) {
    return FOSTextFormField(
      controller: store.lNameController,
      onChange: (String? value) {},
      hintText: 'onBoarding.last_name_field_hint'.tr(),
    );
  }

  Widget _buildHeightField(BuildContext context) {
    return FOSTextFormField(
      controller: store.heightController,
      hintText: 'onBoarding.height_field_hint'.tr(),
      onChange: (String? value) {},
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildWeightField(BuildContext context) {
    return FOSTextFormField(
      controller: store.weightController,
      onChange: (String? value) {},
      hintText: 'onBoarding.weight_field_hint'.tr(),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildOtherInfoField(BuildContext context) {
    return FOSTextFormField(
      controller: store.infoController,
      onChange: (String? value) {},
      type: TextFieldType.textAreaType,
      hintText: 'onBoarding.other_field_hint'.tr(),
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      height: 100,
      child: FOSButton(
        onPressed: () => Navigator.of(context).pushNamed(questionScreen, arguments: store),
        btnType: BtnType.grey,
        buttonTitle: 'onBoarding.btn_continue'.tr(),
      ),
    );
  }
}
