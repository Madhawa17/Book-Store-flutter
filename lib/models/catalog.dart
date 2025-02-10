class CatalogModel {
  static List<Item> items = [];

  // Get Item by ID
  Item getById(int id) =>
      items.firstWhere((element) => element.id == id, orElse: null);

  // Get Item by position
  Item getByPosition(int pos) => items[pos];
}

class Item {
  final int id;
  final String name;
  final String desc;
  final num price;
  final String color;
  final String image;
  final String author;
  final String explanation; // Added explanation field

  Item({
    this.id = 0,
    this.name = "",
    this.desc = "",
    this.price = 0,
    this.color = "",
    this.image = "",
    this.author = "", // Default value added
    this.explanation = "", // Default value added
  });

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      desc: map['desc'],
      price: map['price'],
      color: map['color'],
      image: map['image'],
      author: map['author'] ?? "", // Ensuring author is handled correctly
      explanation: map['explanation'] ?? "", // Handling explanation
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "desc": desc,
        "price": price,
        "color": color,
        "image": image,
        "author": author, // Added to map
        "explanation": explanation, // Added to map
      };
}
