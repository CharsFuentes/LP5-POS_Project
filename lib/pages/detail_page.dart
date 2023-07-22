import 'package:flutter/material.dart';
import 'package:pos/datos/sale.dart';
import 'package:pos/widgets/bottom_content_pages.dart';

class DetailPage extends StatelessWidget {
  final Map miCompra;

  const DetailPage({super.key, required this.miCompra});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de venta')),
      body: ListView(
        children: [
          const Text('Detalle de la compra', style: TextStyle(fontSize: 20.0)),
          Text(miCompra['client_sale']['name_client']),
          ListView.builder(
            shrinkWrap: true,
            itemCount: miCompra['product_sale'].length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(miCompra['product_sale'][index]['name_product']),
                subtitle: Text(
                    'S/. ${miCompra['product_sale'][index]['price_product']}'),
              );
            },
          ),
          Text('Total: S/. ${miCompra['total_price']}',
              style: TextStyle(fontSize: 20.0)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saleList.add(miCompra);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const BottomContentPages()), (route) => false);
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
