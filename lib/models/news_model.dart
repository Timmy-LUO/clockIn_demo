import 'package:clock_in_demo/network/base_api.dart';

/// News Request Model
final class NewsRequestModel extends BaseApi {

  @override
  String get path => 'Events/News?page=1';

  @override
  RequestMethod get method => RequestMethod.get;
}

/// News Response Model
final class NewsResponseModel {
  final int total;
  final List<NewsResponseDataModel> data;

  NewsResponseModel({
    required this.total,
    required this.data,
  });

  factory NewsResponseModel.fromJson(Map<String, dynamic> json) {
    return NewsResponseModel(
      total: json['total'],
      data: List<NewsResponseDataModel>
          .from(json['data'].map((x) => NewsResponseDataModel.fromJson(x))),
    );
  }
}

final class NewsResponseDataModel {
  final int id;
  final String title;
  final String description;
  final String? begin;
  final String? end;
  final String posted;
  final String modified;
  final String url;
  final List<NewsResponseDataFileModel> files;
  final List<NewsResponseDataLinkModel> links;

  NewsResponseDataModel({
    required this.id,
    required this.title,
    required this.description,
    required this.begin,
    required this.end,
    required this.posted,
    required this.modified,
    required this.url,
    required this.files,
    required this.links,
  });

  factory NewsResponseDataModel.fromJson(Map<String, dynamic> json) {
    return NewsResponseDataModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      begin: json['begin'],
      end: json['end'],
      posted: json['posted'],
      modified: json['modified'],
      url: json['url'],
      files: List<NewsResponseDataFileModel>
          .from(json['files'].map((x) => NewsResponseDataFileModel.fromJson(x))),
      links: List<NewsResponseDataLinkModel>
          .from(json['links'].map((x) => NewsResponseDataLinkModel.fromJson(x))),
    );
  }
}

final class NewsResponseDataFileModel {
  final String src;
  final String subject;
  final String ext;

  NewsResponseDataFileModel({
    required this.src,
    required this.subject,
    required this.ext,

  });

  factory NewsResponseDataFileModel.fromJson(Map<String, dynamic> json) {
    return NewsResponseDataFileModel(
      src: json['src'],
      subject: json['subject'],
      ext: json['ext'],
    );
  }
}

final class NewsResponseDataLinkModel {
  final String src;
  final String subject;

  NewsResponseDataLinkModel({
    required this.src,
    required this.subject,
  });

  factory NewsResponseDataLinkModel.fromJson(Map<String, dynamic> json) {
    return NewsResponseDataLinkModel(
      src: json['src'],
      subject: json['subject'],
    );
  }
}