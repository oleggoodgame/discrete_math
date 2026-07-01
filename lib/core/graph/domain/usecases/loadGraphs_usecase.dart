import 'package:discrete_math/core/graph/domain/repostiory/graph_repository.dart';

class LoadgraphsUsecase {
  final GraphRepository graphRepository;
  LoadgraphsUsecase({required this.graphRepository});
  Future<void> call()async{
    await graphRepository.getAllGraphs();
  }
}