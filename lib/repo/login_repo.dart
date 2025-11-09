import 'package:digital_marketing_assignment/constant/api_constant.dart';
import 'package:digital_marketing_assignment/network/network_api_service.dart';

class LoginRepo {
  final _apiService= NetworkApiServices();

  Future<dynamic> loginApi(var data,{required String authToken})async{
   dynamic response=_apiService.postApi(data, ApiConstants.loginEndpoint,authToken: authToken);
   return response;
  }
}