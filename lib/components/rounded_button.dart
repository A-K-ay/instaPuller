import 'package:flutter/material.dart';
import '../constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  final double width;
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
    this.width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: width!= null? width:size.width * 0.8,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FlatButton(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            color: color,
            onPressed: press,
            child: Text(
              text,
              style: TextStyle(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
