import 'package:cloud_user/core/models/service_model.dart';
import 'package:cloud_user/features/home/data/home_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'services_provider.g.dart';

@riverpod
Future<List<ServiceModel>> services(ServicesRef ref, {String? categoryId}) {
  // Mock logic - in a real app, pass categoryId to the repository
  return ref.watch(homeRepositoryProvider).getPopularServices();
}
