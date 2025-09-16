import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;

  const StyledButton({
    super.key, 
    required this.onPressed,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.deepPurple[200],
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 20),
          minimumSize: const Size(60, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: child,
      )
    );
  }
}
