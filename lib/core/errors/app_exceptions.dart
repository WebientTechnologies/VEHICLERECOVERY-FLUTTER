class AppExceptions implements Exception {
  final _prefix;
  final _message;

  AppExceptions([this._prefix, this._message]);

  @override
  String toString() {
    return '$_prefix : $_message';
  }
}

class ServerException extends AppExceptions {
  ServerException([String? message])
      : super('Internal Server Exception', message);
}

class CacheException extends AppExceptions {}

class NetworkException extends AppExceptions {
  NetworkException([String? message]) : super('Network Error', message);
}

class NoInternetException extends AppExceptions {
  NoInternetException([String? message]) : super('No Internet Found', message);
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message])
      : super('Error while communication', message);
}
