import '../../../../common/component_index.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ImportWebPage extends StatefulWidget {
  ImportWebPage(this.title, this.url);
  final String title;
  final String url;
  @override
  State<StatefulWidget> createState() {
    return new ImportWebPageState();
  }
}

class ImportWebPageState extends State<ImportWebPage> {
  String _webUrl = '';

  @override
  void initState() {
    super.initState();
  }

  Future<File> _getLocalHtmlFile() async {
// 本地文档
    String dir = (await getApplicationDocumentsDirectory()).path;
// 本地文件
    return new File('$dir/${widget.title}.html');
  }

  void _writeDataFile(String data) async {
    File file = await _getLocalHtmlFile();
    File afterFile = await file.writeAsString(data);
    setState(() {
      _webUrl = afterFile.uri.toString();
    });
    print('weburl ==== $_webUrl');
  }

  Widget build(BuildContext context) {
    ImportCardBloc importCardBloc = ImportCardBloc();
    importCardBloc.bloccontext = context;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          '导入${widget.title ?? '银行'}',
          style: TextStyle(fontSize: 18),
        ),
      ),
      backgroundColor: Colors.white,
      body: WebView(
        onWebViewCreated: (WebViewController webViewController) {},
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
