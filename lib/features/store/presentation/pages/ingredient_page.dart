import 'package:flutter/material.dart';
import 'package:mealmate/core/extensions/context_extensions.dart';
import 'package:mealmate/core/extensions/widget_extensions.dart';
import 'package:mealmate/core/helper/app_config.dart';
import 'package:mealmate/core/helper/assets_paths.dart';
import 'package:mealmate/core/ui/font/typography.dart';
import 'package:mealmate/core/ui/theme/colors.dart';
import 'package:mealmate/core/ui/widgets/main_button.dart';
import 'package:mealmate/features/recipe/presentation/widgets/app_bar.dart';

part '../widgets/header_image.dart';
part '../widgets/ingredient_budget_card.dart';

class IngredientPage extends StatefulWidget {
  const IngredientPage({super.key});

  @override
  State<IngredientPage> createState() => _IngredientPageState();
}

class _IngredientPageState extends State<IngredientPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RecipeAppBar(
        context: context,
        title: 'Tomato',
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              PngPath.saveInactive,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const _HeaderImage(),
              const _RecipeBudget().paddingVertical(8),
              const _IngredientList().expand(),
            ],
          ).expand(),
          MainButton(
            color: AppColors.buttonColor,
            onPressed: () {},
            width: context.width,
            text: 'Add To Cart',
          ).paddingHorizontal(8).hero('button'),
        ],
      ).padding(AppConfig.pagePadding),
    );
  }
}

class _IngredientList extends StatelessWidget {
  const _IngredientList();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (int i = 0; i < 6; i++)
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Calories $i',
                style: const TextStyle().normalFontSize.semiBold,
              ),
              const Spacer(),
              const Text(
                '250 KCal',
                style: TextStyle(),
              ),
              Icon(
                switch (i) {
                  <= 2 => Icons.check_circle_outline_rounded,
                  _ => Icons.warning_amber_rounded,
                },
                color: switch (i) {
                  <= 2 => Colors.green,
                  _ => Colors.red,
                },
              ).paddingHorizontal(5),
            ],
          ).paddingAll(8),
      ],
    );
  }
}