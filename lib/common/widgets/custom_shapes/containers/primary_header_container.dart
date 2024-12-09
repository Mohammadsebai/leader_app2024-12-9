import 'package:flutter/material.dart';
import 'package:leader_app/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:leader_app/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../utils/theme/custom_themes/app_colors.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key,
    required this.child,
      this.color= TColors.PrimaryColor,
  });
  final Widget child;
  final Color  color;
  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWidget(
      child: Container(
      color:color,
      
        ///--[size.isFinite : is not true] Error README.md file at [DESIGN ERRORS] # 1
        child: Stack(
          children: [
            ///-- Background Custom Shapes
            Positioned(
                top: -150,
                right: -250,
                child: TCircularContainer(
                  backgroundColor: TColors.TextWhiteColor.withOpacity(0.1),
                )),
            Positioned(
                top: 100,
                right: -300,
                child: TCircularContainer(
                  backgroundColor: TColors.TextWhiteColor.withOpacity(0.1),
                )),
            child,
          ],
        ),
      ),
    );
  }
}
