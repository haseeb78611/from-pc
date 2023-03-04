import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final onPressed;
  final icon;
  final text ;
  final double width;
  final  alignment;

  const MyButton({
    super.key,
    required this.onPressed,
    this.icon,
    this.text = '',
    this.width = 120,
    required this.alignment
  });


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Container(
          width: width,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Row(
               mainAxisAlignment: alignment ,
               children: [
                 (icon == null) ?
                 Container(child: Text(text,textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),))
                 :
                 Text(text, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
                 Icon(icon),

          ],
        ),
      ),
    )
    );
  }
}
