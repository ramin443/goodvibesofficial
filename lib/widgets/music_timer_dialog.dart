import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:goodvibesofficial/services/player_service.dart';
import 'package:goodvibesofficial/utils/common_functiona.dart';
//import 'package:goodvibesofficial/utils/common_player_function.dart';
//import 'package:goodvibesofficial/utils/theme/good_vibes_icons_icons.dart';
import 'package:goodvibesofficial/utils/theme/style.dart';
import 'package:goodvibesofficial/utils/strings/string_constants.dart';
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

