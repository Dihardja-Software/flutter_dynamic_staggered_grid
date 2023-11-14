library dynamic_staggered_grid;

import 'dart:math';

import 'package:flutter/material.dart';

const maxInteger = 0x7FFFFFFFFFFFFFFF;

class DynamicStaggeredGridView extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final int crossAxisCount;
  final int? mainAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final EdgeInsets? padding;
  final double? itemHeight;

  late final int columnCount;
  late final int rowCount;
  late final int remainder;
  late final int tileCount;

  late final bool altered;

  DynamicStaggeredGridView({
    super.key,
    this.padding,
    required this.crossAxisCount,
    this.mainAxisCount,
    this.crossAxisSpacing = 0,
    this.mainAxisSpacing = 0,
    required this.itemBuilder,
    required this.itemCount,
    this.itemHeight,
  }) {
    columnCount = min(itemCount, crossAxisCount);
    rowCount = min(
      mainAxisCount ?? maxInteger,
      (itemCount ~/ crossAxisCount) +
          ((itemCount.remainder(crossAxisCount) == 0) ? 0 : 1),
    );
    int maxCount =
        mainAxisCount == null ? maxInteger : crossAxisCount * mainAxisCount!;
    remainder = itemCount > maxCount ? 0 : itemCount.remainder(crossAxisCount);
    tileCount = min(maxCount, itemCount);
    altered = rowCount > 1 && remainder != 0;
  }

  Widget column(BuildContext context, int columnIndex) {
    bool isFirstColumn = columnIndex == 0;
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: isFirstColumn ? 0 : crossAxisSpacing),
        child: Column(
          children: List.generate(rowCount, (rowIndex) {
            bool alteredRow = altered && rowIndex == rowCount - 1;

            int skippedAmount = alteredRow ? (columnCount - remainder) : 0;
            int index = columnIndex + ((rowIndex * columnCount));

            if (alteredRow && (index + remainder - skippedAmount) < tileCount) {
              return const SizedBox.shrink();
            }

            int alteredIndex = index - skippedAmount;
            bool isFirstRow = rowIndex == 0;

            return Expanded(
              child: Container(
                margin: EdgeInsets.only(top: isFirstRow ? 0 : mainAxisSpacing),
                child: itemBuilder(context, alteredIndex),
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double innerPadding = (columnCount - 1) * crossAxisSpacing;
    double outerPadding = 2 * (padding?.horizontal ?? 0);
    double itemHeight = this.itemHeight ??
        (MediaQuery.of(context).size.width - innerPadding - outerPadding) /
            columnCount;
    return itemCount != 0
        ? Container(
            padding: padding,
            height: (itemHeight * rowCount),
            child: Row(
              children: List.generate(
                columnCount,
                (columnIndex) => column(context, columnIndex),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
