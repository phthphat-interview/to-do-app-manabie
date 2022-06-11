part of './view.dart';

///Minimum size, stretch alignment column
class MinSizeStretchColumn extends Column {
  MinSizeStretchColumn({
    Key? key,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.stretch,
    MainAxisSize mainAxisSize = MainAxisSize.min,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
    List<Widget> children = const [],
  }) : super(
          key: key,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisSize: mainAxisSize,
          mainAxisAlignment: mainAxisAlignment,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
          textBaseline: textBaseline,
          children: children,
        );
}
