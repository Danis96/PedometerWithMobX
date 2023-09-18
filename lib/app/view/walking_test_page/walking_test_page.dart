import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:ljubljana/app/state/location_store/location_store.dart';
import '../../../routing/routes.dart';
import '../../../theme/color_helper.dart';
import '../../locator.dart';
import '../../utils/storage_prefs_manager.dart';

class WalkingTestPage extends StatefulWidget {
  const WalkingTestPage({Key? key}) : super(key: key);

  @override
  State<WalkingTestPage> createState() => _WalkingTestPageState();
}

class _WalkingTestPageState extends State<WalkingTestPage> {
  final LocationStore locationStore = locator<LocationStore>();

  Timer? countdownTimer;
  Duration myDuration = const Duration(minutes: 6);
  bool testFinished = false;
  DateTime? _endingTime;
  String langCode = 'si';
  String motivationalText = '';
  String? email;

  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  int get remainingSeconds {
    final DateTime dateTimeNow = DateTime.now();
    Duration remainingTime = _endingTime!.difference(dateTimeNow);
    // Return in seconds
    return remainingTime.inSeconds;
  }

  void setEndingTime() {
    final DateTime dateTimeNow = DateTime.now();
    // Ending time is the current time plus the remaining duration.
    _endingTime = dateTimeNow;
  }

  Future<void> startTimer() async {
    await locationStore.checkPermission().then((value) {
      countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
    });
  }

  void stopTimer() {
    myDuration = const Duration(minutes: 6);
    setState(() {
      testFinished = false;
      if (countdownTimer != null) {
        countdownTimer!.cancel();
      }
      locationStore.stopTracking();
    });
  }

  void resetTimer() {
    stopTimer();
    setState(() => myDuration = const Duration(minutes: 6));
  }

  void setCountDown() {
    const int reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        // countdownTimer!.cancel();
        // testFinished = true;
      } else {
        myDuration = Duration(seconds: seconds);
        String strDigits(int n) => n.toString().padLeft(2, '0');
        String minutes = strDigits(myDuration.inMinutes.remainder(60));
        String sec = strDigits(myDuration.inSeconds.remainder(60));
        playAudio(minutes, sec);
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        final seconds = myDuration.inSeconds - remainingSeconds;
        myDuration = Duration(seconds: seconds);
      });
    } else if (state == AppLifecycleState.inactive) {
      print('App inactive');
    } else if (state == AppLifecycleState.paused) {
      print('App paused/background');
      setEndingTime();
    } else if (state == AppLifecycleState.detached) {}
  }

  @override
  void dispose() {
    locator.unregister<LocationStore>();
    super.dispose();
  }

  @override
  void initState() {
    _setLanguageAndGetEmail();
    super.initState();
  }


  Future<void> _setLanguageAndGetEmail() async {
    email = await storagePrefs.readEmailFromShared();
    langCode = await storagePrefs.getLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/grey_background.png'), fit: BoxFit.cover)),
        child: Scaffold(body: _buildBody(context), bottomNavigationBar: _buildBottomCurrentDistance(context)));
  }

  Widget _buildBody(BuildContext context) =>
      SizedBox(height: double.infinity, child: ListView(shrinkWrap: true, children: [_buildHeadline(context)]));

  Widget _buildStartButton(BuildContext context) {
    return GestureDetector(
      onTap: startTimer,
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(color: ColorHelper.blue.color, shape: BoxShape.circle),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: ColorHelper.white.color!.withOpacity(0.35), shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
          child: Center(
            child: Text(
              'Start'.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.w500, fontSize: 20, color: ColorHelper.white.color),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeadline(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  if (countdownTimer != null) {
                    stopTimer();
                  }
                  testFinished = true;
                  Navigator.of(context).pushNamed(homeScreen);
                },
                icon: const Icon(Icons.clear, size: 40)),
          ],
        ),
        const SizedBox(height: 50),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('agreement_test.do_your_thing'.tr(), style: Theme.of(context).textTheme.bodyText1!.copyWith(color: ColorHelper.black.color)),
            Text('agreement_test.walk'.tr(), style: Theme.of(context).textTheme.caption!.copyWith(color: ColorHelper.black.color)),
          ],
        ),
        const SizedBox(height: 60),
        if (countdownTimer == null || !countdownTimer!.isActive) _buildStartButton(context) else const SizedBox(),
        const SizedBox(height: 60),
        _buildTimerView(context),
        const SizedBox(height: 60),
        _buildMotivationMessage(context),
        const SizedBox(
          height: 20,
        ),
        Text(locationStore.accuracyList.isNotEmpty ? locationStore.accuracyList.last.horizontalConvert : ''),
        const SizedBox(
          height: 20,
        ),
        Text(locationStore.accuracyList.isNotEmpty ? locationStore.accuracyList.last.distance.toStringAsFixed(2) : ''),
      ],
    );
  }

  void playAudio(String minutes, String seconds) {
    if (minutes == '05' && seconds == '00') {
      audioPlayer.open(
        Audio(langCode == 'si' ? 'assets/5min_slo.mp3' : "assets/5min_en.m4a"),
      );
    }
    if (minutes == '04' && seconds == '00') {
      audioPlayer.open(
        Audio(langCode == 'si' ? 'assets/4min_slo.mp3' : "assets/4min_en.m4a"),
      );
    }
    if (minutes == '03' && seconds == '00') {
      audioPlayer.open(
        Audio(langCode == 'si' ? 'assets/3min_slo.mp3' : "assets/3min_en.m4a"),
      );
    }
    if (minutes == '02' && seconds == '00') {
      audioPlayer.open(
        Audio(langCode == 'si' ? 'assets/2min_slo.mp3' : "assets/2min_en.m4a"),
      );
    }
    if (minutes == '01' && seconds == '00') {
      audioPlayer.open(
        Audio(langCode == 'si' ? 'assets/1min_slo.mp3' : "assets/1min_en.m4a"),
      );
    }
    if (minutes == '00' && seconds == '15') {
      audioPlayer.open(
        Audio(langCode == 'si' ? 'assets/15sec_slo.mp3' : "assets/15sec_en.m4a"),
      );
    }
    if (minutes == '00' && seconds == '00') {
      audioPlayer.open(
        Audio(langCode == 'si' ? 'assets/stop_slo.mp3' : "assets/stop_en.m4a"),
      );
    }
  }

  Widget _buildTimerView(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = strDigits(myDuration.inMinutes.remainder(60));
    String seconds = strDigits(myDuration.inSeconds.remainder(60));
    if (minutes == '00' && seconds == '00') {
      print('STOP');
      countdownTimer!.cancel();
      testFinished = true;
      locationStore.stopTracking();
      locationStore.setUsersDistance(email!, locationStore.distanceTraveled.toInt());
    }
    //playAudio(minutes, seconds);
    return Center(
        child: Text(testFinished ? 'Finish' : '$minutes:$seconds',
            style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 72, color: ColorHelper.red.color)));
  }

  Widget _buildMotivationMessage(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = strDigits(myDuration.inMinutes.remainder(60));
    String seconds = strDigits(myDuration.inSeconds.remainder(60));

    return Center(
        child: Text(
      getMotivationText(minutes, seconds),
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),
    ).tr());
  }

  String getMotivationText(String minutes, String seconds) {
    if (minutes == '06') {
      motivationalText = '';
    } else if (minutes == '05' && seconds == '00') {
      motivationalText = 'motivation.5min';
    } else if (minutes == '04' && seconds == '00') {
      motivationalText = 'motivation.4min';
    } else if (minutes == '03' && seconds == '00') {
      motivationalText = 'motivation.3min';
    } else if (minutes == '02' && seconds == '00') {
      motivationalText = 'motivation.2min';
    } else if (minutes == '01' && seconds == '00') {
      motivationalText = 'motivation.1min';
    } else if (minutes == '00' && seconds == '15') {
      motivationalText = 'motivation.15sec';
    } else if (minutes == '00' && seconds == '00') {
      motivationalText = 'motivation.stop';
    }
    return motivationalText;
  }

  Widget _buildBottomCurrentDistance(BuildContext ctx) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        alignment: Alignment.bottomCenter,
        height: MediaQuery.of(context).size.height / 4,
        child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: 'agreement_test.current_distance'.tr(),
                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: ColorHelper.black.color, fontWeight: FontWeight.w300),
                children: <TextSpan>[
                  TextSpan(
                      text: '${locationStore.distanceTraveled.toStringAsFixed(2)} m',
                      style: Theme.of(context).textTheme.caption!.copyWith(color: ColorHelper.black.color))
                ])));
  }
}
