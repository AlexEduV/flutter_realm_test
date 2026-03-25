import 'package:flutter/cupertino.dart';

class SkipWidget extends StatelessWidget {
  final bool skip;
  final Widget child;

  const SkipWidget({required this.skip, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    if (!skip) return child;

    // If skip is true, try to extract the children of the child
    // This only works if child is a MultiChildRenderObjectWidget (like Column, Row, Stack, etc.)
    if (child is MultiChildRenderObjectWidget) {
      final multiChild = child as MultiChildRenderObjectWidget;
      return Column(children: multiChild.children);
    }

    // If child is a SingleChildRenderObjectWidget, extract its child
    if (child is SingleChildRenderObjectWidget) {
      final singleChild = child as SingleChildRenderObjectWidget;
      return singleChild.child ?? const SizedBox.shrink();
    }

    // Otherwise, just remove the child
    return const SizedBox.shrink();
  }
}
