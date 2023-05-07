import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:mobile_app_library/ContentPage/NavigationDrawer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/authentication.dart';

class Content_Home_Page extends StatefulWidget {
  @override
  _Content_Home_PageState createState() => _Content_Home_PageState();
}

class _Content_Home_PageState extends State<Content_Home_Page> {
  @override
  void initState()
  {
    super.initState();
    _initLocationServices();

  }
  int _selectedIndex = 0;

  static  final List<Widget> _widgetOptions = <Widget>[
    // pages
     Home(),
    SearchPage(),
    ReelsPage(),
    NotificationsPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children: _widgetOptions,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.newspaper),
                label: 'News',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Notifications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

Future<void> _initLocationServices()async {
    var location = Location();
    if(!await location.serviceEnabled())
    {
      if(!await location.requestService())
      {
        return;
      }
    }
    var permission = await location.hasPermission();
    if(permission==PermissionStatus.denied)
    {
      permission=await location.requestPermission();
      if(permission == PermissionStatus.granted)
      {
        return;
      }
    }
    var loc =await location.getLocation();
    Fluttertoast.showToast(msg: '${loc.latitude} ${loc.longitude}');
  }


// Home pages
class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User? user = FirebaseAuth.instance.currentUser;

  UserModelOne loggedInUser = UserModelOne();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value){
      loggedInUser= UserModelOne.fromMap(value.data());
      setState((){});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer :const navigation_Drawer(),
      appBar: AppBar(
        title: const Text('Kibabii Mobile Library'),
        backgroundColor: Colors.orange[800],
        leading: null,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Welcome,${loggedInUser.firstName} ${loggedInUser.surName}!',
              style:const  TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                HomeGridItem(
                  title: 'Search',
                  icon: Icons.search,
                  onTap: () {
                    Navigator.pushReplacementNamed(context,'search');
                  },

                ),
                HomeGridItem(
                  title: 'Notifications',
                  icon: Icons.notifications,
                  onTap: () {
                    Navigator.pushReplacementNamed(context,'notification');
                  },
                ),
                HomeGridItem(
                  title: 'Profile',
                  icon: Icons.person,
                  onTap: () {
                   Navigator.pushReplacementNamed(context,'profile');
                  },
                ),
                HomeGridItem(
                  title: 'Favourite Books',
                  icon: Icons.favorite,
                  onTap: () {
                    Navigator.pushReplacementNamed(context, 'favouriteBooks');
                  },
                ),
                HomeGridItem(
                  title: 'Borrowed Books',
                  icon: Icons.library_books,
                  onTap: () {
                    Navigator.pushReplacementNamed(context, 'borrowedBooks');
                  },
                ),
                HomeGridItem(
                  title: 'Books',
                  icon: Icons.book_online,
                  onTap: () {
                    Navigator.pushReplacementNamed(context,'historyOfBooks');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeGridItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const HomeGridItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
    //required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//searchPage
class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> authors = [
  'Ebby Nasiali',
  'Vincent Nick Otuma ',
  'Matui Saleh Nawaji',
  'Mumbwani Evans Maruti',
  'Eric Ries',
  'Distance Education Learners Support Services',
  'Daniel Kahneman',
  'Yuval Noah Harari',
  'Charlotte Bronte',
  'George Orwell',
  'J.K. Rowling',
  'Harper Lee',
  'Agatha Christie',
    'To Kill a Mockingbird',


  ];
  String query = '';
  List<String> get filteredAuthors {
    return authors.where((author) => author.toLowerCase().contains(query.toLowerCase())).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pushReplacementNamed(context,'trial');
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search Books',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
             TextField(
               onChanged: (value) {
                 setState(() {
                   query = value;
                 });
               },
              decoration: const InputDecoration(
                hintText: 'Enter book title or author name',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Search Results',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredAuthors.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredAuthors[index]),
                  );
                },
            ),
            )
          ],
        ),
      ),
    );
  }
}
//news page
class ReelsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App launcher
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:  [
                    GestureDetector(
                        child: const Icon(Icons.email),
                    onTap: (){openMail();},),
                    GestureDetector(child: const Icon(Icons.message),
                    onTap: ()
                    {
                      whatsApp();
                    },),
                    GestureDetector(
                        child: const Icon(Icons.phone),
                      onTap: ()
                      {
                        launchUrl(
                            Uri.parse('tel:+254704858069')
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // News feed
                const Text(
                  'News Feed',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ListView(
                  shrinkWrap: true,
                  children: const [
                    ListTile(
                      leading: Icon(Icons.sports),
                      title: Text('Latest Books'),
                      subtitle: Text('We have a new C++ tutorial book arriving today.'),
                    ),
                    ListTile(
                      leading: Icon(Icons.movie),
                      title: Text('Entertainment News'),
                      subtitle: Text('Latest school function for students'),
                    ),
                    ListTile(
                      leading: Icon(Icons.gavel),
                      title: Text('Soku Political News'),
                      subtitle: Text('We are glad to announce that Dennis Baraka is our new president and leader of'
                          'SOKU committee'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  children: const [
                    Icon(Icons.location_on),
                    Text('BUNGOMA'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

openMail(){
  return launchUrl(
      Uri.parse(
          'mailto:mwichabecollins@gmail.com?subject=Hello&body=Iam using Kibabii Library App and I would like to enquire about...)'
      )
  );
}

whatsApp() {
  return launchUrl(
    Uri.parse(
      'whatsapp://send?phone=+254704858069+&text=Hello, Iam using the Kibabbii Library App'
          'application and I would like to enquire about...',
    ),
  );
}
//notification page
class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pushReplacementNamed(context,'trial');
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Today',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 3, // Replace with actual notifications count
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/avatar.jpg'),
                    ),
                    title: Text('Notification Title $index'),
                    subtitle: const Text('Notification Message'),
                    trailing: const Text(
                      '9:30 AM',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    onTap: () {
                      // Handle notification selection
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Yesterday',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 2, // Replace with actual notifications count
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/avatar.jpg'),
                    ),
                    title: Text('Notification Title $index'),
                    subtitle: const Text('Notification Message'),
                    trailing: const Text(
                      '2:30 PM',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    onTap: () {
                      // Handle notification selection
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;

  UserModelOne loggedInUser = UserModelOne();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value){
      loggedInUser= UserModelOne.fromMap(value.data());
      setState((){});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios),
        onPressed: (){Navigator.pushReplacementNamed(context,'trial');},),
        ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('images/profile_pic.jpeg'),
              radius: 50,
            ),
            const SizedBox(height: 20),
            Text(
              '${loggedInUser.firstName} ${loggedInUser.surName}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
             Text(
              '${loggedInUser.email}',
              style: const TextStyle
                (
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Registration number',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              '${loggedInUser.registrationNumber}',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Programme',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              '${loggedInUser.programme}',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 6, // Replace with actual number of books
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/book.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
