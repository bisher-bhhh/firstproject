part of 'main.dart';



class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) => child;
}

TextTheme getTheme(BuildContext context) => Theme.of(context).textTheme.copyWith(
      displaySmall: Theme.of(context).textTheme.displaySmall?.copyWith(height: Lang.isEn ? null : 1.2),
      displayMedium: Theme.of(context).textTheme.displayMedium?.copyWith(height: Lang.isEn ? null : 1.2),
      displayLarge: Theme.of(context).textTheme.displayLarge?.copyWith(height: Lang.isEn ? null : 1.2),
      titleSmall: Theme.of(context).textTheme.titleSmall?.copyWith(height: Lang.isEn ? null : 1.2),
      titleMedium: Theme.of(context).textTheme.titleMedium?.copyWith(height: Lang.isEn ? null : 1.2),
      titleLarge: Theme.of(context).textTheme.titleLarge?.copyWith(height: Lang.isEn ? null : 1.2),
      bodySmall: Theme.of(context).textTheme.bodySmall?.copyWith(height: Lang.isEn ? null : 1.2),
      bodyMedium: Theme.of(context).textTheme.bodyMedium?.copyWith(height: Lang.isEn ? null : 1.2),
      bodyLarge: Theme.of(context).textTheme.bodyLarge?.copyWith(height: Lang.isEn ? null : 1.2),
      labelSmall: Theme.of(context).textTheme.labelSmall?.copyWith(height: Lang.isEn ? null : 1.2),
      labelMedium: Theme.of(context).textTheme.labelMedium?.copyWith(height: Lang.isEn ? null : 1.2),
      labelLarge: Theme.of(context).textTheme.labelLarge?.copyWith(height: Lang.isEn ? null : 1.2),
    );
