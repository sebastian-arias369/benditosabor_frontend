class Category {
  final int id;
  final String nombre;
  final String? descripcion;
  final List<ItemMenu> itemsMenu;

  Category({
    required this.id,
    required this.nombre,
    this.descripcion,
    this.itemsMenu = const [],
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id_categoria'] ?? json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      descripcion: json['descripcion'],
      itemsMenu: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_categoria': id,
      'nombre': nombre,
      'descripcion': descripcion,
    };
  }
}

class ItemMenu {
  final int id;
  final String nomItem;
  final String descItem;
  final double precItem;
  final String imgItemMenu;
  final bool estItem;
  final int stock;

  ItemMenu({
    required this.id,
    required this.nomItem,
    required this.descItem,
    required this.precItem,
    required this.imgItemMenu,
    this.estItem = true,
    this.stock = 0,
  });

  factory ItemMenu.fromJson(Map<String, dynamic> json) {
    final precio = json['precio'];
    final precioDouble = precio is String ? double.parse(precio) : (precio as num).toDouble();

    return ItemMenu(
      id: json['id_producto'] ?? json['id'] ?? 0,
      nomItem: json['nombre'] ?? '',
      descItem: json['descripcion'] ?? '',
      precItem: precioDouble,
      imgItemMenu: json['imagen_url'] ?? '',
      estItem: (json['stock'] ?? 0) > 0,
      stock: json['stock'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_producto': id,
      'nombre': nomItem,
      'descripcion': descItem,
      'precio': precItem,
      'imagen_url': imgItemMenu,
      'stock': stock,
    };
  }
}
