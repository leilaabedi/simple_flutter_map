import 'package:flutter/material.dart';
import 'package:simple_flutter_map/model/location_model.dart';

import '../constants.dart';

class CustomItem extends StatelessWidget {
  final Function onPressed;
  final LocationModel location;

  CustomItem({this.onPressed, this.location});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.all(10),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "logitue is " + location.longitude.toString(),
                  style: kHeaderTextStyle.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "latitude is " + location.latitude.toString(),
                  style: kHeaderTextStyle.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
