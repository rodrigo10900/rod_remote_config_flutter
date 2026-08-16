import 'package:dio/dio.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'entities.dart';

/// A Calculator.
class RodRemoteConfig {
  final String configUrl;
  final Duration cacheDuration;
  final List<CollectionSchema> schemas = [RemoteConfigDataEntSchema];
  late final Future<Isar> _db;

  RodRemoteConfig({required this.configUrl, required this.cacheDuration}) {
    _db = _openDb();
  }

  Future<Isar> _openDb() async {
    if (Isar.instanceNames.isNotEmpty) {
      return Future.value(Isar.getInstance());
    }
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open(schemas, directory: dir.path);
  }

  Future<bool> fetchConfig() async {
    final isar = await _db;
    final Dio _dio = Dio(
      BaseOptions(
        baseUrl: configUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    try {
      final responseString = await _dio.get(configUrl);
      final remoteConfigData = RemoteConfigDataEnt()
        ..timestamp = DateTime.now().millisecondsSinceEpoch
        ..data = responseString.data.toString();
      final existingConfig = await isar.remoteConfigDataEnts
          .where()
          .findFirst();
      final durationInMillis = cacheDuration.inMilliseconds;
      if (existingConfig != null) {
        final timeDifference =
            DateTime.now().millisecondsSinceEpoch -
            (existingConfig.timestamp ?? 0);
        if (timeDifference < durationInMillis) {
          return false; // Return false if the cache is still valid.
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
      throw Exception(
        'No se encontró el archivo de configuración en la URL proporcionada: $configUrl',
      );
    }
    return true; // Return true if the fetch was successful, false otherwise.
  }

  Future<int?> getIntValue(String key) async {
    return null;
  }

  Future<String?> getStringValue(String key) async {
    return null;
  }

  Future<bool> getBoolValue(String key) async {
    return false;
  }

  Future<double?> getDoubleValue(String key) async {
    return null;
  }

  Future<Map<String, dynamic>?> getJsonValue(String key) async {
    return null;
  }
}
