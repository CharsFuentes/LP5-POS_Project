import 'package:flutter/material.dart';
import 'package:pos/pages/detail_page.dart';
import 'package:pos/widgets/container_borde.dart';

import '../datos/clientes.dart';
import '../datos/productos.dart';

class SalePage extends StatefulWidget {
  const SalePage({super.key});

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  Map clienteTemporal = {};
  List carritoTemporal = [];
  double totalPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vender')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text('Tus clientes', style: TextStyle(fontSize: 20.0)),
          ContainerBorde(
            child: ListView.builder(
              itemCount: clientes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    clienteTemporal.addAll({
                      'name_client': clientes[index]['name_client'],
                      'dni_client': clientes[index]['dni_client'],
                    });
                    setState(() {});
                  },
                  title: Text(clientes[index]['name_client']),
                  subtitle: Text('DNI: ${clientes[index]['dni_client']}'),
                );
              },
            ),
          ),
          clienteTemporal.isNotEmpty
              ? ListTile(
                  title: Text(clienteTemporal['name_client']),
                  subtitle: Text('DNI: ${clienteTemporal['dni_client']}'),
                  trailing: IconButton(
                      onPressed: () {
                        clienteTemporal.clear();
                        setState(() {});
                      },
                      icon: const Icon(Icons.clear)),
                )
              : const SizedBox(),
          const Text('Tus productos', style: TextStyle(fontSize: 20.0)),
          ContainerBorde(
            child: ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    String nombreProducto = productos[index]['name_product'];
                    double precioProducto = productos[index]['price_product'];
                    bool productoRepetido = carritoTemporal.any((producto) =>
                        producto['name_product'] ==
                        nombreProducto); // Verificar si el producto ya está en el arreglo
                    if (productoRepetido) {
                      // Verificar si el producto ya ha sido agregado
                      print(
                          'El producto $nombreProducto ya fue agregado anteriormente'); // Imprimir mensaje
                    } else {
                      carritoTemporal.add({
                        'name_product': nombreProducto,
                        'price_product': precioProducto,
                      });
                    }
                    calculandoMontoTotal();
                    setState(() {});
                  },
                  title: Text(productos[index]['name_product']),
                  subtitle: Text('S/. ${productos[index]['price_product']}'),
                );
              },
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: carritoTemporal.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(carritoTemporal[index]['name_product']),
                subtitle:
                    Text('S/. ${carritoTemporal[index]['price_product']}'),
                trailing: IconButton(
                    onPressed: () {
                      carritoTemporal.remove(carritoTemporal[index]);
                      calculandoMontoTotal();
                      //Borrando productos del carrito individualmente
                      setState(() {});
                    },
                    icon: const Icon(Icons.clear)),
              );
            },
          )
        ],
      ),
      floatingActionButton: totalPrice <= 0.0
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                if (clienteTemporal.isNotEmpty) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailPage(
                                miCompra: {
                                  'client_sale': clienteTemporal,
                                  'product_sale': carritoTemporal,
                                  'total_price': totalPrice,
                                },
                              )),
                      (route) => false);
                } else {
                  print('selecciona un cliente');
                }
              },
              label: Text('Total: S/. $totalPrice'),
            ),
    );
  }

  //Calcula la cantidad todo lo que se va a comprar
  calculandoMontoTotal() {
    totalPrice = 0.0;
    if (carritoTemporal.isNotEmpty) {
      for (int index = 0; index < carritoTemporal.length; index++) {
        totalPrice += carritoTemporal[index]['price_product'];
      }
    }
  }
}
