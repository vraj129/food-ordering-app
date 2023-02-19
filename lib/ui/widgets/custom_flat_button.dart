import 'package:flutter/material.dart';

class CustomFlatButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;

  const CustomFlatButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      child: Container(
        height: 54,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.button?.copyWith(fontSize: 18.0, color: Colors.white),
        ),
      ),
    );
  }
}
