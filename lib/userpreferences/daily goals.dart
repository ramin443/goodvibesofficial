import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goodvibesofficial/constants/fontconstants.dart';
class DailyGoals extends StatefulWidget {
  @override
  _DailyGoalsState createState() => _DailyGoalsState();
}

class _DailyGoalsState extends State<DailyGoals> {
  String selected='casual';
  bool casual=false;
  bool regular=false;
  bool professional=false;
  bool saved=false;
  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: saved?Container(
        width: 100,
        height: 26,
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Center(child: Text("Saved",style: TextStyle(
          fontFamily: helveticaneueregular,
          color: Colors.white,
        fontSize: 14
        ),),),
      ):SizedBox(height: 0,),
      bottomNavigationBar:
      GestureDetector(
          onTap: (){
setState(() {
  saved=true;
});
          },
          child:Container(
            margin: EdgeInsets.only(
              left: screenwidth*0.0586,
              right: screenwidth*0.0586,
              bottom: 16
            ),
        width: screenwidth*0.8,
        height: screenwidth*0.1066,
        decoration: BoxDecoration(
          color: Color(0xff9797de),
          borderRadius: BorderRadius.all(Radius.circular(20))
,        ),
        child: Center(child: Container(child: Text("Save",style: TextStyle(
          fontFamily: helveticaneueregular,
          color: Colors.white,
          fontSize: 16
        ),),),),
      )),
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text("Daily Goal",style: TextStyle(fontFamily: helveticaneuemedium,
        color: Colors.black87,
          fontSize: 18
        ),),
        leading: IconButton(
          icon: Icon(CupertinoIcons.back,
            color: Colors.black87,
          size: 24,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 32,right: 32,top: 16),
        child: Column(children: [
          Container(child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Container(child: Column(
              mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
              children: [
Container(child: Text("Casual",style: TextStyle(
  fontFamily: helveticaneuemedium,
  color: Colors.black87,
  fontSize: 17.5
),),),
                Container(child: Text("10 minutes a day",style: TextStyle(
                    fontFamily: helveticaneueregular,
                    color: Colors.black87,
                    fontSize: 15
                ),),),
            ],),),
GestureDetector(  onTap:(){
  setState(() {
    selected='casual';
  });
},child: Container(
  padding: EdgeInsets.all(4),
  height: 22,width: 22,
  child: Container(
    height: double.infinity,
    width: double.infinity,
    decoration: BoxDecoration(
      color: selected=='casual'?Color(0xff9797de):Colors.transparent,
shape: BoxShape.circle
    ),
  ),
  decoration: BoxDecoration(
    shape: BoxShape.circle,
border: Border.all(width: 1,color: selected=='casual'?Color(0xff12c2e9):Colors.black87)
  ),
),)

          ],),),
          Container(
            margin: EdgeInsets.only(top: 16),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(child: Column(
                mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(child: Text("Regular",style: TextStyle(
                      fontFamily: helveticaneuemedium,
                      color: Colors.black87,
                      fontSize: 17.5
                  ),),),
                  Container(child: Text("30 minutes a day",style: TextStyle(
                      fontFamily: helveticaneueregular,
                      color: Colors.black87,
                      fontSize: 15
                  ),),),
                ],),),
              GestureDetector(
                onTap:(){
                  setState(() {
                    selected='regular';
                  });
                },child: Container(
                padding: EdgeInsets.all(4),
                height: 22,width: 22,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: selected=='regular'?Color(0xff9797de):Colors.transparent,
                      shape: BoxShape.circle
                  ),
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 1,color:selected=='regular'?Color(0xff12c2e9): Colors.black87)
                ),
              ),)

            ],),),
          Container(
            margin: EdgeInsets.only(top: 16),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(child: Column(
                mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(child: Text("Professional",style: TextStyle(
                      fontFamily: helveticaneuemedium,
                      color: Colors.black87,
                      fontSize: 17.5
                  ),),),
                  Container(child: Text("60 minutes a day",style: TextStyle(
                      fontFamily: helveticaneueregular,
                      color: Colors.black87,
                      fontSize: 15
                  ),),),
                ],),),
              GestureDetector(
                onTap: (){
                  setState(() {
                    selected='professional';
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  height: 22,width: 22,
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: selected=='professional'?Color(0xff9797de):Colors.transparent,
                        shape: BoxShape.circle
                    ),
                  ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 1,color: selected=='professional'?Color(0xff12c2e9):Colors.black87)
                ),
              ),)

            ],),),
        ],),
      ),
    );
  }
}
