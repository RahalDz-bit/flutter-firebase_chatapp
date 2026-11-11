import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserTile extends StatelessWidget {
  final String text ;
  final void Function()? ontap;
  new({super.key, required this.text, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
        padding: EdgeInsets.all(10),

        child: Row(
          children: [
            Icon(Icons.person),
            SizedBox(width: 6,),
            Text(text)
          ],
        ),
      ),
    );
  }
}