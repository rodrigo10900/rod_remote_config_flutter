import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'entities.dart';

/// A Calculator.
class RodRemoteConfig {
  String? _configUrl;
  Duration? _cacheDuration;
  final List<CollectionSchema> schemas = [RemoteConfigDataEntSchema];
  late final Future<Isar> _db;

  RodRemoteConfig() {
    _db = _openDb();
  }

  Future<Isar> _openDb() async {
    if (Isar.instanceNames.isNotEmpty) {
      return Future.value(Isar.getInstance());
    }
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open(schemas, directory: dir.path);
  }

  /// Fetches the remote configuration data from the specified URL and stores it in the local database.
  /// If the data is already present and the cache duration has not expired, it will not fetch the data again.
  /// @returns A Future that resolves to true if the data was fetched and stored, or false if the data was already present and the cache duration has not expired.  
  Future<bool> fetchConfig({required String configUrl, required Duration cacheDuration}) async {
    _configUrl = configUrl;
    _cacheDuration = cacheDuration;
    final isar = await _db;
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
      final existingConfig = await isar.remoteConfigDataEnts
          .where()
          .findFirst();
      final durationInMillis = _cacheDuration!.inMilliseconds;
      if (existingConfig != null) {
        final timeDifference =
            DateTime.now().millisecondsSinceEpoch -
            (existingConfig.timestamp ?? 0);
        if (timeDifference < durationInMillis) {
          return false; 
        }
        await isar.writeTxn(() async {
          await isar.remoteConfigDataEnts.put(remoteConfigData);
        });
      } else {
        await isar.writeTxn(() async {
          await isar.remoteConfigDataEnts.put(remoteConfigData);
        });
      }
    } catch (e) {
      final message = e is FormatException ? "Error de formato en el archivo de configuración JSON: ${e.message}" : e.toString();
      throw Exception(
        message,
      );
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
  Future<Map<String, dynamic>> getJsonValueDefault(String key, Map<String, dynamic> defaultValue) async {
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
  Future<List<dynamic>> getListValueDefault(String key, List<dynamic> defaultValue) async {
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
    final isar = await _db;
    try {
      final existingConfig = await isar.remoteConfigDataEnts.where().findFirst();
      if (existingConfig != null) {
        final data = jsonDecode(existingConfig.data ?? '{}');
        if (data.containsKey(key)) {
          return data[key] as T?;
        }
      }
    } catch (e) {
      throw Exception('Error al obtener el valor para la clave "$key": $e');
    }
    return null;
  }
}
