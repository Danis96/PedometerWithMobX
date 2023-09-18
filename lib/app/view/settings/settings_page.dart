import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ljubljana/app/locator.dart';
import 'package:ljubljana/app/state/authentication_store/authentication_store.dart';
import 'package:ljubljana/app/state/language_store/language_store.dart';
import 'package:ljubljana/app/utils/modal_helper.dart';
import 'package:ljubljana/common_widgets/common_modal.dart';
import 'package:ljubljana/routing/routes.dart';
import '../../../common_widgets/common_loader.dart';
import '../../../theme/color_helper.dart';
import '../../utils/storage_prefs_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final LanguageStore langStore = locator<LanguageStore>();
  final AuthenticationStore authStore = locator<AuthenticationStore>();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/grey_background.png'), fit: BoxFit.cover)),
        child: Scaffold(body: _buildBody(context), bottomNavigationBar: _buildBottomCurrentDistance(context)));
  }

  Widget _buildBody(BuildContext context) => SizedBox(
        height: double.infinity,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          shrinkWrap: true,
          children: [
            const SizedBox(height: 50),
            _buildHeadline(context),
            const SizedBox(height: 50),
            _profileItem(context, 'settings.edit_profile'.tr(), 'assets/ic_edit_profile.png',
                () => Navigator.of(context).pushNamed(profileScreen).then((value) => setState(() {}))),
            const SizedBox(height: 15),
            _profileItem(
                context, 'settings.change_password'.tr(), 'assets/ic_change_pass.png', () => Navigator.of(context).pushNamed(changePasswordScreen)),
            const SizedBox(height: 15),
            _profileItem(context, 'settings.history_data'.tr(), 'assets/ic_history.png', () => Navigator.of(context).pushNamed(historyScreen)),
            const SizedBox(height: 15),
            _profileItem(context, 'settings.lang'.tr(), 'assets/ic_lang.png', () async {
              String language = await storagePrefs.getLanguage();
              langStore.initializeCurrentLanguage(language);
              Navigator.of(context).pushNamed(languageRoute);
            }),
            const SizedBox(height: 15),
            _profileItem(
              context,
              'settings.logout'.tr(),
              'assets/ic_lang.png',
              () => openLogoutPopup(
                context,
                () {
                  authStore.logout().then(
                        (String? error) => ModalHelper().returnErrorModalOrFn(
                          context,
                          error,
                          function: () => Navigator.of(context).pushNamedAndRemoveUntil(welcomeScreen, (_) => false),
                        ),
                      );
                },
              ),
            ),
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
            Text('settings.application'.tr(),
                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: ColorHelper.darkGrey.color, fontSize: 22)),
            Text('settings.settings'.tr(), style: Theme.of(context).textTheme.caption!.copyWith(color: ColorHelper.darkGrey.color, fontSize: 45)),
          ],
        ),
      ],
    );
  }

  Widget _profileItem(BuildContext context, String title, String icon, Function onItemTap) {
    return GestureDetector(
      onTap: () => onItemTap(),
      child: Container(
        width: double.infinity,
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: ColorHelper.lightGrey.color,
          border: Border.all(color: ColorHelper.darkGrey.color!),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: icon.isNotEmpty ? Image.asset(icon) : const SizedBox(),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 9),
                  child: Text(title, style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 14, fontWeight: FontWeight.w400)),
                )
              ],
            ),
            Image.asset('assets/ic_arrow_right.png', width: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomCurrentDistance(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        alignment: Alignment.bottomCenter,
        height: 100,
        child: GestureDetector(
          onTap: () {
            fOSSimpleDialog(
              context,
              title: 'settings.delete_modal'.tr(),
              content: 'settings.delete_modal_body'.tr(),
              buttonText: 'settings.delete_acc'.tr(),
              onButtonPressed: () {
                fOSLoaderCircleWhite(context: context);
                authStore.deleteProfile().then((String? error) {
                  ModalHelper().returnErrorModalOrFn(context, error,
                      function: () => Navigator.pushNamedAndRemoveUntil(context, welcomeScreen, (route) => false));
                });
              },
              buttonTwoText: 'logout.btn_cancel'.tr(),
              twoButtons: true,
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('settings.delete_acc'.tr(),
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(color: ColorHelper.red.color, fontWeight: FontWeight.w700)),
              const SizedBox(width: 10),
              Image.asset('assets/ic_delete.png', width: 30, height: 30),
            ],
          ),
        ));
  }
}
