import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/unified_api/handling_exception_manager.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../datasources/remote_recipe_datasource.dart';
import '../models/index_recipes_response_model.dart';
import '../models/show_recipe_response_model.dart';

class RecipeRepositoryImpl with HandlingExceptionManager implements RecipeRepository {
  @override
  Future<Either<Failure, IndexRecipesResponseModel>> indexRecipes({ParamsMap params}) {
    return wrapHandling(
      tryCall: () async {
        final result = await RemoteRecipeDatasource.indexRecipes(params: params);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<Failure, ShowRecipeResponseModel>> showRecipe({required int id}) {
    return wrapHandling(tryCall: () async {
      final result = await RemoteRecipeDatasource.showRecipe(id);
      return Right(result);
    });
  }

  @override
  Future<Either<Failure, Unit>> addRecipe({required Recipe recipe}) {
    // TODO: implement addRecipe
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deleteRecipe({required int id}) {
    // TODO: implement deleteRecipe
    throw UnimplementedError();
  }
}
