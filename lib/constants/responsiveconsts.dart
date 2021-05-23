import 'package:flutter/cupertino.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

responsivefontsize<Widget>(BuildContext context,double fontsize){
  return ResponsiveFlutter.of(context).fontSize(fontsize);
}
responsiveverticalmarpad<Widget>(BuildContext context,double mag){
  return ResponsiveFlutter.of(context).verticalScale(mag);
}
responsivehorizontalmarpad<Widget>(BuildContext context,double mag){
  return ResponsiveFlutter.of(context).scale(mag);
}