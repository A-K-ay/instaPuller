import 'package:flutter/material.dart';
import '../components/text_field_container.dart';
import '../constants.dart';

class InputFeildNoBorder extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final Function onSubmitted;
  final TextEditingController controller;
  final Function fuc;
  final ValueChanged<String> onChanged;
  final double width;
  const InputFeildNoBorder({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,this.controller,this.onSubmitted,this.fuc,this.width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: width!= null? width:size.width * 0.8,
        child: TextFormField(
          controller: controller,
          onFieldSubmitted: (val){
            onSubmitted();
          },
          validator: fuc,
          onChanged: onChanged,
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            icon: Icon(
              icon,
              color: kPrimaryColor,
            ),
            hintText: hintText,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}


