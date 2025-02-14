import 'package:flutter/material.dart';
import 'package:flutter_catalog/models/catalog.dart';
import 'package:flutter_catalog/pages/home_detail_page.dart';
import 'package:velocity_x/velocity_x.dart';
import 'add_to_cart.dart';
import 'catalog_image.dart';

class CatalogList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (CatalogModel.items.isNotEmpty)
        ? (!context.isMobile
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20, // Added for better spacing
                ),
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(), // Prevents grid scroll conflicts
                itemCount: CatalogModel.items.length,
                itemBuilder: (context, index) {
                  final catalog = CatalogModel.items[index];
                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeDetailPage(catalog: catalog),
                      ),
                    ),
                    child: CatalogItem(catalog: catalog),
                  );
                },
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: CatalogModel.items.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final catalog = CatalogModel.items[index];
                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeDetailPage(catalog: catalog),
                      ),
                    ),
                    child: CatalogItem(catalog: catalog),
                  );
                },
              ))
        : Center(
            child: "No items available".text.xl.bold.make().p16(),
          );
  }
}

class CatalogItem extends StatelessWidget {
  final Item catalog;

  const CatalogItem({Key? key, required this.catalog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var children2 = [
      Hero(
        tag: Key(catalog.id.toString()),
        child: CatalogImage(image: catalog.image),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            catalog.name.text.lg
                .color(context.theme.colorScheme.secondary)
                .bold
                .make(),
            Text(
              catalog.desc,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            10.heightBox,
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              buttonPadding: EdgeInsets.zero,
              children: [
                "\$${catalog.price}".text.bold.xl.make(),
                AddToCart(catalog: catalog)
              ],
            ).pOnly(right: 8.0)
          ],
        ).p(context.isMobile ? 0 : 16),
      )
    ];

    return VxBox(
      child: context.isMobile
          ? Row(children: children2)
          : Column(children: children2),
    ).color(context.theme.cardColor).rounded.square(150).make().py16();
  }
}
