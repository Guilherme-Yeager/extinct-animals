import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:extinct_animals/data/repositories/extinct_repository.dart';

class ExtinctService implements ExtinctRepository {
  final String _urlApi = 'https://extinct-api.herokuapp.com/api/v1/animal/';
  final Dio _dio = Dio();

  @override
  Future<Map<String, dynamic>?> getRandomAnimal() async {
    try {
      final Response<dynamic> response = await _dio.get(_urlApi);
      if (response.statusCode == 200) {
        return jsonDecode(response.toString());
      }
    } catch (e) {
      stderr.writeln(e);
    }
    return null;
  }

  @override
  Future<Map<String, dynamic>?> getNumberAnimal(int number) async {
    try {
      final Response<dynamic> response = await _dio.get('$_urlApi/$number');
      if (response.statusCode == 200) {
        return jsonDecode(response.toString());
      }
    } catch (e) {
      stderr.writeln(e);
    }
    return null;
  }
}
