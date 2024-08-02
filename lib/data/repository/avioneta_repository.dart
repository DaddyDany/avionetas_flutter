import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/avioneta_model.dart';

class AvionetaRepository {
  final String baseUrl = 'https://1ki2in8q5f.execute-api.us-east-1.amazonaws.com/Prod/';

  Future<List<Avioneta>> getAllAvionetas() async {
    final response = await http.get(Uri.parse('$baseUrl/get_all_avionetas'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Avioneta.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load avionetas');
    }
  }

  Future<void> createAvioneta(Avioneta avioneta) async {
    final response = await http.post(
      Uri.parse('$baseUrl/insert_avioneta'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(avioneta.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create avioneta');
    }
  }

  Future<void> updateAvioneta(Avioneta avioneta) async {
    final response = await http.put(
      Uri.parse('$baseUrl/edit_avioneta'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'id': avioneta.id,
        'modelo': avioneta.modelo,
        'tipo': avioneta.tipo,
        'profundidadMaxima': avioneta.profundidadMaxima,
        'velocidad': avioneta.velocidad,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update avioneta');
    }
  }

  Future<void> deleteAvioneta(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/delete_avioneta'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'id': id}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete avioneta');
    }
  }
}
