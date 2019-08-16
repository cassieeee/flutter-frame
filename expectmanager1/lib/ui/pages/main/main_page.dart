import '../../../common/component_index.dart';
import '../../../ui/pages/page_index.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex;
  List<Widget> _pages;
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _pages = [
      CreditCardPage(),
      MinePage(),
    ];
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // AppInstance.initContext = context;
    return Scaffold(
      body: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: _pageChange,
          controller: _controller,
          itemCount: _pages.length,
          itemBuilder: (context, index) => _pages[index]),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.credit_card,
                color: Colours.text_placehold2,
              ),
              activeIcon: Icon(
                Icons.credit_card,
                color: Colours.blue_color,
              ),
              title: Text(
                '信用卡',
              ),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colours.text_placehold2,
            ),
            activeIcon: Icon(
              Icons.person,
              color: Colours.blue_color,
            ),
            title: Text(
              '我的',
            ),
          ),
        ],
        currentIndex: _currentIndex,
        onTap: onTap,
      ),
    );
  }

  void onTap(int index) {
    _controller.jumpToPage(index);
  }

  void _pageChange(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
    }
  }
}
