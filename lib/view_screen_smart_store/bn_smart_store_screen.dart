import 'package:flutter/material.dart';
import 'package:smartsstors/model/bn_item.dart';
import 'package:smartsstors/pref/shared_pref_controller.dart';
import 'package:smartsstors/view_screen_smart_store/favorite_screen.dart';
import '../basic_screen/my-home-smart-store.dart';
import 'category_screen.dart';
import 'edit_profile.dart';

class BnSmartStoreScreen extends StatefulWidget {
  const BnSmartStoreScreen(
      {Key? key,
      required this.password,
      required this.phone,
      required this.currentIndex})
      : super(key: key);
  final String password;
  final String phone;
  final int currentIndex;

  @override
  _BnSmartStoreScreenState createState() => _BnSmartStoreScreenState();
}

class _BnSmartStoreScreenState extends State<BnSmartStoreScreen> {
  late int currentState = widget.currentIndex;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Bnitem> _bnItemSmartStore = <Bnitem>[
    Bnitem(
        title: 'home',
        widget: MyHomeSmartStore(
          phone: SharedPrefController().phon,
          password: SharedPrefController().password,
        )),
    Bnitem(
      title: 'Favourite', widget: FavoriteScreen(),
    ),
    Bnitem(title: 'Category', widget: CategoryScreen()),
    Bnitem(title: 'Profile', widget:  const EditProfile()),
  ];

  @override
  Widget build(BuildContext context) {
    bool genderimagemale;
    if (SharedPrefController().gender == 'M') {
      genderimagemale = true;
    } else {
      genderimagemale = false;
    }
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(SharedPrefController().name),
              accountEmail: Text(SharedPrefController().phon),
              currentAccountPicture: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1))
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: genderimagemale
                            ? const NetworkImage(
                                'https://cdn.pixabay.com/photo/2017/04/01/21/06/portrait-2194457_960_720.jpg')
                            : const NetworkImage(
                                'https://cdn.pixabay.com/photo/2018/01/29/17/01/woman-3116587_960_720.jpg'),
                      ))),
              decoration: const BoxDecoration(
                color: Color(0xFFF4E55AF),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2013/07/12/19/04/basket-154317_960_720.png')),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favorites'),
              onTap: () => null,
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Friends'),
              onTap: () => null,
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share'),
              onTap: () => null,
            ),
            const ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Request'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => null,
            ),
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text('Policies'),
              onTap: () => null,
            ),
            const Divider(),
            ListTile(
                title: const Text('Exit'),
                leading: const Icon(Icons.exit_to_app),
                onTap: () {
                  SharedPrefController().clear();
                  Navigator.pushNamed(context, '/loginscreen');
                }),
          ],
        ),
      ),
      appBar: AppBar(
          leadingWidth: 110,
          backgroundColor: const Color(0xFFF4E55AF),
          title: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(_bnItemSmartStore[currentState].title),
          ),
          leading: Row(children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
              child: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.white,
                    )),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset('images/Logo.png')),
              ),
            ),
          ]),
          elevation: 0,
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 16),
                child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/cart_screen');
                    },
                    icon: const Icon(Icons.shopping_cart))),
            const Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(Icons.notifications)),
          ]),
      backgroundColor: Colors.white,
      body: _bnItemSmartStore[currentState].widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int value) {
          setState(() {
            currentState = value;
          });
        },
        //type: BottomNavigationBarType.shifting,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentState,
        // fixedColor: Colors.pink,
        selectedItemColor: const Color(0xFFF4E55AF),
        backgroundColor: Colors.white,
        selectedIconTheme: const IconThemeData(color: Color(0xFFF4E55AF)),
        selectedLabelStyle: const TextStyle(color: Color(0xFFF4E55AF)),
        //بس هاض بغيرش عالكلر غير مرة بدون الاساسيات
        selectedFontSize: 14,
        unselectedItemColor: Colors.grey.shade400,
        unselectedIconTheme: const IconThemeData(color: Colors.grey),
        unselectedFontSize: 12,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        iconSize: 20,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: 'home',
              backgroundColor: Colors.black,
              activeIcon: Icon(Icons.home)),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'favoraite',
              backgroundColor: Colors.pink),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.category,
              ),
              label: 'category',
              backgroundColor: Colors.cyan),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'profile',
              backgroundColor: Colors.deepPurple),
        ],
      ),
    );
  }
}
