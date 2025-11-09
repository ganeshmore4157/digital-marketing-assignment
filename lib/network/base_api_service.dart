import 'dart:io';

abstract class BaseApiServices {

  Future<dynamic> getApi(String url, {Map<String, dynamic>? data, String? authToken});

  Future<dynamic>postApi(dynamic data,String url);

  Future<dynamic>putApi(dynamic data,String url);

  Future<dynamic>deletetApi(dynamic data,String url);

 

}