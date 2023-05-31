import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterChips extends StatelessWidget {
  const FilterChips({Key? key, required this.labels}) : super(key: key);
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: labels
          .map((e) => FilterChip(
                label: Text(e),
                onSelected: (value) {},
              ))
          .toList(),
    );
  }
}
