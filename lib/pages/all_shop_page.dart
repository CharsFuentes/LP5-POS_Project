import 'package:flutter/material.dart';
import 'package:pos/pages/detail_page.dart';

import '../datos/sale.dart';

class AllShopPage extends StatefulWidget {
  const AllShopPage({super.key});

  @override
  State<AllShopPage> createState() => _AllShopPageState();
}

class _AllShopPageState extends State<AllShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tus ventas')),
      body: ListView.builder(
        itemCount: saleList.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(miCompra: saleList[index]),
                ),
              );
            },
            title: Text(saleList[index]['client_sale']['name_client']),
          );
        },
      ),
    );
  }
}
