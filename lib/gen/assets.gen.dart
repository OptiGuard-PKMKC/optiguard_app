/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsEnvGen {
  const $AssetsEnvGen();

  /// File path: assets/env/.env.development
  String get aEnvDevelopment => 'assets/env/.env.development';

  /// File path: assets/env/.env.production
  String get aEnvProduction => 'assets/env/.env.production';

  /// File path: assets/env/.env.staging
  String get aEnvStaging => 'assets/env/.env.staging';

  /// List of all assets
  List<String> get values => [aEnvDevelopment, aEnvProduction, aEnvStaging];
}

class $AssetsLangGen {
  const $AssetsLangGen();

  /// File path: assets/lang/en.json
  String get en => 'assets/lang/en.json';

  /// List of all assets
  List<String> get values => [en];
}

class $AssetsLogoGen {
  const $AssetsLogoGen();

  /// File path: assets/logo/X4HicpUi_400x400.jpg
  AssetGenImage get x4HicpUi400x400 =>
      const AssetGenImage('assets/logo/X4HicpUi_400x400.jpg');

  /// File path: assets/logo/apple-logo.png
  AssetGenImage get appleLogo =>
      const AssetGenImage('assets/logo/apple-logo.png');

  /// File path: assets/logo/google-logo.webp
  AssetGenImage get googleLogo =>
      const AssetGenImage('assets/logo/google-logo.webp');

  /// File path: assets/logo/horizontal-black@8x.png
  AssetGenImage get horizontalBlack8x =>
      const AssetGenImage('assets/logo/horizontal-black@8x.png');

  /// File path: assets/logo/horizontal-color-white@8x.png
  AssetGenImage get horizontalColorWhite8x =>
      const AssetGenImage('assets/logo/horizontal-color-white@8x.png');

  /// File path: assets/logo/horizontal-color@8x.png
  AssetGenImage get horizontalColor8x =>
      const AssetGenImage('assets/logo/horizontal-color@8x.png');

  /// File path: assets/logo/horizontal-white@8x.png
  AssetGenImage get horizontalWhite8x =>
      const AssetGenImage('assets/logo/horizontal-white@8x.png');

  /// File path: assets/logo/sponsor.png
  AssetGenImage get sponsor => const AssetGenImage('assets/logo/sponsor.png');

  /// File path: assets/logo/symbol-black@10x.png
  AssetGenImage get symbolBlack10x =>
      const AssetGenImage('assets/logo/symbol-black@10x.png');

  /// File path: assets/logo/symbol-color@10x.png
  AssetGenImage get symbolColor10x =>
      const AssetGenImage('assets/logo/symbol-color@10x.png');

  /// File path: assets/logo/symbol-white@10x.png
  AssetGenImage get symbolWhite10x =>
      const AssetGenImage('assets/logo/symbol-white@10x.png');

  /// File path: assets/logo/vertical-black@6x.png
  AssetGenImage get verticalBlack6x =>
      const AssetGenImage('assets/logo/vertical-black@6x.png');

  /// File path: assets/logo/vertical-color-white@6x.png
  AssetGenImage get verticalColorWhite6x =>
      const AssetGenImage('assets/logo/vertical-color-white@6x.png');

  /// File path: assets/logo/vertical-color@6x.png
  AssetGenImage get verticalColor6x =>
      const AssetGenImage('assets/logo/vertical-color@6x.png');

  /// File path: assets/logo/vertical-white@6x.png
  AssetGenImage get verticalWhite6x =>
      const AssetGenImage('assets/logo/vertical-white@6x.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        x4HicpUi400x400,
        appleLogo,
        googleLogo,
        horizontalBlack8x,
        horizontalColorWhite8x,
        horizontalColor8x,
        horizontalWhite8x,
        sponsor,
        symbolBlack10x,
        symbolColor10x,
        symbolWhite10x,
        verticalBlack6x,
        verticalColorWhite6x,
        verticalColor6x,
        verticalWhite6x
      ];
}

class Assets {
  Assets._();

  static const AssetGenImage appLogo = AssetGenImage('assets/app_logo.png');
  static const AssetGenImage appLogoBak =
      AssetGenImage('assets/app_logo_bak.png');
  static const AssetGenImage avatarExample =
      AssetGenImage('assets/avatar_example.png');
  static const AssetGenImage banner01 = AssetGenImage('assets/banner_01.png');
  static const AssetGenImage banner02 = AssetGenImage('assets/banner_02.png');
  static const $AssetsEnvGen env = $AssetsEnvGen();
  static const $AssetsLangGen lang = $AssetsLangGen();
  static const $AssetsLogoGen logo = $AssetsLogoGen();

  /// List of all assets
  static List<AssetGenImage> get values =>
      [appLogo, appLogoBak, avatarExample, banner01, banner02];
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size = null});

  final String _assetName;

  final Size? size;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
