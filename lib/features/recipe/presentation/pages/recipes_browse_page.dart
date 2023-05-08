import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/routing_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/helper/app_config.dart';
import 'package:mealmate/core/ui/assets_paths.dart';
import 'package:mealmate/core/ui/font/typography.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/widgets/main_text_field.dart';
import 'package:mealmate/features/main/main_page.dart';
import 'package:mealmate/features/recipe/presentation/widgets/app_bar.dart';
import 'package:mealmate/router/app_routes.dart';

class RecipesBrowsePage extends StatelessWidget {
  const RecipesBrowsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RecipeAppBar(context: context, leadingWidget: SizedBox()),
      body: Column(
        children: [
          Row(
            children: [
              MainTextField(
                controller: TextEditingController(),
                hint: 'Search Recipes',
                prefixIcon: const Icon(Icons.search_rounded),
              ).paddingVertical(15).expand(),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.buttonColor,
                  borderRadius: AppConfig.borderRadius,
                ),
                width: context.width * .1,
                height: context.width * .1,
                child: const Icon(
                  Icons.filter_alt,
                  color: Colors.white,
                ),
              ).paddingHorizontal(5),
            ],
          ),
          SizedBox(
            height: context.height * .25,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                10,
                (index) => FittedBox(
                  fit: BoxFit.fitHeight,
                  child: GestureDetector(
                    onTap: () {
                      context.push(Routes.recipeIntro);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.asset(
                              PngPath.food,
                              height: context.height * .16,
                              fit: BoxFit.fitHeight,
                            ).hero(index == 0 ? 'picture' : '$index'),
                          ),
                          SizedBox(
                            width: context.width * .3,
                            child: Text(
                              'Indonesian chicken burger',
                              softWrap: true,
                              style: const TextStyle().normalFontSize.bold,
                            ),
                          ),
                          SizedBox(
                            width: context.width * .3,
                            child: Text(
                              'By Adrianna Curl',
                              style: const TextStyle(
                                      color: AppColors.lightTextColor)
                                  .smallFontSize
                                  .semiBold,
                            ),
                          ),
                        ],
                      ),
                    ).paddingHorizontal(8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ).padding(AppConfig.pagePadding),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.buttonColor,
        child: const Icon(Icons.create),
        onPressed: () {
          context.push(Routes.recipeCreatePage);
        },
      ),
    );
  }
}