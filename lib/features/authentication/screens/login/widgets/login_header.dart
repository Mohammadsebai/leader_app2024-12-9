import 'package:flutter/material.dart';
import 'package:leader_app/utils/constants/image_strings.dart';
import 'package:leader_app/utils/constants/text_strings.dart';


import '../../../../../../utils/constants/sizes.dart';

class TLoginHeader extends StatelessWidget {
  const TLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Image(height: 150, image: AssetImage(TImages.logoMe)),
        ),
        Text(TTexts.titleLogin,
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(
          height: TSizes.sm,
        ),
        Text(TTexts.subTitleLogin,
            style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
