import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_flutter_map/map_page.dart';
import 'package:simple_flutter_map/model/location_model.dart';

import 'LogInScreen.dart';
import 'components/custom_item_circular.dart';

class ListPage extends StatefulWidget {
  ListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  DatabaseReference dbRef =
  FirebaseDatabase.instance.reference().child('location');
  FirebaseAuth auth = FirebaseAuth.instance;
  User user;



  @override
  void initState() {
    user = auth.currentUser;
  }


  //List locations;

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(LocationModel location) =>
        ListTile(
         // contentPadding:
         // EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 13.0),
            // decoration: new BoxDecoration(
            //     border: new Border(
            //         right: new BorderSide(width: 1.0, color: Colors.white))),
            child: Icon(Icons.edit, color: Colors.white),
          ),
          title: Text("longitude: "+
            location.longitude.toString(),
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10,),
              Text("latitude: "+location.latitude.toString(),
                  style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 16))
            ],
          ),
          trailing:
          Icon(Icons.delete, color: Colors.white, size: 30.0),
          onTap: () {},
        );

    Card makeCard(LocationModel location) =>
        Card(

          color: Color(0xff000752),
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(border:Border.all(color: Color(0xffff2fc3),width: 2,),borderRadius: BorderRadius.circular(12),),
            child: makeListTile(location),
          ),
        );

    final makeBody = Container(
      decoration: BoxDecoration(color: Color(0xff000752)),

      //height: 160,
      child: StreamBuilder(
       stream: dbRef.orderByChild('uid').equalTo(user.uid).onValue,
       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
         if (snapshot.hasData ) {
           Event event = snapshot.data;
           DataSnapshot snap = event.snapshot;

           Map map = snap.value;
           if (map!=null) {
             List<LocationModel> locations = [];
             for (Map each in map.values) {
               LocationModel location = LocationModel(
                 longitude: each['longituden'],
                 latitude: each['latitude'],
               );

               print(location.latitude);
               print(location.longitude);

               locations.add(location);
             }
             return ListView.builder(
               padding: EdgeInsets.all(10),
               itemCount: locations.length,
               scrollDirection: Axis.vertical,
               itemBuilder: (context, index) {
                 return makeCard(locations[index]);
               },
             );
           }
           else{
             return Container(
               width: double.infinity,
               height: 100,
               //color: Colors.blue,
               child: Column(
                 children: [
                   SizedBox(
                     height: 20,
                   ),


                   Text("There is no location history",style: TextStyle(fontSize: 16,color: Colors.white),),
                 ],
               )


             );




           }
         }
         else {
           return ListView(
             scrollDirection: Axis.vertical,
             children: [
               CustomItemCircular(),
             ],

           );
         }
       },
        ),
    );


    final makeBottom = Container(
      height: 55.0,
      child: BottomAppBar(
        color:  Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Color(0xff000725)),
              onPressed: (
                  ) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MapPage();
                }));

              },
            ),


            IconButton(
              icon: Icon(Icons.exit_to_app,color: Color(0xff000725)),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LogInScreen();
                }));

              },
            )



          ],
        ),
      ),
    );
    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color(0xffff2fc3),
      title: Text(widget.title),

    );

    return Scaffold(
      backgroundColor: Color(0xff000752),
      appBar: topAppBar,
      body: makeBody,
      bottomNavigationBar: makeBottom,
    );
  }
} // _list
