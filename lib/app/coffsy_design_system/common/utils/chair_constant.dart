import '../styles/color_palettes.dart';
import 'sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'images_assets.dart';

class ChairConstant {
  static Widget grey = const GreyChair();
  static Widget red = const RedChair();
  static Widget orange = const OrangeChair();
  static final _whiteDark = const WhiteChairDark();
  static final _whiteLight = const WhiteChairLight();
  static Widget white({bool isDarkTheme = false}) => isDarkTheme ? _whiteLight : _whiteDark;
}

class WhiteChairDark extends StatelessWidget {
  const WhiteChairDark({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Sizes.dp6(context)),
      child: Container(
        decoration: BoxDecoration(
          color: ColorPalettes.white,
          border: Border.all(
            color: ColorPalettes.transparent,
          ),
        ),
        child: SvgPicture.asset(ImagesAssets.chairDark),
      ),
    );
  }
}

class WhiteChairLight extends StatelessWidget {
  const WhiteChairLight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Sizes.dp6(context)),
      child: Container(
        decoration: BoxDecoration(
          color: ColorPalettes.white,
          border: Border.all(
            color: ColorPalettes.grey,
          ),
        ),
        child: SvgPicture.asset(ImagesAssets.chairDark),
      ),
    );
  }
}

class GreyChair extends StatelessWidget {
  const GreyChair({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Sizes.dp6(context)),
      child: Container(
        decoration: BoxDecoration(color: Colors.grey[800]),
        child: SvgPicture.asset(ImagesAssets.chairLight),
      ),
    );
  }
}

class RedChair extends StatelessWidget {
  const RedChair({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Sizes.dp6(context)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red[900],
        ),
        child: SvgPicture.asset(ImagesAssets.chairLight),
      ),
    );
  }
}

class OrangeChair extends StatelessWidget {
  const OrangeChair({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Sizes.dp6(context)),
      child: Container(
        decoration: BoxDecoration(color: ColorPalettes.darkAccent),
        child: SvgPicture.asset(ImagesAssets.chairDark),
      ),
    );
  }
}
