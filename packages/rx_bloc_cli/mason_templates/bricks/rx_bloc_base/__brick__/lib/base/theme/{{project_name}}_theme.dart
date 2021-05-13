import 'package:flutter/material.dart';

import 'design_system.dart';
import 'design_system/design_system_colors.dart';

class {{#pascalCase}}{{project_name}}{{/pascalCase}}Theme {

  static ThemeData buildTheme(DesignSystem designSystem) {
    final designSystemColor = designSystem.colors;
    final colorSchemeTheme = designSystemColor.brightness == Brightness.light
        ? const ColorScheme.light()
        : const ColorScheme.dark();
    final colorScheme = colorSchemeTheme.copyWith(
      primary: designSystemColor.primaryColor,
      secondary: designSystemColor.secondaryColor,
    );
    final base = designSystemColor.brightness == Brightness.light
        ? ThemeData.light()
        : ThemeData.dark();
    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: designSystemColor.primaryColor,
      buttonColor: designSystemColor.buttonColor,
      indicatorColor: designSystemColor.indicatorColor,
      splashColor: designSystemColor.splashColor,
      splashFactory: InkRipple.splashFactory,
      accentColor: designSystemColor.accentColor,
      canvasColor: designSystemColor.canvasColor,
      backgroundColor: designSystemColor.backgroundColor,
      scaffoldBackgroundColor: designSystemColor.scaffoldBackgroundColor,
      errorColor: designSystemColor.errorColor,
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _buildDesignTextTheme(base.textTheme, designSystemColor),
      primaryTextTheme:
      _buildDesignTextTheme(base.primaryTextTheme, designSystemColor),
      accentTextTheme:
      _buildDesignTextTheme(base.accentTextTheme, designSystemColor),
      appBarTheme: AppBarTheme(
        color: designSystemColor.primaryVariant,
      ),
    );
  }

  static TextTheme _buildDesignTextTheme(
      TextTheme base, DesignSystemColors designSystemColor) {
    const fontName = 'WorkSans';
    return base.copyWith(
      headline1: base.headline1!.copyWith(fontFamily: fontName),
      headline2: base.headline2!.copyWith(fontFamily: fontName),
      headline3: base.headline3!.copyWith(fontFamily: fontName),
      headline4: base.headline4!.copyWith(fontFamily: fontName),
      headline5: base.headline5!.copyWith(fontFamily: fontName),
      headline6: base.headline6!.copyWith(fontFamily: fontName),
      button: base.button!.copyWith(fontFamily: fontName),
      caption: base.caption!.copyWith(fontFamily: fontName),
      bodyText1: base.bodyText1!.copyWith(
      fontFamily: fontName, color: designSystemColor.bodyTextColor1),
      bodyText2: base.bodyText2!.copyWith(
      fontFamily: fontName, color: designSystemColor.bodyTextColor2),
      subtitle1: base.subtitle1!.copyWith(fontFamily: fontName),
      subtitle2: base.subtitle2!.copyWith(fontFamily: fontName),
      overline: base.overline!.copyWith(fontFamily: fontName),
    );
  }

}