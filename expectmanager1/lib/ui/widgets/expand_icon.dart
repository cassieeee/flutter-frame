// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import 'package:flutter/src/material/colors.dart';
import 'package:flutter/src/material/debug.dart';
import 'package:flutter/src/material/icon_button.dart';
import 'package:flutter/src/material/icons.dart';
import 'package:flutter/src/material/material_localizations.dart';
import 'package:flutter/src/material/theme.dart';

/// A widget representing a rotating expand/collapse button. The icon rotates
/// 180 deg when pressed, then reverts the animation on a second press.
/// The underlying icon is [Icons.expand_more].
///
/// The expand icon does not include a semantic label for accessibility. In
/// order to be accessible it should be combined with a label using
/// [MergeSemantics]. This is done automatically by the [ExpansionPanel] widget.
///
/// See [IconButton] for a more general implementation of a pressable button
/// with an icon.
class ExpandIconCustom extends StatefulWidget {
  /// Creates an [ExpandIconCustom] with the given padding, and a callback that is
  /// triggered when the icon is pressed.
  const ExpandIconCustom({
    Key key,
    this.isExpanded = false,
    this.size = 24.0,
    this.parms=const{'type':'default','backgroudcolor':0xffffffff,'iconcolor':0xff212121,'iconsize':24},
    @required this.onPressed,
    this.padding = const EdgeInsets.all(0)
  }) : assert(isExpanded != null),
       assert(size != null),
       assert(parms != null),
       assert(padding != null),
       super(key: key);

  /// Whether the icon is in an expanded state.
  ///
  /// Rebuilding the widget with a different [isExpanded] value will trigger
  /// the animation, but will not trigger the [onPressed] callback.
  final bool isExpanded;

  /// The size of the icon.
  ///
  /// This property must not be null. It defaults to 24.0.
  final double size;

  final Map parms;

  /// The callback triggered when the icon is pressed and the state changes
  /// between expanded and collapsed. The value passed to the current state.
  ///
  /// If this is set to null, the button will be disabled.
  final ValueChanged<bool> onPressed;

  /// The padding around the icon. The entire padded icon will react to input
  /// gestures.
  ///
  /// This property must not be null. It defaults to 8.0 padding on all sides.
  final EdgeInsetsGeometry padding;

  @override
  _ExpandIconCustomState createState() => _ExpandIconCustomState();
}

class _ExpandIconCustomState extends State<ExpandIconCustom> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _iconTurns;

  static final Animatable<double> _iconTurnTween = Tween<double>(begin: 0.0, end: 0.5)
    .chain(CurveTween(curve: Curves.fastOutSlowIn));

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: kThemeAnimationDuration, vsync: this);
    _iconTurns = _controller.drive(_iconTurnTween);
    // If the widget is initially expanded, rotate the icon without animating it.
    if (widget.isExpanded) {
      _controller.value = math.pi;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ExpandIconCustom oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      if (widget.isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  void _handlePressed() {
    if (widget.onPressed != null)
      widget.onPressed(widget.isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final ThemeData theme = Theme.of(context);
    final String onTapHint = widget.isExpanded ? localizations.expandedIconTapHint : localizations.collapsedIconTapHint;

    return Semantics(
      onTapHint: widget.onPressed == null ? null : onTapHint,
      child: IconButton(
        padding: widget.padding,
        color: Color(widget.parms['iconcolor']),
        onPressed: widget.onPressed == null ? null : _handlePressed,
        icon: RotationTransition(
          turns: _iconTurns,
          child: widget.parms['type']=='default'? Icon(Icons.expand_more):Icon(Icons.arrow_drop_down,size: widget.parms['iconsize'],)
        ),
      ),
    );
  }
}
