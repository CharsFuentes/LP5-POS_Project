import 'package:flutter/material.dart';
import '../pages/all_shop_page.dart';
import '../pages/sale_page.dart';

class BottomContentPages extends StatelessWidget {
  const BottomContentPages({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: [SalePage(), AllShopPage()],
        ),
        bottomNavigationBar: Material(
          color: Colors.blue,
          child: TabBar(
            tabs: [
              Tab(text: 'Vender', icon: Icon(Icons.home)),
              Tab(text: 'Ventas', icon: Icon(Icons.person)),
            ],
          ),
        ),
      ),
    );
  }
}
