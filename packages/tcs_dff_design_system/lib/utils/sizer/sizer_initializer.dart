part of app_sizer;

/* Provides `Context`, `Orientation`, and `ScreenType` 
parameters to the builder function*/
typedef ResponsiveBuild = Widget Function(
  BuildContext,
  Orientation,
  ScreenType,
);

/// A widget that gets the device's details like orientation and constraints
///
/// Usage: Wrap MaterialApp with this widget
class AppSizer extends StatelessWidget {
  const AppSizer({super.key, required this.builder});

  /// Builds the widget whenever the orientation changes
  final ResponsiveBuild builder;

  @override
  Widget build(final BuildContext context) => LayoutBuilder(
        builder: (final context, final constraints) => OrientationBuilder(
          builder: (final context, final orientation) {
            Device.setScreenConfiguration(constraints, orientation, context);
            return builder(context, orientation, Device.screenType);
          },
        ),
      );
}
