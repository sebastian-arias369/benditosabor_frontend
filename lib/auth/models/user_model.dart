class UserModel {
  final int idUsuario;
  final String nombre;
  final String correo;
  final String telefono;
  final String direccion;
  final String rol;

  UserModel({
    required this.idUsuario,
    required this.nombre,
    required this.correo,
    required this.telefono,
    required this.direccion,
    required this.rol,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      idUsuario: json['id_usuario'] ?? 0,
      nombre: json['nombre'] ?? '',
      correo: json['correo'] ?? '',
      telefono: json['telefono'] ?? '',
      direccion: json['direccion'] ?? '',
      rol: json['rol'] ?? 'cliente',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_usuario': idUsuario,
      'nombre': nombre,
      'correo': correo,
      'telefono': telefono,
      'direccion': direccion,
      'rol': rol,
    };
  }
}
