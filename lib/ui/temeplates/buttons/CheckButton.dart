import 'package:buyandship_demo/configs/MyColors.dart';
import 'package:flutter/material.dart';

//開關變色的button
class CheckButton extends StatelessWidget {

  final bool isSelect;
  final void Function()? onPressed;
  final Widget child;

  const CheckButton(this.child, {super.key, this.isSelect=false, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style:  OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          minimumSize: Size.zero,
          backgroundColor: isSelect ? MyColors.primary : Colors.transparent,
          foregroundColor: isSelect ? MyColors.text_darkbg : MyColors.primary,
          side: BorderSide(
            color: MyColors.primary,
            width: 1.5
          )
        ),
        onPressed: onPressed,
        child: child
    );
  }
}