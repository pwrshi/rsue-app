// import 'package:hive/hive.dart';
// import 'package:rsue_app/src/data/repositories/portfolio_datasource.dart';
// import 'package:rsue_app/src/domain/entities/subject_entity.dart';
// import 'package:rsue_app/src/domain/entities/payment_entity.dart';

// class PortfolioCacheDatasource implements PortfolioDataSource {
//   Box<Map<String, List<SubjectEntity>>> storageAcademicPerfomance =
//       Hive.box('portfolio_cache_datasource_get_academic_perfomance');
//   Box<List<PaymentEntity>> storagePayments =
//       Hive.box('portfolio_cache_datasource_get_payments');
//   Box<Map<String, String>> storageWhoami =
//       Hive.box('portfolio_cache_datasource_get_whoami');

//   @override
//   Future<bool> checkCredentials(String username, String password) {
//     return Future.sync(() => false);
//   }

//   @override
//   Future<Map<String, List<SubjectEntity>>> getAcademicPerfomance(
//       String username, String password) {
//     return storage.get('');
//   }

//   @override
//   Future<List<PaymentEntity>> getPayments(String username, String password) {
//     // TODO: implement getPayments
//     throw UnimplementedError();
//   }

//   @override
//   Future<Map<String, String>> whoami(String username, String password) {
//     // TODO: implement whoami
//     throw UnimplementedError();
//   }
// }
