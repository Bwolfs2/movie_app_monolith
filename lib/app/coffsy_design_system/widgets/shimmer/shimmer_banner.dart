import '../../common/styles/color_palettes.dart';
import '../../common/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBanner extends StatelessWidget {
  const ShimmerBanner();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Shimmer.fromColors(
        baseColor: ColorPalettes.greyBg,
        highlightColor: ColorPalettes.white,
        child: Column(
          children: [
            Container(
              height: Sizes.width(context) / 2,
              width: Sizes.width(context),
              decoration: BoxDecoration(
                color: ColorPalettes.greyBg,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: Sizes.width(context) / 3,
                  height: Sizes.dp8(context),
                  margin: EdgeInsets.symmetric(
                    vertical: Sizes.dp10(context),
                    horizontal: 2.0,
                  ),
                  color: ColorPalettes.greyBg,
                ),
                const Spacer(),
                Container(
                  height: Sizes.dp8(context),
                  width: Sizes.width(context) / 8,
                  color: ColorPalettes.greyBg,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
