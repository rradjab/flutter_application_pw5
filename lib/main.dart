import 'package:flutter/material.dart';
import 'package:flutter_application_pw5/tab_item.dart';

List<TabItem> _tabItems = [
  TabItem(title: 'title', icon: const Icon(Icons.abc)),
  TabItem(title: 'title', icon: const Icon(Icons.abc)),
  TabItem(title: 'title', icon: const Icon(Icons.abc)),
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MaterialExample(),
    );
  }
}

class MaterialExample extends StatefulWidget {
  const MaterialExample({super.key});

  @override
  State<MaterialExample> createState() => _MaterialExampleState();
}

class _MaterialExampleState extends State<MaterialExample>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  PersistentBottomSheetController? _controller;
  late TabController _tabController;
  int _currentTabIndex = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabItems.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void toggleBotSheet() {
    if (_controller == null) {
      _controller = scaffoldKey.currentState?.showBottomSheet(
        (context) => Container(
          color: Colors.cyanAccent,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: () {}, child: const Text('Сумма')),
                  const Text('200 руб'),
                ],
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {}, child: const Text('Оплатить')),
              )
            ],
          ),
        ),
      );
    } else {
      _controller?.close();
      _controller = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Material Example'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_rounded),
            onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
          ),
        ],
      ),
      body: TabBarView(controller: _tabController, children: [
        Container(
          color: Colors.white,
          child: const Center(
            child: Text('1'),
          ),
        ),
        Container(
          color: Colors.blueAccent,
          child: const Center(
            child: Text('2'),
          ),
        ),
        Container(
          color: Colors.red,
          child: const Center(
            child: Text('3'),
          ),
        ),
      ]),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              child: CircleAvatar(
                radius: 60,
                foregroundImage: NetworkImage('https://picsum.photos/777'),
                child: Text('AA'),
              ),
            ),
            ListTile(
              onTap: () => debugPrint('Profile Tapped'),
              title: const Text('Profile'),
              leading: const Icon(Icons.home),
              trailing: const Icon(Icons.arrow_forward),
            ),
            ListTile(
              onTap: () => debugPrint('Images Tapped'),
              title: const Text('Images'),
              leading: const Icon(Icons.person),
              trailing: const Icon(Icons.arrow_forward),
            ),
            ListTile(
              onTap: () => debugPrint('Files Tapped'),
              title: const Text('Files'),
              leading: const Icon(Icons.picture_in_picture),
              trailing: const Icon(Icons.arrow_forward),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Вход'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Регистрация'),
                ),
              ],
            )
          ],
        ),
      ),
      endDrawer: const Drawer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                foregroundImage: NetworkImage('https://picsum.photos/777'),
              ),
              Text('UserName'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 90,
        shape: const CircularNotchedRectangle(),
        elevation: 0,
        notchMargin: 8,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          elevation: 0,
          onTap: (value) {
            _tabController.index = value;
            _currentTabIndex = value;
          },
          currentIndex: _currentTabIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.photo),
              label: 'Photo',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.album_rounded),
              label: 'Albums',
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        clipBehavior: Clip.antiAlias,
        onPressed: () => toggleBotSheet(),
        shape: const OvalBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
