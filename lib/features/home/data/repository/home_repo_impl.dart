import 'package:attendance_management_app/features/home/domain/repository/home_repository.dart';

import '../data_source/home_remote_data_source.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeDataSource dataSource;

  HomeRepoImpl(this.dataSource);

  @override
  Future getUpcomingClass() {
    return dataSource.fetchUpcomingClass();
  }
}
