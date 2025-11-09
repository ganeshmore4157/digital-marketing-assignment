import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:digital_marketing_assignment/Exception/app_exception.dart';
import 'package:digital_marketing_assignment/network/base_api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class NetworkApiServices extends BaseApiServices {
   final Function()? onSessionExpired;
  bool _isSessionExpired = false;

   static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NetworkApiServices({this.onSessionExpired});

  dynamic _handleResponse(http.Response response) {
    if (kDebugMode) {
      print('Response Status: ${response.statusCode}');
      // print('Response Body: ${response.body}');
    }
    
  
  }




  /// GET API method
  @override
  Future<dynamic> getApi(String url, {Map<String, dynamic>? data, String? authToken}) async {
    if (kDebugMode) {
      print('API URL: $url');
      print('Request Params: $data');
      print('AuthToken: $authToken');
    }

    try {
      final headers = {
        'Content-Type': 'application/json',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      };

      Uri uri = Uri.parse(url);
      
      if (data != null && data.isNotEmpty) {
        final queryParameters = <String, dynamic>{};

        data.forEach((key, value) {
          if (value is List) {
            queryParameters[key] = value.map((item) => item.toString()).toList();
          } else if (value != null) {
            queryParameters[key] = value.toString();
          }
        });

        uri = uri.replace(queryParameters: queryParameters);
      }

      final response = await http.get(uri, headers: headers).timeout(const Duration(seconds: 60));

      if (kDebugMode) {
        print('Final API URL: $uri');
      }

    return _handleResponse(response);
    } on SocketException {
      throw 'No internet connection';
    } on TimeoutException {
      throw 'Request timed out';
    } catch (e) {
      throw ' $e';
    }
  
  }

  /// POST API method
  @override
  Future<dynamic> postApi(
    dynamic data,
    String url, {
    Map<String, dynamic>? query,
    String? authToken,
  }) async {
    if (kDebugMode) {
      print('URL: $url');
      print('Payload: $data');
      print('Query Params: $query');
    }

    try {
      final headers = {
        'Content-Type': 'application/json',
        if (authToken != null) 'x-api-key': '$authToken',
      };

      // Build URI with query parameters
      Uri uri = Uri.parse(url);
      if (query != null && query.isNotEmpty) {
        uri = uri.replace(queryParameters: query.map(
          (key, value) => MapEntry(
            key, 
            value is List ? value.map((e) => e.toString()).join(',') : value.toString()
          ),
        ));
      }

      final response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 180));

      if (kDebugMode) {
        print('Final URL: ${uri.toString()}');
      }

      return _handleResponse(response);
    } on SocketException {
      throw 'No Internet connection';
    } on http.ClientException {
      throw 'Network error occurred';
    } on RequestTimeOutException {
      throw 'The connection has timed out';
    } catch (e) {
      throw '$e';
    }
  }

  /// PUT API method
  @override
  Future<dynamic> putApi(
    dynamic data,
    String url, {
    Map<String, dynamic>? query,
    String? authToken,
  }) async {
    if (kDebugMode) {
      print('URL: $url');
      print('Payload: $data');
      print('queryParamsData $query');
    }

    try {
      final headers = {
        'Content-Type': 'application/json',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      };

      Uri uri = Uri.parse(url);
      
      // Build query string manually to handle duplicate keys
      String queryString = '';
      
      if (query != null && query.isNotEmpty) {
        List<String> queryParts = [];
        
        query.forEach((key, value) {
          if (value is List) {
            // For lists, add each item as a separate key-value pair
            for (var item in value) {
              queryParts.add('${Uri.encodeComponent(key)}=${Uri.encodeComponent(item.toString())}');
            }
          } else if (value != null) {
            queryParts.add('${Uri.encodeComponent(key)}=${Uri.encodeComponent(value.toString())}');
          }
        });
        
        if (queryParts.isNotEmpty) {
          queryString = '?${queryParts.join('&')}';
        }
      }

      // Construct the final URL with query string
      final finalUrl = '$url$queryString';
      final finalUri = Uri.parse(finalUrl);

      final response = await http.put(
        finalUri,
        headers: headers,
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 20));

      if (kDebugMode) {
        print('Final URL: ${finalUri.toString()}');
      }

      return _handleResponse(response);
    } on SocketException {
      throw 'No Internet connection';
    } on http.ClientException {
      throw 'Network error occurred';
    } on RequestTimeOutException {
      throw 'The connection has timed out';
    } catch (e) {
      throw '$e';
    }
  }

  /// DELETE API method
  @override
  Future<dynamic> deletetApi(
    dynamic data,
    String url, {
    Map<String, dynamic>? query,
    String? authToken,
  }) async {
    if (kDebugMode) {
      print('API URL: $url');
      print("Data: $data");
    }

    try {
      final headers = {
        'Content-Type': 'application/json',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      };

            Uri uri = Uri.parse(url);
      
      // Build query string manually to handle duplicate keys
      String queryString = '';
      
      if (query != null && query.isNotEmpty) {
        List<String> queryParts = [];
        
        query.forEach((key, value) {
          if (value is List) {
            // For lists, add each item as a separate key-value pair
            for (var item in value) {
              queryParts.add('${Uri.encodeComponent(key)}=${Uri.encodeComponent(item.toString())}');
            }
          } else if (value != null) {
            queryParts.add('${Uri.encodeComponent(key)}=${Uri.encodeComponent(value.toString())}');
          }
        });
        
        if (queryParts.isNotEmpty) {
          queryString = '?${queryParts.join('&')}';
        }
      }

      // Construct the final URL with query string
      final finalUrl = '$url$queryString';
      final finalUri = Uri.parse(finalUrl);

      final response = await http.delete(
        finalUri,
        headers: headers,
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 10));

       if (kDebugMode) {
        print('Final URL: ${finalUri.toString()}');
      }

      if (kDebugMode) {
        print('Response Status: ${response.statusCode}');
      }

      return _handleResponse(response);
    } on SocketException {
      throw 'No Internet connection';
    } on http.ClientException {
      throw 'Network error occurred';
    } on RequestTimeOutException {
      throw 'The connection has timed out';
    } catch (e) {
      throw '$e';
    }
  }








}