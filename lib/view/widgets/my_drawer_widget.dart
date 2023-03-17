import 'package:flutter/material.dart';
class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Drawer(

        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Admin CRUD Area'),
            ),
            ListTile(
              title: const Text('View All Users'),
              onTap: () {

                Navigator.pop(context);
                Navigator.pushNamed(context,"/Admin/Users");
              },
            ),
            ListTile(
              title: const Text('Create New User'),
              onTap: () {

                Navigator.pop(context);
                Navigator.pushNamed(context,"/Admin/CreateUser");
              },
            ),
            ListTile(
              title: const Text('Create new Category'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context,"/Admin/Category/create");
              },
            ),
            ListTile(
              title: const Text('View All Categories'),
              onTap: () {

                Navigator.pop(context);
                Navigator.pushNamed(context,"Admin/Category");
              },
            ),

            ListTile(
              title: const Text('View All Tags'),
              onTap: () {

                Navigator.pop(context);
                Navigator.pushNamed(context,"/Tags");
              },
            ),

            ListTile(
              title: const Text('View All Statuses'),
              onTap: () {

                Navigator.pop(context);
                Navigator.pushNamed(context,"Admin/status");
              },
            ),
          ],
        ),
      );
  }
}
