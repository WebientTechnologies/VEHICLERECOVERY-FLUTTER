import 'package:flutter/widgets.dart';

abstract class BaseApi {
  Future<dynamic> getApi(String url);
  Future<dynamic> getApiWithoutHead(String url);

  Future<dynamic> getApiBody(String url, int id, String role);
  Future<dynamic> postApi(String url, dynamic data);
  Future<dynamic> postApiHeader(String url, dynamic data);
  Future<dynamic> postApiWithoutHeader(String url, dynamic data);

  Future<dynamic> postExContentApi(String url, dynamic data);
  Future<dynamic> putApi(String url, dynamic data);
  Future<dynamic> putWOBodyApi(String url);

  Future<dynamic> deleteApi(String url);
  Future<dynamic> loginApi(BuildContext context, String url, dynamic data);
  Future<dynamic> registerApi(BuildContext context, String url, dynamic data);
}
