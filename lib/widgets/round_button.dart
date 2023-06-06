import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class RoundButton extends StatelessWidget {

  final String title;
  final VoidCallback onTap ;

  const RoundButton({Key?key , required this.title,required this.onTap}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,

      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Center(child: Text(title,style: TextStyle(color: Colors.white),)),
      ),
    );
  }
}