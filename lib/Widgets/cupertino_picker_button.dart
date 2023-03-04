import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoPickerButton extends StatelessWidget {

  final child;
  final cupertinoPicker;

  const CupertinoPickerButton({
    super.key,

    required this.child,
    required this.cupertinoPicker
  });
  @override
  Widget build(BuildContext context) {
    return CupertinoButton.filled(
      child: child,
      onPressed: () {
        FocusScope.of(context).unfocus();
        showCupertinoModalPopup(context: context, builder: (context) {
          return Container(
            color: Colors.yellow,
            height: 250,
            width: double.infinity,
            child: cupertinoPicker
          );
        },);
      },
    );
  }
}
