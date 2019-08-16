// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'expand_icon.dart';
import 'package:flutter/src/material/mergeable_material.dart';
import 'package:flutter/src/material/theme.dart';

const double _kPanelHeaderCollapsedHeight = 48.0;
const double _kPanelHeaderExpandedHeight = 64.0;

class _SaltedKey<S, V> extends LocalKey {
  const _SaltedKey(this.salt, this.value);

  final S salt;
  final V value;

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    final _SaltedKey<S, V> typedOther = other;
    return salt == typedOther.salt && value == typedOther.value;
  }

  @override
  int get hashCode => hashValues(runtimeType, salt, value);

  @override
  String toString() {
    final String saltString = S == String ? '<\'$salt\'>' : '<$salt>';
    final String valueString = V == String ? '<\'$value\'>' : '<$value>';
    return '[$saltString $valueString]';
  }
}

/// Signature for the callback that's called when an [ExpansionPanelCustom] is
/// expanded or collapsed.
///
/// The position of the panel within an [ExpansionPanelCustomList] is given by
/// [panelIndex].
typedef ExpansionPanelCustomCallback = void Function(
    int panelIndex, bool isExpanded);

/// Signature for the callback that's called when the header of the
/// [ExpansionPanelCustom] needs to rebuild.
typedef ExpansionPanelCustomHeaderBuilder = Widget Function(
    BuildContext context, bool isExpanded);

/// A material expansion panel. It has a header and a body and can be either
/// expanded or collapsed. The body of the panel is only visible when it is
/// expanded.
///
/// Expansion panels are only intended to be used as children for
/// [ExpansionPanelCustomList].
///
/// See also:
///
///  * [ExpansionPanelCustomList]
///  * <https://material.io/design/components/lists.html#types>
class ExpansionPanelCustom {
  /// Creates an expansion panel to be used as a child for [ExpansionPanelCustomList].
  ///
  /// The [headerBuilder], [body], and [isExpanded] arguments must not be null.
  ExpansionPanelCustom(
      {@required this.headerBuilder,
      @required this.body,
      this.parms = const {
        'type': 'default',
        'backgroudcolor': 0xffffffff,
        'iconcolor': 0xff212121,
        'iconsize':24,
      },
      this.isExpanded = false})
      : assert(headerBuilder != null),
        assert(body != null),
        assert(parms != null),
        assert(isExpanded != null);

  /// The widget builder that builds the expansion panels' header.
  final ExpansionPanelCustomHeaderBuilder headerBuilder;

  /// The body of the expansion panel that's displayed below the header.
  ///
  /// This widget is visible only when the panel is expanded.
  final Widget body;

  /// Whether the panel is expanded.
  ///
  /// Defaults to false.
  final bool isExpanded;

  final Map parms;
}

/// An expansion panel that allows for radio-like functionality.
///
/// A unique identifier [value] must be assigned to each panel.
class ExpansionPanelCustomRadio extends ExpansionPanelCustom {
  /// An expansion panel that allows for radio functionality.
  ///
  /// A unique [value] must be passed into the constructor. The
  /// [headerBuilder], [body], [value] must not be null.
  ExpansionPanelCustomRadio({
    @required this.value,
    @required ExpansionPanelCustomHeaderBuilder headerBuilder,
    @required Widget body,
  })  : assert(value != null),
        super(body: body, headerBuilder: headerBuilder);

  /// The value that uniquely identifies a radio panel so that the currently
  /// selected radio panel can be identified.
  final Object value;
}

/// A material expansion panel list that lays out its children and animates
/// expansions.
///
/// See also:
///
///  * [ExpansionPanelCustom]
///  * <https://material.io/design/components/lists.html#types>
class ExpansionPanelCustomList extends StatefulWidget {
  /// Creates an expansion panel list widget. The [expansionCallback] is
  /// triggered when an expansion panel expand/collapse button is pushed.
  ///
  /// The [children] and [animationDuration] arguments must not be null.
  const ExpansionPanelCustomList({
    Key key,
    this.children = const <ExpansionPanelCustom>[],
    this.expansionCallback,
    this.animationDuration = kThemeAnimationDuration,
    this.parms = const {
      'type': 'default',
      'backgroudcolor': '0xffffffff',
      'iconcolor': 0xff212121,
      'iconsize':24,
    },
  })  : assert(children != null),
        assert(animationDuration != null),
        assert(parms != null),
        _allowOnlyOnePanelOpen = false,
        initialOpenPanelValue = null,
        super(key: key);

  /// Creates a radio expansion panel list widget.
  ///
  /// This widget allows for at most one panel in the list to be open.
  /// The expansion panel callback is triggered when an expansion panel
  /// expand/collapse button is pushed. The [children] and [animationDuration]
  /// arguments must not be null. The [children] objects must be instances
  /// of [ExpansionPanelCustomRadio].
  const ExpansionPanelCustomList.radio({
    Key key,
    this.children = const <ExpansionPanelCustomRadio>[],
    this.expansionCallback,
    this.animationDuration = kThemeAnimationDuration,
    this.initialOpenPanelValue,
    this.parms = const {
      'type': 'default',
      'backgroudcolor': '0xffffffff',
      'iconcolor': 0xff212121,
      'iconsize':24,
    },
  })  : assert(children != null),
        assert(animationDuration != null),
        assert(parms != null),
        _allowOnlyOnePanelOpen = true,
        super(key: key);

  /// The children of the expansion panel list. They are laid out in a similar
  /// fashion to [ListBody].
  final List<ExpansionPanelCustom> children;

  /// The callback that gets called whenever one of the expand/collapse buttons
  /// is pressed. The arguments passed to the callback are the index of the
  /// to-be-expanded panel in the list and whether the panel is currently
  /// expanded or not.
  ///
  /// This callback is useful in order to keep track of the expanded/collapsed
  /// panels in a parent widget that may need to react to these changes.
  final ExpansionPanelCustomCallback expansionCallback;

  /// The duration of the expansion animation.
  final Duration animationDuration;

  // Whether multiple panels can be open simultaneously
  final bool _allowOnlyOnePanelOpen;

  /// The value of the panel that initially begins open. (This value is
  /// only used when initializing with the [ExpansionPanelCustomList.radio]
  /// constructor.)
  final Object initialOpenPanelValue;

  final Map parms;

  @override
  State<StatefulWidget> createState() => _ExpansionPanelCustomListState();
}

class _ExpansionPanelCustomListState extends State<ExpansionPanelCustomList> {
  ExpansionPanelCustomRadio _currentOpenPanel;

  @override
  void initState() {
    super.initState();
    if (widget._allowOnlyOnePanelOpen) {
      assert(_allIdentifiersUnique(), 'All object identifiers are not unique!');
      for (ExpansionPanelCustomRadio child in widget.children) {
        if (widget.initialOpenPanelValue != null &&
            child.value == widget.initialOpenPanelValue)
          _currentOpenPanel = child;
      }
    }
  }

  @override
  void didUpdateWidget(ExpansionPanelCustomList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget._allowOnlyOnePanelOpen) {
      assert(_allIdentifiersUnique(), 'All object identifiers are not unique!');
      for (ExpansionPanelCustomRadio newChild in widget.children) {
        if (widget.initialOpenPanelValue != null &&
            newChild.value == widget.initialOpenPanelValue)
          _currentOpenPanel = newChild;
      }
    } else if (oldWidget._allowOnlyOnePanelOpen) {
      _currentOpenPanel = null;
    }
  }

  bool _allIdentifiersUnique() {
    final Map<Object, bool> identifierMap = <Object, bool>{};
    for (ExpansionPanelCustomRadio child in widget.children) {
      identifierMap[child.value] = true;
    }
    return identifierMap.length == widget.children.length;
  }

  bool _isChildExpanded(int index) {
    if (widget._allowOnlyOnePanelOpen) {
      final ExpansionPanelCustomRadio radioWidget = widget.children[index];
      return _currentOpenPanel?.value == radioWidget.value;
    }
    return widget.children[index].isExpanded;
  }

  void _handlePressed(bool isExpanded, int index) {
    if (widget.expansionCallback != null)
      widget.expansionCallback(index, isExpanded);

    if (widget._allowOnlyOnePanelOpen) {
      final ExpansionPanelCustomRadio pressedChild = widget.children[index];

      for (int childIndex = 0;
          childIndex < widget.children.length;
          childIndex += 1) {
        final ExpansionPanelCustomRadio child = widget.children[childIndex];
        if (widget.expansionCallback != null &&
            childIndex != index &&
            child.value == _currentOpenPanel?.value)
          widget.expansionCallback(childIndex, false);
      }
      _currentOpenPanel = isExpanded ? null : pressedChild;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<MergeableMaterialItem> items = <MergeableMaterialItem>[];
    const EdgeInsets kExpandedEdgeInsets = EdgeInsets.symmetric(
        vertical: _kPanelHeaderExpandedHeight - _kPanelHeaderCollapsedHeight);

    for (int index = 0; index < widget.children.length; index += 1) {
      if (_isChildExpanded(index) && index != 0 && !_isChildExpanded(index - 1))
        items.add(MaterialGap(
            key: _SaltedKey<BuildContext, int>(context, index * 2 - 1)));

      final ExpansionPanelCustom child = widget.children[index];
      final Container header = Container(
        decoration: BoxDecoration(
          color: Color(widget.parms['backgroundcolor']),
            borderRadius: BorderRadius.vertical(
              top: Radius.elliptical(5, 5))
              ),
        
        // margin: EdgeInsets.only(right: 20, left: 20),
        child: Row(
          children: <Widget>[
            Expanded(
              child: AnimatedContainer(
                duration: widget.animationDuration,
                curve: Curves.fastOutSlowIn,
                margin: widget.parms['type'] == 'default'
                    ? (_isChildExpanded(index)
                        ? kExpandedEdgeInsets
                        : EdgeInsets.zero)
                    : EdgeInsets.zero,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                      minHeight: _kPanelHeaderCollapsedHeight),
                  child: child.headerBuilder(
                    context,
                    _isChildExpanded(index),
                  ),
                ),
              ),
            ),
            Container(
              
              // color: Color(0xffff7200),
              // margin: const EdgeInsetsDirectional.only(end: 8.0),
              child: ExpandIconCustom(
                parms: widget.parms,
                isExpanded: _isChildExpanded(index),
                padding: const EdgeInsets.all(0),
                onPressed: (bool isExpanded) =>
                    _handlePressed(isExpanded, index),
              ),
            ),
          ],
        ),
      );

      items.add(
        MaterialSlice(
          key: _SaltedKey<BuildContext, int>(context, index * 2),
          child: Column(
            children: <Widget>[
              MergeSemantics(child: header),
              AnimatedCrossFade(
                firstChild: Container(height: 0.0),
                secondChild: child.body,
                firstCurve:
                    const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
                secondCurve:
                    const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
                sizeCurve: Curves.fastOutSlowIn,
                crossFadeState: _isChildExpanded(index)
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: widget.animationDuration,
              ),
            ],
          ),
        ),
      );

      if (_isChildExpanded(index) && index != widget.children.length - 1)
        items.add(MaterialGap(
            key: _SaltedKey<BuildContext, int>(context, index * 2 + 1)));
    }

    return MergeableMaterial(
      hasDividers: true,
      children: items,
    );
  }
}
