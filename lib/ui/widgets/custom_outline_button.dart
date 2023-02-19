import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget icon;
  final Size size;
  final String text;

  const CustomOutlineButton({
    super.key,
    required this.text,
    required this.icon,
    required this.size,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 0,
        side: const BorderSide(color: Colors.black)
      ),
      child: Container(
        height: 54,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 10,),
            Text(
              text,
              style: Theme.of(context).textTheme.caption?.copyWith(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w200,
                    color: Colors.black,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
