import 'package:flutter/material.dart';

class Dialogg extends StatelessWidget {
  const Dialogg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void popUp(BuildContext ctx, String txt1, String txt2, int n) {
    // Alert(
    //   context: ctx,
    //   type: (num == n) ? AlertType.error : AlertType.info,
    //   title: txt1,
    //   desc: txt2,
    //   buttons: [
    //     DialogButton(
    //       child: const Text(
    //         "OK",
    //         style: TextStyle(color: Colors.white, fontSize: 20),
    //       ),
    //       onPressed: () => Navigator.pop(ctx),
    //       width: 120,
    //     )
    //   ],
    // ).show();
  }

  InputDecoration textFieldInputDecoration(String hintText, IconData icon) {
    return InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.black26,
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
        errorStyle: const TextStyle(
          color: Colors.red,
          wordSpacing: 3.0,
        ),
        hintStyle: const TextStyle(letterSpacing: 1.3),
        contentPadding: const EdgeInsets.all(15.0),

        // Inside box padding
        border: OutlineInputBorder(
            gapPadding: 0.0, borderRadius: BorderRadius.circular(15)));
  }
}
