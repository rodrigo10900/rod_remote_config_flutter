class RodRemoteConfigException implements Exception {
  final String message;

  RodRemoteConfigException(this.message);

  @override
  String toString() => 'RodRemoteConfigException: $message';
}

class RodRemoteConfigFetchException extends RodRemoteConfigException {
  RodRemoteConfigFetchException(super.message);
}

class RodRemoteConfigParseException extends RodRemoteConfigException {
  RodRemoteConfigParseException(super.message);
}

class RodRemoteConfigKeyNotFoundException extends RodRemoteConfigException {
  RodRemoteConfigKeyNotFoundException(String key)
      : super("La clave '$key' no se encontró en la configuración remota.");
}