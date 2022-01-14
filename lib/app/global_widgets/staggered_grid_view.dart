import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// typedef Widget Function(BuildContext context, int index) ItemBuilder();

class CustomStaggeredGridView extends StatelessWidget {
  const CustomStaggeredGridView({
    Key? key,
    required this.total,
    required this.itemBuilder,
    required this.mainAxisCellCount,
  }) : super(key: key);
  final int total;
  final num Function(int index) mainAxisCellCount;
  final Widget Function(BuildContext context, int index) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 12,
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      itemCount: total,
      itemBuilder: (context, index) {
        return StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: mainAxisCellCount(index),
          child: itemBuilder(context, index),
        );
      },
    );
  }
}
