import 'package:flutter/material.dart';
import 'package:uyishi_3_iyul/controller/controllers.dart';
import 'package:uyishi_3_iyul/models/models.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  User user = User(
    name: 'Sardor',
    surname: 'Ergashev',
    phoneNumber: '+998901234567',
    imageUrl: 'https://via.placeholder.com/150',
  );
  late UserController _controller;

  @override
  void initState() {
    super.initState();
    _controller = UserController(user);
  }

  List<Widget> _pages() => [
        MainScreen(),
        StatisticsScreen(),
        ProfileScreen(
            user: user, controller: _controller, onUpdate: _updateUser),
      ];

  void _updateUser() {
    setState(() {});
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          if (MediaQuery.of(context).size.width >= 600)
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onItemTapped,
              labelType: NavigationRailLabelType.selected,
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.show_chart),
                  label: Text('Statistics'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person),
                  label: Text('Profile'),
                ),
              ],
            ),
          Expanded(
            child: _pages()[_selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: MediaQuery.of(context).size.width < 600
          ? BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.show_chart),
                  label: 'Statistics',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            )
          : null,
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: <Widget>[
        Card(
          child: Center(child: Text('Rejalar')),
        ),
        Card(
          child: Center(child: Text('Eslatmalar')),
        ),
      ],
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Bajarilgan rejalar: 5'),
          Text('Bajarilmagan rejalar: 3'),
          Text('Eslatmalar: 4'),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final User user;
  final UserController controller;
  final VoidCallback onUpdate;

  ProfileScreen(
      {required this.user, required this.controller, required this.onUpdate});

  void _showEditModal(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: user.name);
    TextEditingController surnameController =
        TextEditingController(text: user.surname);
    TextEditingController phoneController =
        TextEditingController(text: user.phoneNumber);
    TextEditingController imageController =
        TextEditingController(text: user.imageUrl);

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: surnameController,
                decoration: InputDecoration(labelText: 'Surname'),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              TextField(
                controller: imageController,
                decoration: InputDecoration(labelText: 'Image URL'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  controller.updateUser(
                    nameController.text,
                    surnameController.text,
                    phoneController.text,
                    imageController.text,
                  );
                  onUpdate();
                  Navigator.pop(context);
                },
                child: Text('Update'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(user.imageUrl),
            radius: 50,
          ),
          Text('Name: ${user.name}'),
          Text('Surname: ${user.surname}'),
          Text('Phone Number: ${user.phoneNumber}'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _showEditModal(context),
            child: Text('Edit Profile'),
          ),
        ],
      ),
    );
  }
}
