import 'package:flutter/material.dart';
class Widgets {
  final context;

  Widgets(this.context);

  Widget okButtonWidget(){
    return ElevatedButton(
      style: const ButtonStyle(
          backgroundColor:MaterialStatePropertyAll(Colors.red)
      ),
      onPressed: ()=> Navigator.pop(context),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          color: Colors.red,

        ),
        child: Text('OK', style: TextStyle(color: Colors.white)),
      ),

    );
  }
}