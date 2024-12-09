import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class TGridLayout extends StatelessWidget {
  const TGridLayout({
    super.key,
     required this.itemCount, 
     this.mainAxisExtent = 288,
     required this.itemBuilder,
      this.crossAxisCount=2,
  });


final int itemCount;
final double? mainAxisExtent;
final Widget? Function(BuildContext, int) itemBuilder;
final int crossAxisCount ;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:crossAxisCount,
        mainAxisSpacing: TSizes.gridViewSpacing,
        crossAxisSpacing: TSizes.gridViewSpacing,
         mainAxisExtent: mainAxisExtent,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
