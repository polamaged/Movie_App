import 'package:dio/dio.dart';

abstract class Failure {
final String errMessage;

  Failure({required this.errMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errMessage});


  factory ServerFailure.fromDioError(DioException dioexception)
  {
    switch(dioexception.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(errMessage: 'Connection Time Out with api server');
      case DioExceptionType.sendTimeout:
        return ServerFailure(errMessage: 'Send Time Out with api server');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errMessage: 'Receive Time Out with api server');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(dioexception.response!.statusCode!,dioexception.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure(errMessage: 'Request to api server was cancel ');
      case DioExceptionType.unknown:
        if(dioexception.message!.contains('SocketException'))
        {
            return ServerFailure(errMessage: 'No Internet Connection');
        }
        return ServerFailure(errMessage: 'Unexpected Error , Please Try Later');

      case DioExceptionType.badCertificate:
        // TODO: Handle this case.
        throw UnimplementedError();
      case DioExceptionType.connectionError:
        // TODO: Handle this case.
        throw UnimplementedError();
        
    }

  }
  
factory ServerFailure.fromResponse(int statusCode , dynamic response)
{
    if(statusCode == 400 || statusCode == 401 || statusCode == 403)
    {
        return ServerFailure(errMessage: response['error']['message']);
    }else if (statusCode == 404)
    {
        return ServerFailure(errMessage: 'Your request not found , try again later');
    }else if (statusCode == 500)
    {
        return ServerFailure(errMessage: 'Internal server error , Please try again later');
    }
    else 
    {
        return ServerFailure(errMessage: 'Opps there was an error , please try again');
    }
}


}