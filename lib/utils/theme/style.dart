import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../services/appConfig.dart';

final symmetricHorizonatalPadding =
AppConfig.isTablet ? ScreenUtil().setWidth(30) : ScreenUtil().setWidth(20);

final whiteColor = Colors.white;
final blackColor = Colors.black;
final black54 = Colors.black54;
final greyColor = Colors.grey;
final tpt = Colors.transparent;
final tracknameColor = Color(0xFFBBDEFB);
final lightPink = Color(0xFFEEAEFF);
final bluishPurple = Color(0xFF3F3FB6);
final circularIndicatorColor = Color(0xFF3F3FB6);
final activeTimerColonColor = Color(0xff448AFF);
final activeTimerTextColor = Color(0xffBCE0FD);
final customGrey = Color(0xFF707070);
final customLightBlue = Color(0xFF448AFF);
final errorMessageColor = Color(0xffE2A4F5);
final lightBlue = Color(0xFFB2C2FC);
final meditateTitleColor = Color(0xFFEFEFEF);

final circularBorderRadius10 = BorderRadius.circular(10.0);
final circularBorderRadius8 = BorderRadius.circular(8.0);
final circularBorderRadius5 = BorderRadius.circular(5.0);

final containerCircularBlackBorderDecoration = BoxDecoration(
    border: Border.all(color: Colors.black54, style: BorderStyle.solid),
    borderRadius: circularBorderRadius10,
    color: Colors.white);

final radialGradient = RadialGradient(
  colors: [Color(0xFFBBDEFB), Color(0xffE4F0F7)],
  radius: 300,
);

final dialogButtonLinearGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: [0.1, 0.9],
  colors: [
    Color(0xFF7E2BF5),
    Color(0xFF3741AE),
  ],
);

final homepageInviteContainerGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: [0.1, 0.9],
  colors: [
    Color(0xFF3741AE),
    Color(0xFF7E2BF5),
  ],
);

final dialogButtonverticalGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  // stops: [0.1, 0.9],
  colors: [
    Color(0xFF3741AE),
    Color(0xFF7E2BF5),
  ],
);

final timerDialogGradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    Color(0xff188DF8).withOpacity(0.8),
    Color(0xffA63FE0),
  ],
);

final gradientCenter = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [0.1, 0.9],
  colors: [
    Color(0xFF4025B2),
    Color(0xFF6619A5),
  ],
);

final songsGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [0.4, 0.9],
  colors: [
    Color(0x114025B2),
    Color(0xBB6619A5),
  ],
);

final reminderPageGradientDec = BoxDecoration(
  borderRadius: BorderRadius.circular(5.0),
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF1C91FB),
      Color(0xFF5688FF),
      Color(0xFF8C79FF),
      Color(0xFFC161FF),
      Color(0xFFF231FE),
    ],
  ),
);

final lightBluePinkGradientL2R = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    Color(0xFF1C91FB),
    Color(0xFF5688FF),
    Color(0xFF8C79FF),
    Color(0xFFC161FF),
    Color(0xFFF231FE),
  ],
);

final lightBluePinkGradientT2B = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF1C91FB),
    Color(0xFF5688FF),
    Color(0xFF8C79FF),
    Color(0xFFC161FF),
    Color(0xFFF231FE),
  ],
);

final bluePurpleGradientT2B = LinearGradient(
  colors: [
    Color(0xff3C27B4),
    Color(0xff4B24B0),
    Color(0xff5820AC),
    Color(0xff621CA8),
    Color(0xff6B18A4),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

final bluePurpleGradientL2R = LinearGradient(
  colors: [
    Color(0xff3C27B4),
    Color(0xff4B24B0),
    Color(0xff5820AC),
    Color(0xff621CA8),
    Color(0xff6B18A4),
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

final genreListViewCardGradient = LinearGradient(
  colors: [
    Color(0xFF6B18A4),
    Color(0xFF621CA8),
    Color(0xFF5222AE),
    Color(0xFF4C24B0),
    Color(0xFF4425b2),
    Color(0xFF3C27B4),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: [0.1, 0.4, 0.6, 0.78, 0.85, 1],
);

final songsCardDecoration = BoxDecoration(
  //  color: Colors.green,
    borderRadius: BorderRadius.circular(5.0),
    gradient: songsGradient);

final subscriptionDialog = BoxDecoration(
    gradient: dialogButtonLinearGradient, borderRadius: circularBorderRadius5);

final musicPlayerButtonsDecoration = BoxDecoration(boxShadow: <BoxShadow>[
  BoxShadow(
    color: Colors.black12,
    offset: Offset(1.0, 6.0),
    blurRadius: 20.0,
  ),
], color: Color(0xFFFAFAFA), borderRadius: BorderRadius.circular(35.0));

final cancelDialogButtonDec = BoxDecoration(
    borderRadius: circularBorderRadius10, gradient: dialogButtonLinearGradient);

final underLineGreyBorder =
Border(bottom: BorderSide(color: greyColor, width: 1));

final purpleBoxShadow = <BoxShadow>[
  BoxShadow(
      color: Colors.purple.withOpacity(0.6),
      offset: Offset(1.0, 1.0),
      blurRadius: 6.0),
];

final offlineButtonDecoration = BoxDecoration(
  boxShadow: <BoxShadow>[
    BoxShadow(
      color: Color(0xFFDBE7F5),
      offset: Offset(1.0, 10.0),
      blurRadius: 10.0,
    ),
  ],
  borderRadius: BorderRadius.circular(25.0),
  gradient: dialogButtonLinearGradient,
);

final trialButtonDecoration = BoxDecoration(
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
    border: Border.fromBorderSide(BorderSide.none),
    gradient: gradientCenter);

final trialButtonContainerDecoration = BoxDecoration(boxShadow: <BoxShadow>[
  BoxShadow(
    spreadRadius: 1,
    color: Color(0xff581DAA).withOpacity(0.3),
    blurRadius: 8.0,
  ),
], borderRadius: BorderRadius.circular(5.0), color: Colors.white);

final whiteCircular5Dec = BoxDecoration(
    borderRadius: BorderRadius.circular(5.0), color: Colors.white);

final homeCircularAvtarDec = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.1, 0.9],
    colors: [
      Color(0xFF6619A5),
      Color(0xFF4025B2),
    ],
  ),
  shape: BoxShape.circle,
);

final paymentCardTopDec = BoxDecoration(
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
    gradient: bluePurpleGradientL2R);

final circularBorderDecoration = BoxDecoration(
  shape: BoxShape.circle,
  color: Colors.white,
  border: Border.all(
    width: 2.0,
    color: bluishPurple,
  ),
);

final musicPlayerDialogGradient = LinearGradient(
  begin: Alignment(0.0, -1.0),
  end: Alignment(0.0, 1.0),
  colors: [const Color(0xff3c27b4), const Color(0xff6b18a4)],
  stops: [0.0, 1.0],
);

final lightColorsGradint = LinearGradient(
  colors: [
    Color(0xff188DF8).withOpacity(0.8),
    Color(0xffA63FE0),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

final animatedDialogStyle = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xff188DF8).withOpacity(0.8),
        Color(0xffA63FE0),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20),
      bottomLeft: Radius.circular(20),
      bottomRight: Radius.circular(20),
    ));

final someStyle = BoxDecoration(
  // gradient: musicPlayerDialogGradient,

  gradient: LinearGradient(
    colors: [
      Color(0xff3C27B4),
      Color(0xff6A18A5).withAlpha(200),
    ],
    //  stops: [0.9, 0.4],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),

  // border: Border.all(color: whiteColor, width: 0.001),
  borderRadius: BorderRadius.circular(10),
);

final dialogButtonGradient = LinearGradient(
  colors: [
    Colors.lightBlue.withOpacity(0.8),
    Color(0xffCE41FD),
  ],
  end: Alignment.centerRight,
  begin: Alignment.centerLeft,
);

final ritualsCardGradientV = LinearGradient(
  colors: [
    Color(0xff6B18A4),
    Color(0xff3C27B4),
  ],
  end: Alignment.topCenter,
  begin: Alignment.bottomCenter,
);
final bottomNavBarGradient = LinearGradient(
  colors: [
    Color(0xff6B18A4),
    Color(0xff3C27B4),
  ],
  end: Alignment.topLeft,
  begin: Alignment.bottomRight,
);

final cardHorizontalGradient = LinearGradient(
  colors: [
    Color(0xFF6B18A4),
    Color(0xFF621CA8),
    Color(0xFF5222AE),
    Color(0xFF4C24B0),
    Color(0xFF4425b2),
    Color(0xFF3C27B4),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: [0.1, 0.4, 0.6, 0.78, 0.85, 1],
);
final cardHorizontalGradientReverse = LinearGradient(
  colors: [
    Color(0xFF6B18A4),
    Color(0xFF621CA8),
    Color(0xFF5222AE),
    Color(0xFF4C24B0),
    Color(0xFF4425b2),
    Color(0xFF3C27B4),
  ],
  begin: Alignment.bottomRight,
  end: Alignment.topLeft,
  stops: [0.1, 0.4, 0.6, 0.78, 0.85, 1],
);

// invite dialog text styles:

final inviteDialogTitleStyle = TextStyle(
    color: whiteColor,
    fontSize: ScreenUtil().setSp(35),
    fontWeight: FontWeight.w700);

final inviteDialogSubtitleStyel =
TextStyle(color: whiteColor, fontSize: ScreenUtil().setSp(30));

final composerItemInactiveG = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xff3C27B4).withAlpha(255), Color(0xff6B18A4).withAlpha(2555)],
);
final composerItemActiveG = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xff618BFA), Color(0xff618BFA)]);
// boxShadow: (!playingIds
//         .contains(
//             notTracks[
//                     index]
//                 .id))
//     ? []
//     : [
//         BoxShadow(
//           blurRadius: 10,
//           color:
//               whiteColor,
//           offset: Offset(
//               0, 0),
//         ),
//       ],
