import 'dart:convert';
import 'package:clock_in_demo/network/http_service.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:logger/logger.dart';

final log = Logger();

enum RequestMethod { get, post, put, delete }

abstract class BaseApi {

  RequestMethod get method;
  String get path;

  Map<String, String>? get header {
    Map<String, String> header = {};
    switch (method) {
      case RequestMethod.post:
        header['Content-Type'] = 'application/json; charset=UTF-8';
        break;
      default:
        break;
    }
    return header;
  }

  Map<String, dynamic>? get query => null;

  Map<String, dynamic>? get body => null;

  Future<FormData?> get formData async => null;

  void request({
    required Function successCallBack,
    required Function(String, int?) errorCallBack,
  }) async {
    HttpService service = HttpService.instance;
    Dio dio = service.dio;

    Response? response;

    Map<String, String>? h = header;
    Map<String, dynamic>? q = query;
    Map<String, dynamic>? b = body;
    FormData? f = await formData;

    Map<String, dynamic>? queryParams = {};
    var globalQueryParams = service.serviceQuery();
    if (globalQueryParams != null) {
      queryParams.addAll(globalQueryParams);
    }
    if (q != null) {
      queryParams.addAll(q);
    }

    Map<String, dynamic>? headerParams = {};
    var globalHeaderParams = service.serviceHeader();
    if (globalHeaderParams != null) {
      headerParams.addAll(globalHeaderParams);
    }
    if (h != null) {
      headerParams.addAll(h);
    }

    Map<String, dynamic>? bodyParams = {};
    var globalBodyParams = service.serviceBody();
    if (globalBodyParams != null) {
      bodyParams.addAll(globalBodyParams);
    }
    if (b != null) {
      bodyParams.addAll(b);
    }

    String url = path;

    Options options = Options(headers: headerParams);

    try {
      switch (method) {
        case RequestMethod.get:
          response = await dio.get(url, queryParameters: queryParams, options: options);
          break;
        case RequestMethod.post:
          if (f != null) {
            response = await dio.post(url, data: f, options: options);
          } else {
            response = await dio.post(url, data: bodyParams, options: options);
          }
          break;
        default:
          break;
      }
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        errorCallBack('驗證過期，請重新登入', error.response?.statusCode);
      } else {
        errorCallBack(service.errorFactory(error), error.response?.statusCode);
      }
    }
    if (response != null && response.data != null) {
      String dataStr = json.encode(response.data);
      Map<String, dynamic> dataMap = json.decode(dataStr);
      dataMap = service.responseFactory(dataMap);
      successCallBack(dataMap);
    }
  }

  Future<void> downloadFile({
    required String url,
    required String filename,
    required Function(File) successCallBack,
    required Function errorCallBack,
  }) async {
    HttpService service = HttpService.instance;
    Dio dio = service.dio;

    try {
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/$filename');

      final response = await dio.download(
        url,
        file.path,
        options: Options(headers: header)
      );

      if (response.statusCode == 200) {
        successCallBack(file);
      } else {
        throw Exception('Failed to download file');
      }
    } on DioException catch (error) {
      errorCallBack(service.errorFactory(error));
    } catch (error) {
      errorCallBack(error);
    }
  }
}