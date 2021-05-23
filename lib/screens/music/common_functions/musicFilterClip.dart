import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodvibesoffl/services/appConfig.dart';
import 'package:goodvibesoffl/utils/theme/style.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class MusicFilterChip extends StatelessWidget {
  final bool isSelected;
  final String title;
  final Function onPressed;
  MusicFilterChip(
      {@required this.isSelected, @required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final sizeManager = ResponsiveFlutter.of(context);
    ScreenUtil.init(context, width: 720, height: 1280, allowFontScaling: false);
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ButtonTheme(
        minWidth: 60.sp,
        buttonColor: Colors.transparent,
        child: RaisedButton(
          onPressed: onPressed,
          //   color: Colors.transparent,
          elevation: 0,
          highlightColor: tpt,
          highlightElevation: 0,
          hoverColor: tpt,
          focusColor: tpt,
          color: tpt,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          padding: EdgeInsets.zero,
          child: Ink(
            height: Theme.of(context).textTheme.subtitle1.fontSize +
                (AppConfig.isTablet ? sizeManager.hp(3) : sizeManager.hp(6)),
            padding: EdgeInsets.symmetric(horizontal: 25.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                  colors: isSelected
                      ? [
                    Color(0xFF1C91FB),
                    Color(0xFF5688FF),
                    Color(0xFF8C79FF),
                    Color(0xFFC161FF),
                    Color(0xFFF231FE)
                  ]
                      : [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.1)
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: isSelected ? Colors.white : Color(0xFFEEAEFF),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
