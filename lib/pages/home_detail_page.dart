import 'package:flutter/material.dart';
import 'package:flutter_catalog/models/catalog.dart';
import 'package:flutter_catalog/widgets/home_widgets/add_to_cart.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeDetailPage extends StatelessWidget {
  final Item catalog;

  const HomeDetailPage({Key? key, required this.catalog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Column(
          children: [
            catalog.name.text.bold.xl4.make(),
            catalog.author.text.sm.gray900.italic.make(),
          ],
        ),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Hero(
              tag: Key(catalog.id.toString()),
              child: Image.network(
                catalog.image,
                fit: BoxFit.contain,
              ),
            ).h32(context),
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: VxArc(
                      height: 30.0,
                      arcType: VxArcType.convex,
                      edge: VxEdge.top,
                      child: Container(
                        color: Colors.black,
                        width: context.screenWidth,
                        padding: EdgeInsets.only(
                          top: 10,
                          left: 16,
                          right: 16,
                          bottom: 150, // Reduced bottom padding to move text up
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Moves content slightly up
                          children: [
                            catalog.desc.text.bold.lg.white.make(),
                            10.heightBox,
                            "${catalog.explanation}".text.white.sm.make(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Colors.black,
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "\$${catalog.price}".text.bold.xl4.red800.make(),
                          AddToCart(catalog: catalog).wh(120, 50),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
