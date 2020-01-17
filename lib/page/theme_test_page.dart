import 'package:flutter/material.dart';

class ThemeTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text(index.toString()),
            ),
            title: Text("Hello Material"),
            subtitle: Text("It's better to burn out,than to fade away"),
          );
        },
        itemCount: 30,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.share),
        mini: true,
      ),
      drawer: Drawer(
        child: FlutterLogo(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.store), title: Text('Store')),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), title: Text('Cart')),
        ],
      ),
    );
  }
}
