import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rod_remote_config/entities.dart';
import 'package:rod_remote_config/exceptions.dart';

/// A Calculator.
class RodRemoteConfig {
  static const fileName = 'rod_remote_config_data.json';
  String? _configUrl;
  Duration? _cacheDuration;
  File? _file;

  RodRemoteConfig() {
    _init();
  }

  Future<void> _init() async {
    _file = await _openFile();
  }

  Future<File?> _openFile() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName');
    if (!await file.exists()) {
      await file.create();
    }
    return file;
  }

  /// Fetches the remote configuration data from the specified URL and stores it in the local database.
  /// If the data is already present and the cache duration has not expired, it will not fetch the data again.
  /// @returns A Future that resolves to true if the data was fetched and stored, or false if the data was already present and the cache duration has not expired.
  Future<bool> fetchConfig({
    required String configUrl,
    required Duration cacheDuration,
  }) async {
    _configUrl = configUrl;
    _cacheDuration = cacheDuration;
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: configUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    try {
      final responseString = await dio.get(_configUrl!);
      final remoteConfigData = RemoteConfigDataEnt()
        ..timestamp = DateTime.now().millisecondsSinceEpoch
        ..data = jsonEncode(responseString.data);
      final existingConfig = await _file?.lastModified();
      final durationInMillis = _cacheDuration!.inMilliseconds;
      if (existingConfig != null) {
        final timeDifference =
            DateTime.now().millisecondsSinceEpoch -
            existingConfig.millisecondsSinceEpoch;
        if (timeDifference < durationInMillis) {
          return false;
        }
        await _file?.writeAsString(remoteConfigData.toJson());
      } else {
        await _file?.writeAsString(remoteConfigData.toJson());
      }
    } catch (e) {
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          throw RodRemoteConfigFetchException(
              "Error de conexión: No se pudo conectar al servidor de configuración remota.");
        } else if (e.type == DioExceptionType.badResponse) {
          throw RodRemoteConfigFetchException(
              "Error en la respuesta del servidor: ${e.response?.statusCode} ${e.response?.statusMessage}");
        }
        return false;
      }
      final message = e is FormatException
          ? "Error de formato en el archivo de configuración JSON: ${e.message}"
          : e.toString();
      throw RodRemoteConfigParseException(message);
    } finally {
      dio.close();
    }
    return true;
  }

  /// Retrieves the value associated with the given key from the remote configuration data.
  /// If the key does not exist or an error occurs, it returns the provided default value.
  /// @param key The key whose value is to be retrieved.
  /// @param defaultValue The default value to return if the key does not exist or an error occurs.
  /// @returns A Future that resolves to the value associated with the key, or the default value if the key does not exist or an error occurs.
  Future<int> getIntValueDefault(String key, int defaultValue) async {
    try {
      final value = await _getValue<int>(key);
      return value ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  /// Retrieves the value associated with the given key from the remote configuration data.
  /// If the key does not exist or an error occurs, it returns the provided default value.
  /// @param key The key whose value is to be retrieved.
  /// @param defaultValue The default value to return if the key does not exist or an error occurs.
  /// @returns A Future that resolves to the value associated with the key, or the default value if the key does not exist or an error occurs.
  Future<String> getStringValueDefault(String key, String defaultValue) async {
    try {
      final value = await _getValue<String>(key);
      return value ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  /// Retrieves the value associated with the given key from the remote configuration data.
  /// If the key does not exist or an error occurs, it returns the provided default value.
  /// @param key The key whose value is to be retrieved.
  /// @param defaultValue The default value to return if the key does not exist or an error occurs.
  /// @returns A Future that resolves to the value associated with the key, or the default value if the key does not exist or an error occurs.
  Future<bool> getBoolValueDefault(String key, bool defaultValue) async {
    try {
      final value = await _getValue<bool>(key);
      return value ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  /// Retrieves the value associated with the given key from the remote configuration data.
  /// If the key does not exist or an error occurs, it returns the provided default value.
  /// @param key The key whose value is to be retrieved.
  /// @param defaultValue The default value to return if the key does not exist or an error occurs.
  /// @returns A Future that resolves to the value associated with the key, or the default value if the key does not exist or an error occurs
  Future<double> getDoubleValueDefault(String key, double defaultValue) async {
    try {
      final value = await _getValue<double>(key);
      return value ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  /// Retrieves the value associated with the given key from the remote configuration data.
  /// If the key does not exist or an error occurs, it returns the provided default value.
  /// @param key The key whose value is to be retrieved.
  /// @param defaultValue The default value to return if the key does not exist or an error occurs.
  /// @returns A Future that resolves to the value associated with the key, or the default value if the key does not exist or an error occurs.
  Future<Map<String, dynamic>> getJsonValueDefault(
    String key,
    Map<String, dynamic> defaultValue,
  ) async {
    try {
      final value = await _getValue<Map<String, dynamic>>(key);
      return value ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  /// Retrieves the value associated with the given key from the remote configuration data.
  /// If the key does not exist or an error occurs, it returns the provided default value.
  /// @param key The key whose value is to be retrieved.
  /// @param defaultValue The default value to return if the key does not exist or an error occurs.
  /// @returns A Future that resolves to the value associated with the key, or the default value if the key does not exist or an error occurs.
  Future<List<dynamic>> getListValueDefault(
    String key,
    List<dynamic> defaultValue,
  ) async {
    try {
      final value = await _getValue<List<dynamic>>(key);
      return value ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  ///  Retrieves the value associated with the given key from the remote configuration data.
  /// @param key The key whose value is to be retrieved.
  /// @returns A Future that resolves to the value associated with the key, or null if the key does not exist or an error occurs.
  /// @throws Exception if there is an error while retrieving the value.
  Future<int?> getIntValue(String key) async {
    return _getValue<int>(key);
  }

  /// Retrieves the value associated with the given key from the remote configuration data.
  /// @param key The key whose value is to be retrieved.
  /// @returns A Future that resolves to the value associated with the key, or null if the key does not exist or an error occurs.
  /// @throws Exception if there is an error while retrieving the value.
  Future<String?> getStringValue(String key) async {
    return _getValue<String>(key);
  }

  /// Retrieves the value associated with the given key from the remote configuration data.
  /// @param key The key whose value is to be retrieved.
  /// @returns A Future that resolves to the value associated with the key, or null if the key does not exist or an error occurs.
  /// @throws Exception if there is an error while retrieving the value.
  Future<bool?> getBoolValue(String key) async {
    return _getValue<bool>(key);
  }

  /// Retrieves the value associated with the given key from the remote configuration data.
  /// @param key The key whose value is to be retrieved.
  /// @returns A Future that resolves to the value associated with the key, or null if the key does not exist or an error occurs.
  /// @throws Exception if there is an error while retrieving the value.
  Future<double?> getDoubleValue(String key) async {
    return _getValue<double>(key);
  }

  /// Retrieves the value associated with the given key from the remote configuration data.
  /// @param key The key whose value is to be retrieved.
  /// @returns A Future that resolves to the value associated with the key, or null if the key does not exist or an error occurs.
  /// @throws Exception if there is an error while retrieving the value.
  Future<Map<String, dynamic>?> getJsonValue(String key) async {
    return _getValue<Map<String, dynamic>>(key);
  }

  /// Retrieves the value associated with the given key from the remote configuration data.
  /// @param key The key whose value is to be retrieved.
  /// @returns A Future that resolves to the value associated with the key, or null if the key does not exist or an error occurs.
  /// @throws Exception if there is an error while retrieving the value.
  Future<List<dynamic>?> getListValue(String key) async {
    return _getValue<List<dynamic>>(key);
  }

  Future<T?> _getValue<T>(String key) async {
    try {
      if (_file != null && await _file!.exists()) {
        final content = await _file!.readAsString();
        final decodedContent = jsonDecode(content.isNotEmpty ? content : '{}');
        final data = decodedContent['data'] != null
            ? jsonDecode(decodedContent['data'])
            : {};
        if (data.containsKey(key)) {
          return data[key] as T?;
        }
      }
    } catch (e) {
      throw RodRemoteConfigKeyNotFoundException('Error al obtener el valor para la clave "$key": $e');
    }
    return null;
  }
}
