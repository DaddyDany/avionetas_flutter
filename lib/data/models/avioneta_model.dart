class Avioneta {
  final int id;
  final String modelo;
  final String tipo;
  final String profundidadMaxima;
  final String velocidad;

  Avioneta({
    required this.id,
    required this.modelo,
    required this.tipo,
    required this.profundidadMaxima,
    required this.velocidad,
  });

  factory Avioneta.fromJson(Map<String, dynamic> json) {
    return Avioneta(
      id: json['id'],
      modelo: json['modelo'],
      tipo: json['tipo'],
      profundidadMaxima: json['profundidadMaxima'],
      velocidad: json['velocidad'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'modelo': modelo,
      'tipo': tipo,
      'profundidadMaxima': profundidadMaxima,
      'velocidad': velocidad,
    };
  }
}
