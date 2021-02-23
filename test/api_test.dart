import 'package:flutter_test/flutter_test.dart';
import 'package:dicoding_news_app/data/api/api_service.dart';

void main() {
  group('api service test', () {
    ApiService apiService;
    setUp(() {
      apiService = ApiService();
    });
    test('get list resto should return Listresto model', () async {
      // act
      var listResto = await apiService.list();
      // assert
      var result = listResto.error;
      expect(result, false);
    });
    test('get resto detail should return RestoDetail model', () async {
      // act
      var restoDetail = await apiService.detail('rqdv5juczeskfw1e867');
      // assert
      var result = restoDetail.error;
      expect(result, false);
    });
    test('get resto search should return RestoSearch model', () async {
      // act
      var restoSearch = await apiService.search('kita');
      // assert
      var result = restoSearch.error;
      expect(result, false);
    });
  });
}
