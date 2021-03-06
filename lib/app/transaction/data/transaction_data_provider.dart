import 'dart:io';

import 'package:finwallet_app/app/category/domain/category_entity.dart';
import 'package:finwallet_app/app/transaction/domain/transaction_entity.dart';
import 'package:finwallet_app/common/contracts.dart';
import 'package:finwallet_app/common/http_client/http_client.dart';
import 'package:http/http.dart' as http;

class TransactionDataProvider extends AbstractHttpDataProvider<TransactionEntity> {
  @override
  String path = 'transaction';

  TransactionDataProvider(HttpClient client) : super(client: client);

  @override
  fromJSON(Map<String, dynamic> json) {
    return TransactionEntity.fromJSON(json);
  }

  Future<void> import(Map<String, String> params, File file) async {

    Uri uri = this.generateUri(path: this.path + '/import');

    await this.client.postMultipartFormFile(uri,
      params: params,
      file: file
    );
  }


}