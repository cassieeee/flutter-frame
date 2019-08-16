import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/src/asset.dart';
import 'package:youxinbao/res/colors.dart';

class AssetThumbCustom extends StatefulWidget {
  /// The asset we want to show thumb for.
  final Asset asset;

  /// The thumb width
  final int width;

  /// The thumb height
  final int height;

  /// The thumb quality
  final int quality;

  /// This is the widget that will be displayed while the
  /// thumb is loading.
  final Widget spinner;
   final ValueChanged<int> valueChanged;
   final int index;


  const AssetThumbCustom({
    Key key,
    @required this.asset,
    @required this.width,
    @required this.height,
    @required this.valueChanged,
    @required this.index,
    this.quality = 100,
    this.spinner = const Center(
      child: SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(),
      ),
    ),
  }) : super(key: key);

  @override
  _AssetThumbState createState() => _AssetThumbState();
}

class _AssetThumbState extends State<AssetThumbCustom> {
  ByteData _thumbData;

  int get width => widget.width;
  int get height => widget.height;
  int get quality => widget.quality;
  Asset get asset => widget.asset;
  Widget get spinner => widget.spinner;
  ValueChanged<int> get valueChanged => widget.valueChanged;
  int get index=>index;

  @override
  void initState() {
    super.initState();
    this._loadThumb();
  }

  @override
  void didUpdateWidget(AssetThumbCustom oldWidget) {
    if (oldWidget.asset.identifier != widget.asset.identifier) {
      this._loadThumb();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _loadThumb() async {
    setState(() {
      _thumbData = null;
    });

    ByteData thumbData = await asset.requestThumbnail(
      width,
      height,
      quality: quality,
    );

    if (this.mounted) {
      setState(() {
        _thumbData = thumbData;
      });
    }
  }

 void _handleCancel() {
    widget.valueChanged(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    if (_thumbData == null) {
      return spinner;
    }
    return Stack(alignment: Alignment(7.82, -2.92), children: <Widget>[
      Image.memory(
        _thumbData.buffer.asUint8List(),
        key: ValueKey(asset.identifier),
        fit: BoxFit.cover,
        width: double.tryParse('$width'),
        height: double.tryParse('$height'),
        gaplessPlayback: true,
      ),

      // Text('333'),
      MaterialButton(
        height: 20,
        padding: EdgeInsets.all(0),
        onPressed: _handleCancel,
        child: Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colours.orange_72,
            ),
            child: Center(
              child: Text(
                '-',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            )),
      )
    ]);
  }
}
