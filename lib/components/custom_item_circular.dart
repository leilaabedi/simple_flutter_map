import 'package:flutter/material.dart';

class CustomItemCircular extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 140,
      margin: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
         color: Color.fromRGBO(58, 66, 86, 1.0),
        //Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Container(
          height: 60,
          width: 60,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ),
    );
  }
}
