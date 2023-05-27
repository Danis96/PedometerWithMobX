import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'dart:io';

import '../../../common_widgets/common_loader.dart';
import '../../models/distance_model.dart';
import '../../repositories/distance_repo.dart';
import '../../repositories/user_profile_repository.dart';
import '../../utils/storage_prefs_manager.dart';
import 'package:image/image.dart' as img;

part 'user_profile_store.g.dart';

class UserProfileStore = UserProfileBase with _$UserProfileStore;

abstract class UserProfileBase with Store {
  UserProfileBase() {
    _profileRepository = UserProfileRepository();
    _distanceRepository = DistanceRepository();
  }

  DistanceRepository? _distanceRepository;
  UserProfileRepository? _profileRepository;

  @observable
  File? imageFile;
  final ImagePicker picker = ImagePicker();

  @observable
  String? userPhoto;

  @observable
  List<DistanceModel> distances = <DistanceModel>[];
  @observable
  List<DistanceModel> topDistances = <DistanceModel>[];

  @action
  Future<String?> getUserData() async {
    try {
      final String email = await storagePrefs.readEmailFromShared();
      await _profileRepository!.getUserDetails(email);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  @action
  Future<String?> uploadImage(BuildContext context) async {
    final PickedFile? pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 20,
    );
    final img.Image? capturedImage = img.decodeImage(await File(pickedFile!.path).readAsBytes());
    final img.Image orientedImage = img.bakeOrientation(capturedImage!);
    imageFile = await File(pickedFile.path).writeAsBytes(img.encodeJpg(orientedImage));
    FOSLoaderCircleWhite(context: context);
    try {
      final String email = await storagePrefs.readEmailFromShared();
      if (imageFile != null) {
        await _profileRepository!.uploadPhoto(imageFile!, email);
      }
      Navigator.of(context).pop();
      return null;
    } catch (e) {
      Navigator.of(context).pop();
      return e.toString();
    }
  }

  @action
  Future<String?> getPhoto() async {
    try {
      final String email = await storagePrefs.readEmailFromShared();
      userPhoto = await _profileRepository!.getPhoto(email);
      return null;
    } catch (e) {
      userPhoto = null;
      return e.toString();
    }
  }

  @action
  Future<String?> deletePhoto(BuildContext context) async {
    try {
      FOSLoaderCircleWhite(context: context);
      final String email = await storagePrefs.readEmailFromShared();
      await _profileRepository!.deletePhoto(email);
      userPhoto = null;
      imageFile = null;
      Navigator.of(context).pop();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  @action
  Future<String?> getDistances(String email) async {
    try {
      distances = await _distanceRepository!.getUserDistances(email);
      return null;
    } catch(e) {
      return e.toString();
    }
  }

  @action
  Future<String?> getTopDistances(String email) async {
    try {
      topDistances = await _distanceRepository!.getUserTopDistances(email);
      return null;
    } catch(e) {
      return e.toString();
    }
  }

}
