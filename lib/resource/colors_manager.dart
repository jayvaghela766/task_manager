import 'package:flutter/material.dart';

class ColorManager {
  //primary color
  static Color primary = HexColor.fromHex("#173FCC");
  static Color primaryOpacity10 = HexColor.fromHex("#10173FCC");
  static Color primaryOpacity20 = HexColor.fromHex("#20617EEB");
  static Color primaryOpacity30 = HexColor.fromHex("#30617EEB");

  //secondary color
  static Color secondary = HexColor.fromHex("#001957");
  static Color secondaryOpacity95 = HexColor.fromHex("#95001957");
  static Color secondaryOpacity50 = HexColor.fromHex("#50001957");
  static Color secondaryOpacity40 = HexColor.fromHex("#40001957");
  static Color secondaryOpacity20 = HexColor.fromHex("#20001957");

  static Color colorBlue = HexColor.fromHex("#617EEB");
  static Color colorGradient1 = HexColor.fromHex("#2A50DF");
  static Color colorGradient2 = HexColor.fromHex("#112D98");
  static Color colorWhite = HexColor.fromHex("#ffffff");
  static Color colorGrey = HexColor.fromHex("#807D7D");
  static Color colorGrey1 = HexColor.fromHex("#A6A6A6");
  static Color colorBorder = HexColor.fromHex("#30112D98");
  static Color colorGreen = HexColor.fromHex("#00A53D");
  static Color colorBlack = HexColor.fromHex("#000000");
  static Color colorOrange = HexColor.fromHex("#DF8C2A");
  static Color colorOrangeLight = HexColor.fromHex("#EFA051");
  static Color colorYellow = HexColor.fromHex("#FED505");
  static Color colorCylindrical = HexColor.fromHex("#6B8AFD");
  static Color colorCylindricalLight = HexColor.fromHex("#8BA1F6");
  static Color colorYellowDark = HexColor.fromHex("#EEC80A");
  static Color colorDescriptionText = HexColor.fromHex("#7A7E89");
  static Color colorContentText = HexColor.fromHex("#0B3757");
  static Color colorHeadingText = HexColor.fromHex("#001B41");
  static Color colorOffWhiteShadow = HexColor.fromHex("#F6F6F6");
  static Color colorGreyText = HexColor.fromHex("#7C818A");
  static Color colorShadowDropDown = HexColor.fromHex("#D7D3CB");
  static Color colorUIBackground = HexColor.fromHex("#F8F8FC");

  static Color colorLiteGreenBackground = HexColor.fromHex("#E8F0EF");
  static Color colorLiteYellowBackground = HexColor.fromHex("#FFF0D4");
  static Color primaryButtonOpacity10 = HexColor.fromHex("#10FFB627");
  static Color colorLightBlue = HexColor.fromHex("#17A1CC");
  static Color colorSkyBlue = HexColor.fromHex("#1FE1ED");
  static Color colorDarkBlue = HexColor.fromHex("#0987AA");
  static Color colorLightSky = HexColor.fromHex("#4AC8E1");
  static Color colorDarkPink = HexColor.fromHex("#C36F73");


}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
