import 'package:flutter/material.dart';

class ContainerBorde extends StatelessWidget {
  final Widget? child;
  const ContainerBorde({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128.0,
      margin: const EdgeInsets.symmetric(horizontal: 32.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.0),
        border: Border.all(
          color: Colors.blue,
          width: 2.0,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22.0),
        child: child,
      ),
    );
  }
}
