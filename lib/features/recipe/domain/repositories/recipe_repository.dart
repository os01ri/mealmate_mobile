import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../data/models/index_recipes_response_model.dart';
import '../../data/models/show_recipe_response_model.dart';
import '../entities/recipe.dart';

abstract class RecipeRepository {
  Future<Either<Failure, IndexRecipesResponseModel>> indexRecipes({ParamsMap params});

  Future<Either<Failure, ShowRecipeResponseModel>> showRecipe({required int id});

  Future<Either<Failure, Unit>> addRecipe({required Recipe recipe});

  Future<Either<Failure, Unit>> deleteRecipe({required int id});
}
