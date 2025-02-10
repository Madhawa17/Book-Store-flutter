import 'package:flutter/material.dart';
import 'package:flutter_catalog/core/store.dart';
import 'package:flutter_catalog/models/cart.dart';
import 'package:velocity_x/velocity_x.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: "Cart".text.make(),
      ),
      body: Column(
        children: [
          _CartList().p32().expand(),
          Divider(),
          _CartTotal(),
        ],
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartModel _cart = (VxState.store as MyStore).cart;
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          VxBuilder(
            mutations: {RemoveMutation},
            builder: (context, _, status) {
              return "\$${_cart.totalPrice}"
                  .text
                  .xl5
                  .color(context.theme.colorScheme.secondary)
                  .make();
            },
          ),
          30.widthBox,
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    "Purchase Successful!. Enjoy your reading!".text.make(),
              ));
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    context.theme.colorScheme.primary)),
            child: "Buy".text.white.make(),
          ).w32(context)
        ],
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [RemoveMutation]);
    final CartModel _cart = (VxState.store as MyStore).cart;
    return _cart.items.isEmpty
        ? "Nothing to show 😕".text.xl3.makeCentered()
        : ListView.builder(
            itemCount: _cart.items.length,
            itemBuilder: (context, index) {
              final item = _cart.items[index];
              return Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                      255, 11, 11, 27), // background color for the item
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    // Image for the item (small size)
                    Image.network(
                      item.image, // assuming imageUrl is available in the item
                      height: 50, // height of the image
                      width: 50, // width of the image
                      fit: BoxFit.cover, // to make sure image covers the space
                    ),
                    SizedBox(width: 12), // space between the image and the name
                    Expanded(child: item.name.text.make()), // Item name
                    Text("\$${item.price}", // Item price
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: context.theme.colorScheme.secondary,
                        )),
                    IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      onPressed: () => RemoveMutation(item),
                    ),
                  ],
                ),
              );
            },
          );
  }
}
