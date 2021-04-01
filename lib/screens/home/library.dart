
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goodvibesofficial/constants/fontconstants.dart';
class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library>with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController=TabController(length: 2, vsync: this);

  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return
      DefaultTabController(length: 2, child:
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Color(0xfff5f5f5),
            centerTitle: false,
            title: Container(
              margin: EdgeInsets.only(left: 14),
              //        padding: EdgeInsets.all(8),
              child: SvgPicture.asset('assets/images/logo 2.svg',
                color: Color(0xff9797de),
                //      fit: BoxFit.cover,
                //          width: 35,
              ),
            ),
bottom: TabBar(
  indicatorColor: Colors.transparent,
indicator: BoxDecoration(
  color: Colors.transparent
),  unselectedLabelStyle: TextStyle(
    color: Colors.grey[400],
    fontFamily: helveticaneuemedium
      ,fontSize: 24
  ),
  controller: tabController,
  onTap: (v){
    setState(() {
tabController.index=v;
    });
  },
  tabs: [
    Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
    Container(
      width: 120,
        child:
    Tab(

        child:     Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
  Container(
      child: Text('Favorites',style: TextStyle(
        fontFamily: helveticaneuemedium,
        color: tabController.index==0?
        Colors.black87:Colors.grey[400],

          fontSize: 24
      ),),
    ),])))]),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children:[
            Container(
            width: 140,
            child:
    Tab(child:
    Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
    Container(
      child: Text('Downloads',style: TextStyle(
          fontFamily: helveticaneuemedium,
          color:tabController.index==1?
          Colors.black87:Colors.grey[400],fontSize: 24
      ),),
    ),])))])
  ],
),
        ),
        body:
        TabBarView(
            controller: tabController,
            children:[    Icon(Icons.app_blocking,color: Colors.black87,size: 30,),
          Icon(Icons.arrow_forward,color: Colors.black87,size: 30,)
      ])
      ));
  }
}
