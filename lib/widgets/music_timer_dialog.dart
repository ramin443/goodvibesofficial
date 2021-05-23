import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goodvibesoffl/services/player_service.dart';
import 'package:goodvibesoffl/utils/common_functiona.dart';
import 'package:goodvibesoffl/utils/common_player_function.dart';
//import 'package:goodvibesofficial/utils/theme/good_vibes_icons_icons.dart';
import 'package:goodvibesoffl/utils/theme/style.dart';
import 'package:goodvibesoffl/utils/strings/string_constants.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import '../locator.dart';

class DialogWrapper extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  DialogWrapper({this.child, this.padding});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xff3C26B3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          gradient: LinearGradient(
            colors: [
              Color(0xff3C27B4).withAlpha(255),
              Color(0xff6A18A5).withAlpha(255),
            ],
            tileMode: TileMode.clamp,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: padding ?? EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: child,
      ),
    );
  }
}

class TimerDialogBox extends StatelessWidget {
  final String sourcePage;
  final bool isFromPlaylist;
  final bool isFromInterMediatePage;

  const TimerDialogBox({
    @required this.sourcePage,
    @required this.isFromPlaylist,
    @required this.isFromInterMediatePage,
  });

  @override
  Widget build(BuildContext context) {
    final musicLocator = locator<MusicService>();
    Widget _buildTimerDialogItem(
        {@required String title, Function onPressed, int timerDuration}) {
      return InkWell(
        onTap: onPressed ??
                () async {
              musicLocator.remainingTimerDuration.value =
                  Duration(minutes: timerDuration);
              musicLocator.startTimer();

              musicLocator.isFirstClickTimer.value = false;
              Navigator.pop(context);

              if (isFromInterMediatePage) {
                navigateToSinglePlayerOnly(context, isFromPlaylist,
                    'Single player page from $sourcePage');
                await onPressedPlayPauseButton();
              }
            },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Row(children: <Widget>[
              Icon(CupertinoIcons.timer,
                  color: whiteColor.withOpacity(0.9),
                  size: getFontSize(context, 4.17)),
              SizedBox(width: 10),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: Colors.white),
              )
            ]),
          ),
        ),
      );
    }

    return DialogWrapper(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                'Set Timer',
                style: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(color: Colors.white),
              ),
            ),
            SizedBox(height: 10),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  _buildTimerDialogItem(
                      title: 'Custom Time',
                      onPressed: () {
                        Navigator.of(context).pop();
                        showCustomTimerDialog(context, isFromInterMediatePage);
                      }),

                  ///// timer duration is sent in terms of minutes
                  _buildTimerDialogItem(title: '10 minutes', timerDuration: 10),
                  _buildTimerDialogItem(title: '20 minutes', timerDuration: 20),
                  _buildTimerDialogItem(title: '30 minutes', timerDuration: 30),
                  _buildTimerDialogItem(title: '45 minutes', timerDuration: 45),
                  _buildTimerDialogItem(title: '1 hour', timerDuration: 1 * 60),
                  _buildTimerDialogItem(
                      title: '2 hours', timerDuration: 2 * 60),
                  _buildTimerDialogItem(
                      title: '4 hours', timerDuration: 4 * 60),
                  _buildTimerDialogItem(
                      title: '8 hours', timerDuration: 8 * 60),
                ],
              ),
            ),

            //   ListView(),
          ],
        ),
      ),
    );
  }

  showCustomTimerDialog(BuildContext context, bool isFromInterPage) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) {
          return MusicTImerCustomDialog(
            isfromInterPage: isFromInterMediatePage,
          );
        });
  }
}

class MusicTImerCustomDialog extends StatefulWidget {
  final bool isfromInterPage;
  const MusicTImerCustomDialog({this.isfromInterPage = false});

  @override
  _MusicTImerCustomDialogState createState() => _MusicTImerCustomDialogState();
}

class _MusicTImerCustomDialogState extends State<MusicTImerCustomDialog> {
  final musicLocator = locator<MusicService>();
  Duration temp = Duration.zero;
  bool timerError = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bodyText2 = theme.textTheme.bodyText2.copyWith(color: Colors.white);
    return DialogWrapper(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 8.0),
                    child: Text(
                      set_timer,
                      style: theme.textTheme.headline5
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  Text(timer_message, style: bodyText2),
                  Text('the set timer', style: bodyText2)
                ],
              ),
            ),
            CustomTimePicker(
              onTimePicked: (val) {
                temp = val;
                musicLocator.remainingTimerDuration.value = val;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: InkWell(
                onTap: () async {
                  if (temp == Duration.zero) {
                    setState(() {
                      timerError = true;
                    });
                  } else {
                    musicLocator.remainingTimerDuration.value = temp;
                    musicLocator.startTimer();
                    Navigator.pop(context);
                    musicLocator.isFirstClickTimer.value = false;

                    if (widget.isfromInterPage) {
                      navigateToSinglePlayerOnly(
                          context, false, 'Single player page from card');
                      await onPressedPlayPauseButton();
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: blackColor,
                      borderRadius: BorderRadius.circular(15),
                      gradient: timerDialogGradient),
                  width: 110,
                  height: 45,
                  child: Center(
                    child: Text(set_timer.toUpperCase(), style: bodyText2),
                  ),
                ),
              ),
            ),
            timerError
                ? Center(
              child: Text(
                'Please pick time',
                style:
                theme.textTheme.bodyText2.copyWith(color: Colors.red),
              ),
            )
                : Offstage()
          ],
        ),
      ),
    );
  }
}

class TimerActiveDialog extends StatelessWidget {
  final musicLocator = locator<MusicService>();

  Widget buildTimerComponent(
      {String value, String bottomText, @required BuildContext context}) {
    return Column(
      //   mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: activeTimerTextColor, width: 1),
                bottom: BorderSide(color: activeTimerTextColor, width: 1),
              )),
          child: Text(
            '$value',
            style: Theme.of(context)
                .textTheme
                .headline2
                .copyWith(color: Colors.white),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          bottomText,
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: activeTimerTextColor),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final sizeManager = ResponsiveFlutter.of(context);
    return DialogWrapper(
        child: ValueListenableBuilder(
            valueListenable: musicLocator.remainingTimerDuration,
            builder: (context, Duration remainingTimerDuration, _) {
              var hour;
              var minutes;
              var seconds;
              if (remainingTimerDuration.inSeconds == 0 &&
                  ModalRoute.of(context).isCurrent) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pop(context);
                });
              }
              var splitTime = remainingTimerDuration.toString().split(":");
              hour = splitTime[0];
              minutes = splitTime[1];
              seconds = splitTime[2].split(".").first;

              if (hour == "-0") hour = "00";
              if (minutes == "-0") minutes = "00";
              if (seconds == "-0") seconds = "00";

              return Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Music will stop when you',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: activeTimerTextColor),
                    ),

                    Text('press the stop timer',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: activeTimerTextColor)),
                    SizedBox(height: sizeManager.hp(5.6)),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        buildTimerComponent(
                            value: hour.toString() == "0" ? "00" : hour,
                            bottomText: "HR",
                            context: context),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(":",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  .copyWith(color: activeTimerColonColor)),
                        ),
                        buildTimerComponent(
                            value: minutes.toString(),
                            bottomText: "MIN",
                            context: context),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(":",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  .copyWith(color: activeTimerColonColor)),
                        ),
                        buildTimerComponent(
                          value: seconds.toString(),
                          bottomText: "SE",
                          context: context,
                        ),
                      ],
                    ),

                    /// cancel already running timer button
                    InkWell(
                      onTap: () {
                        musicLocator.remainingTimerDuration.value =
                            Duration(seconds: 0);
                        // musicLocator.timer = Duration(seconds: 0);
                        musicLocator.stopTimer();
                        musicLocator.isFirstClickTimer.value = true;

                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Container(
                          // height: sizeManager.wp(9.73),
                          width: sizeManager.wp(21.89),
                          padding: EdgeInsets.symmetric(
                              vertical: sizeManager.hp(1.5)),
                          decoration: BoxDecoration(
                            gradient: timerDialogGradient,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text(stop_t,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(color: Colors.white))),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }));
  }
}

class CustomTimePicker extends StatelessWidget {
  final ValueChanged<Duration> onTimePicked;

  CustomTimePicker({this.onTimePicked});

  @override
  Widget build(BuildContext context) {
    int selectedHour = 0;
    int selectedMinute = 0;

    return Center(
      child: Container(
        height: 200,
        width: 200,
        child: Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //hour picker
                  Flexible(
                    child: buildPicker(
                      items: 24,
                      selectedItem: selectedHour,
                      onItemChanged: (value) {
                        selectedHour = value;

                        onTimePicked(
                          Duration(
                            hours: value,
                            minutes: selectedMinute,
                          ),
                        );
                      },
                    ),
                  ),
                  Text(
                    "HR",
                    style: TextStyle(color: activeTimerTextColor, fontSize: 20),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: Text(
                ':',
                style: TextStyle(color: Color(0xff448AFF), fontSize: 26),
              ),
            ),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    child: buildPicker(
                      items: 60,
                      selectedItem: selectedMinute,
                      onItemChanged: (value) {
                        selectedMinute = value;

                        onTimePicked(
                          Duration(
                            hours: selectedHour,
                            minutes: value,
                          ),
                        );
                      },
                    ),
                  ),
                  Text(
                    "MIN",
                    style: TextStyle(color: activeTimerTextColor, fontSize: 20),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  CupertinoPicker buildPicker(
      {int items, int selectedItem, ValueChanged<int> onItemChanged}) {
    return CupertinoPicker(
      scrollController: FixedExtentScrollController(initialItem: selectedItem),
      itemExtent: 33,
      backgroundColor: Colors.transparent,
      looping: true,
      squeeze: 1,
      onSelectedItemChanged: (int index) {
        onItemChanged(index);
      },
      children: List<Widget>.generate(items, (int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text(
            index < 10 ? '0' + index.toString() : index.toString(),
            style: TextStyle(color: whiteColor, fontSize: 28),
          ),
        );
      }),
    );
  }
}

class InfoDialog extends StatelessWidget {
  final musicLocator = locator<MusicService>();
  @override
  Widget build(BuildContext context) {
    return DialogWrapper(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(musicLocator.currentTrack.value.title,
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 10),
              Text(
                'Composer: ' + musicLocator.currentTrack.value.composer,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                musicLocator.currentTrack.value.description,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
