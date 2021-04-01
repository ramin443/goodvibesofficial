import 'package:flutter/material.dart';
import 'package:goodvibesofficial/utils/theme/style.dart';

final bold = FontWeight.bold;
final w300 = FontWeight.w300;
final w400 = FontWeight.w400;
final w500 = FontWeight.w500;
final w600 = FontWeight.w600;

final poppinsRegular = "Poppins";
final poppinsBolld = "Poppins";
final proxima = 'ProximaNova';

// white texts
final whiteText = TextStyle(color: whiteColor);
final whiteText8 = TextStyle(color: whiteColor, fontSize: 8.0);
final whiteText9 = TextStyle(color: whiteColor, fontSize: 9.0);
final whiteText20 = TextStyle(color: whiteColor, fontSize: 20.0);
final whiteText12 = TextStyle(color: whiteColor, fontSize: 12.0);
final whiteText14 =
TextStyle(color: whiteColor, fontSize: 14.0, fontFamily: 'Poppins');
final whiteText16 = TextStyle(color: whiteColor, fontSize: 16.0);
final whiteText24 = TextStyle(color: whiteColor, fontSize: 24.0);
final whiteText18 =
TextStyle(color: whiteColor, fontSize: 18.0, fontFamily: poppinsRegular);
final whiteText45 = TextStyle(color: Colors.white, fontSize: 45.0);
final whiteText34 = TextStyle(color: Colors.white, fontSize: 34.0);
final white13bold =
TextStyle(fontWeight: bold, fontSize: 13.0, color: whiteColor);
final whiteText18bold =
TextStyle(color: whiteColor, fontSize: 18.0, fontWeight: bold);
final whiteText16bold =
TextStyle(color: whiteColor, fontSize: 14.0, fontWeight: bold);
final whiteText22bold =
TextStyle(color: whiteColor, fontSize: 22.0, fontWeight: bold);

final whiteText32 =
TextStyle(fontSize: 32, color: whiteColor, letterSpacing: 3);
final whiteText24bold =
TextStyle(color: whiteColor, fontSize: 24.0, fontWeight: bold);
final whiteText14Underline = TextStyle(
    color: whiteColor, fontSize: 14.0, decoration: TextDecoration.underline);
final whiteBoldUnderline = TextStyle(
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
    color: Colors.white);

final whiteBoldSpacing3 = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  letterSpacing: 3,
);

/// black texts
final blackText = TextStyle(color: blackColor);
final blackBold = TextStyle(fontWeight: FontWeight.bold);
final blackText12 = TextStyle(fontSize: 12.00, color: blackColor);

final black14opacity12 = TextStyle(fontSize: 14, color: Colors.black12);
final blackText13 = TextStyle(fontSize: 13.00, color: blackColor);
final blackText14 = TextStyle(fontSize: 14.00, color: blackColor);
final blackText16 = TextStyle(fontSize: 16.00, color: blackColor);
final black16w500 =
TextStyle(color: blackColor, fontSize: 16.0, fontWeight: FontWeight.w500);
final blackBold16 = TextStyle(fontSize: 16.0, fontWeight: bold);
final blackText18 = TextStyle(fontSize: 18.0);
final blackBold18 = TextStyle(fontSize: 18.0, fontWeight: bold);
final blackBold20 = TextStyle(fontSize: 20.00, fontWeight: bold);
final blackBold24 = TextStyle(fontSize: 24.00, fontWeight: bold);
final blackBold30 = TextStyle(fontSize: 30.0, fontWeight: bold);
final black16w600 = TextStyle(fontSize: 20, fontWeight: FontWeight.w600);

/// light pink texts
final lightPink14 = TextStyle(fontSize: 14.0, color: lightPink);
final lightPink17 = TextStyle(fontSize: 17.0, color: lightPink);
final lightPink16 = TextStyle(color: lightPink, fontSize: 16.0);
final lightPinkText = TextStyle(color: lightPink, fontFamily: poppinsRegular);

/// bluish purple texts
final bluishPurple12 = TextStyle(color: bluishPurple, fontSize: 12.0);
final bluishPurple8 = TextStyle(color: bluishPurple, fontSize: 12.0);

//// grey texts
final greyText12 = TextStyle(fontSize: 12, color: Colors.grey);

/// blue texts
const blueText18 = TextStyle(fontSize: 18.00, color: Colors.blue);
final blueUnderline =
TextStyle(color: Colors.blue, decoration: TextDecoration.underline);

/// custom grey
final customGrey12 = TextStyle(fontSize: 12.0, color: customGrey);
final customGrey14 = TextStyle(fontSize: 14.0, color: customGrey);

//yellow
final yellowText = TextStyle(color: Colors.yellow);

// custom light blue
final customLightBlue14 = TextStyle(color: customLightBlue, fontSize: 14.0);

/// single music player page
final trackNameDecoration =
TextStyle(color: tracknameColor, decoration: TextDecoration.underline);

final font14w500 = TextStyle(fontSize: 14, fontWeight: w500);
final font14w600 = TextStyle(fontSize: 14, fontWeight: w600);
final font16w600 = TextStyle(fontSize: 16, fontWeight: w600);

final roboto12 = TextStyle(fontSize: 12.0, fontFamily: 'Roboto');
final roboto14 = TextStyle(fontSize: 14.0, fontFamily: 'Roboto');
final roboto22 = TextStyle(fontSize: 22.0, fontFamily: 'Roboto');
final roboto24bold = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 24.0, fontFamily: 'Roboto');

final slivereAppBarStyle =
TextStyle(fontWeight: bold, color: Color(0xFFEEAEFF), fontSize: 18.0);

const greenText22 = TextStyle(color: Colors.green, fontSize: 22);

final musicTimerStyle = TextStyle(
  color: Color(0xff3f3fb3),
  fontSize: 24.0,
  letterSpacing: 6.0,
);

// offline page

final oflineInternetStyle = TextStyle(color: Color(0xFFA3A7B2), fontSize: 16.0);

final errorMessageStyle =
TextStyle(color: errorMessageColor, fontSize: 18, fontFamily: 'Poppins');

//// dialogs related

final activeTimerColonStyle =
TextStyle(color: activeTimerColonColor, fontSize: 30);

getPasswordTextFieldDecoration(String hint, BuildContext context) {
  return InputDecoration(
    hintText: hint,
    border: InputBorder.none,
    hintStyle: Theme.of(context).textTheme.subtitle1,
    errorStyle: Theme.of(context).textTheme.bodyText2,
    // prefixIcon: Icon(
    //   Icons.lock,
    //   color: Color(0xFFEEAEFF),
    //   size: getFontSize(context, 3.3),
    // ),
  );
}
