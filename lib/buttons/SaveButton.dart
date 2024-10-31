import 'package:flutter/material.dart';



class SaveButton extends StatefulWidget {
  //declare var, string and pass int, string if you want:  Function(int)...

  final Function() onPressed;
  final String text;
  final Size? fixedSize;
  final Size? maximumSize;
  final bool isLoading;
  final bool isActive;
  //constructor
  const SaveButton({Key? key, required this.onPressed,  required this.text, this.fixedSize, this.maximumSize,
    this.isLoading = false, this.isActive = true}) : super(key: key);

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {

  @override
  Widget build( BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8),
      child: ElevatedButton(
        onPressed: (){
          widget.onPressed.call();
         },
          style: ElevatedButton.styleFrom(
              fixedSize: widget.fixedSize,
            maximumSize: widget.maximumSize,
            backgroundColor: widget.isActive ? Colors.deepOrange : Colors.deepOrange.shade100,
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
            ),
          ),
        child: Text( widget.text.toUpperCase(),
          style: TextStyle(
            color: Colors.white
          ),
        )
      )
    );
  }
}
