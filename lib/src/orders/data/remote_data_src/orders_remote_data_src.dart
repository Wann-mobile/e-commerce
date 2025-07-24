import 'dart:convert';
import 'package:e_triad/core/common/singleton/cache.dart';
import 'package:e_triad/core/extension/string_ext.dart';
import 'package:e_triad/core/utils/constants/network_constants.dart';
import 'package:e_triad/src/orders/data/model/orders.dart';
import 'package:http/http.dart' as http;


abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getUserOrders(String userId);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final http.Client _client;

  OrderRemoteDataSourceImpl(this._client);

  @override
  Future<List<OrderModel>> getUserOrders(String userId) async {
    final url = Uri.parse('${NetworkConstants.baseUrl}/orders/user/$userId');
    final response = await _client.get(
      url,
      headers : Cache.instance.sessionToken!.toAuthHeaders);

     if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)['active'] as List;
      return jsonData.map((e) => OrderModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }
}
