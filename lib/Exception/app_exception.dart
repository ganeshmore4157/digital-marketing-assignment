
class AppExceptions implements Exception{
  final _message ;
  final _prefix ;
  AppExceptions([this._message,this._prefix]);
    
  @override
  String toString(){
    return '$_message $_prefix';
  }
}
class InternetException extends AppExceptions{
  InternetException([String? message]) :super(message,'No internet'); 
}
class RequestTimeOutException extends AppExceptions{
  RequestTimeOutException([String? message]) :super(message,'Request Time Out'); 
}
class ServerErrorException extends AppExceptions{
  ServerErrorException([String? message]) :super(message,'Inetrnal Server error'); 
}
class InvalidUrlException extends AppExceptions{
  InvalidUrlException([String? message]) :super(message,'Invalid Url'); 
}
class FetchDataException extends AppExceptions{
  FetchDataException(String message,) :super(message,''); 
}
class BadRequestException extends AppExceptions{
  BadRequestException(String message,) :super(message,'Bad request'); 
}
class UnauthorizedException extends AppExceptions{
  UnauthorizedException(String message,) :super(message,'Unauthorized'); 
}
// class BadRequestException extends AppExceptions{
//   BadRequestException(String message,) :super(message,'Bad request'); 
// }
// class BadRequestException extends AppExceptions{
//   BadRequestException(String message,) :super(message,'Bad request'); 
// }