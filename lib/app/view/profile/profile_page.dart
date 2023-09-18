import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ljubljana/app/locator.dart';
import 'package:ljubljana/app/state/authentication_store/authentication_store.dart';
import 'package:ljubljana/app/state/user_profile_store/user_profile_store.dart';
import 'package:ljubljana/app/utils/modal_helper.dart';
import 'package:ljubljana/common_widgets/common_button.dart';
import '../../../common_widgets/common_loader.dart';
import '../../../common_widgets/common_modal.dart';
import '../../../common_widgets/common_text_field.dart';
import '../../../theme/color_helper.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthenticationStore authStore = locator<AuthenticationStore>();
  final UserProfileStore userProfileStore = locator<UserProfileStore>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fOSLoaderCircleWhite(context: context);
      _getInitialData().then((value) {
        Navigator.of(context).pop();
        setState(() {});
      });
    });
    super.initState();
  }

  Future<void> _getInitialData() async {
    await authStore.getUserData();
    await authStore.getMunicipalities();
    await userProfileStore.getPhoto();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/grey_background.png'), fit: BoxFit.cover)),
        child: Scaffold(body: _buildBody(context), bottomNavigationBar: _buildBottomButton(context)));
  }

  Widget _buildBody(BuildContext context) => SizedBox(
        height: double.infinity,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          shrinkWrap: true,
          children: [
            const SizedBox(height: 50),
            _buildHeadline(context),
            const SizedBox(height: 20),
            _buildImgProfile(context),
            const SizedBox(height: 20),
            _buildForm(context),
          ],
        ),
      );

  Widget _buildHeadline(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_ios, size: 40)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text('profile.edit'.tr(), style: Theme.of(context).textTheme.bodyText1!.copyWith(color: ColorHelper.darkGrey.color)),
            Text('profile.profile'.tr(), style: Theme.of(context).textTheme.caption!.copyWith(color: ColorHelper.darkGrey.color)),
          ],
        ),
      ],
    );
  }

  Widget _buildImgProfile(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          fOSSimpleDialog(
            context,
            title: 'Edit photo',
            content: 'Please add/remove the photo',
            twoButtons: false,
            buttonText: userProfileStore.userPhoto == null && userProfileStore.imageFile == null ? 'Upload photo' : 'Delete photo',
            onButtonPressed: () => userProfileStore.userPhoto == null && userProfileStore.imageFile == null
                ? userProfileStore.uploadImage(context).then((value) => Navigator.of(context).pop())
                : userProfileStore.deletePhoto(context).then((value) => Navigator.of(context).pop()),
          );
        },
        child: userProfileStore.userPhoto == null && userProfileStore.imageFile == null
            ? Image.asset('assets/ic_edit_profile.png', width: MediaQuery.of(context).size.width / 4, height: MediaQuery.of(context).size.height / 7)
            : userProfileStore.imageFile != null
                ? Container(
                    alignment: Alignment.center,
                    child: Container(
                      height: 128,
                      width: 128,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(227, 233, 239, 1),
                        borderRadius: BorderRadius.circular(128.0),
                      ),
                      child: ClipOval(
                        child: Container(
                          height: 128,
                          width: 128,
                          child: Image.file(
                            File(userProfileStore.imageFile!.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  )
                : userProfileStore.userPhoto != null
                    ? Container(
                        alignment: Alignment.center,
                        child: Container(
                          height: 128,
                          width: 128,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(227, 233, 239, 1),
                            borderRadius: BorderRadius.circular(128.0),
                          ),
                          child: ClipOval(
                            child: Container(
                              height: 128,
                              width: 128,
                              child: Image.network(userProfileStore.userPhoto!, fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      )
                    : Image.asset('assets/ic_edit_profile.png',
                        width: MediaQuery.of(context).size.width / 4, height: MediaQuery.of(context).size.height / 7));
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 15),
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

  Widget _buildMunicipalityDropdown(BuildContext context) {
    return FOSTextFormField(
      onChange: (String? input) {
        authStore.profileMunicipalityController.text = input.toString();
      },
      readOnly: true,
      controller: authStore.profileMunicipalityController,
      onTap: () {
        showModalBottomSheet<dynamic>(
            context: context,
            isScrollControlled: true,
            builder: (_) {
              return _buildDropDownContentWidget(context);
            });
      },
      dropdownPressFunction: () {
        showModalBottomSheet<dynamic>(
            context: context,
            isScrollControlled: true,
            builder: (_) {
              return _buildDropDownContentWidget(context);
            });
      },
      hintText:
          authStore.profileMunicipalityController.text.isNotEmpty ? authStore.profileMunicipalityController.text : 'profile.municipality_hint'.tr(),
    );
  }

  Widget _buildDropDownContentWidget(BuildContext context) {
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
                    authStore.filterMunicipalities(input!);
                  },
                  controller: authStore.profileMunicipalityController,
                  hasTrailingIcon: true,
                  icon: IconButton(
                      onPressed: () => Future.delayed(const Duration(milliseconds: 1500), () => FocusManager.instance.primaryFocus?.unfocus()),
                      icon: const Icon(Icons.check)),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: authStore.municipalities.length,
                    itemBuilder: (BuildContext context, int index) {
                      String singleMunicipality = authStore.municipalities[index];
                      return GestureDetector(
                        onTap: () {
                          authStore.profileMunicipalityController.text = singleMunicipality;
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
      decoration:
          InputDecoration(isDense: true, contentPadding: EdgeInsets.zero, border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
      isExpanded: true,
      hint: Text(authStore.isProfileGenderControllerNotEmpty() ? authStore.profileGenderController.text : 'onBoarding.gender_field_hint'.tr(),
          style: TextStyle(color: ColorHelper.darkGrey.color, fontSize: 18, fontWeight: FontWeight.w200)),
      icon: Icon(Icons.arrow_drop_down, color: ColorHelper.black.color),
      style: TextStyle(color: ColorHelper.black.color, fontWeight: FontWeight.w400),
      iconSize: 30,
      buttonHeight: 60,
      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
      dropdownDecoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      items: authStore.genderItems
          .map((item) => DropdownMenuItem<String>(value: item, child: Text(item, style: const TextStyle(fontSize: 14))))
          .toList(),
      onChanged: (String? value) {
        authStore.profileGenderController.text = value.toString();
      },
      onSaved: (String? value) {
        authStore.profileGenderController.text = value.toString();
      },
    );
  }

  Widget _buildNameField(BuildContext context) {
    return FOSTextFormField(
      controller: authStore.profileFNameController,
      hintText: 'onBoarding.name_field_hint'.tr(),
      onChange: (String? value) {},
    );
  }

  Widget _buildLastNameField(BuildContext context) {
    return FOSTextFormField(
      controller: authStore.profileLNameController,
      hintText: 'onBoarding.last_name_field_hint'.tr(),
      onChange: (String? value) {},
    );
  }

  Widget _buildAgeField(BuildContext context) {
    return FOSTextFormField(
      controller: authStore.profileAgeController,
      hintText: 'profile.age_field_hint'.tr(),
      onChange: (String? value) {},
    );
  }

  Widget _buildHeightField(BuildContext context) {
    return FOSTextFormField(
      controller: authStore.profileHeightController,
      hintText: 'profile.height_field_hint'.tr(),
      onChange: (String? value) {},
    );
  }

  Widget _buildWeightField(BuildContext context) {
    return FOSTextFormField(
      controller: authStore.profileWeightController,
      hintText: 'profile.weight_field_hint'.tr(),
      onChange: (String? value) {},
    );
  }

  Widget _buildOtherInfoField(BuildContext context) {
    return FOSTextFormField(
      controller: authStore.profileInfoController,
      type: TextFieldType.textAreaType,
      hintText: 'profile.other_field_hint'.tr(),
      onChange: (String? value) {},
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    void showSuccessModal(BuildContext context) {
      fOSSimpleDialog(context,
          title: 'change_pass.success'.tr(),
          content: 'profile.success_data_changed'.tr(),
          buttonText: 'Ok',
          onButtonPressed: () => Navigator.of(context).pop());
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      alignment: Alignment.bottomCenter,
      height: 100,
      child: FOSButton(
          onPressed: () {
            fOSLoaderCircleWhite(context: context);
            authStore.editUserData().then((String? error) {
              Navigator.of(context).pop();
              ModalHelper().returnErrorModalOrFn(context, error, function: () => showSuccessModal(context));
            });
          },
          buttonTitle: 'profile.btn_save'.tr(),
          btnType: BtnType.grey),
    );
  }
}
