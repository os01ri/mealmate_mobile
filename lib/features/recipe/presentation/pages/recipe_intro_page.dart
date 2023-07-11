import 'package:flutter/material.dart';
import 'package:mealmate/core/ui/widgets/cache_network_image.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/routing_extensions.dart';
import '../../../../core/extensions/widget_extensions.dart';
import '../../../../core/helper/app_config.dart';
import '../../../../core/helper/assets_paths.dart';
import '../../../../core/localization/localization_class.dart';
import '../../../../core/ui/font/typography.dart';
import '../../../../core/ui/theme/colors.dart';
import '../../../../core/ui/widgets/main_button.dart';
import '../../data/models/recipe_model.dart';
import '../widgets/app_bar.dart';
import '../../../../dependency_injection.dart';
import '../../../../router/routes_names.dart';

class RecipeIntroPage extends StatelessWidget {
  const RecipeIntroPage({super.key, required this.recipe});
  final RecipeModel recipe;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RecipeAppBar(context: context, actions: [], title: 'كيف تصنع ${recipe.name} !'),
      body: Column(
        children: [
          CachedNetworkImage(
            url: recipe.url!,
            height: context.height * .25,
            fit: BoxFit.fitWidth,
            borderRadius: BorderRadius.circular(10),
            width: context.width,
          ).hero('picture'),
          Column(
            children: [
              const SizedBox(height: 15),
              Row(
                children: [
                  const Icon(
                    Icons.star_rate_rounded,
                    color: AppColors.yellow,
                  ),
                  Text(
                    '4.5',
                    style: const TextStyle().normalFontSize.semiBold,
                  ).paddingHorizontal(5),
                  Text(
                    '(300 ${serviceLocator<LocalizationClass>().appLocalizations!.reviews})',
                    style: const TextStyle(color: Colors.black54).normalFontSize.regular,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Image.asset(PngPath.user),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'روبيرتا آني',
                        style: const TextStyle().normalFontSize.semiBold,
                      ).paddingHorizontal(5),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            color: AppColors.mainColor,
                          ),
                          Text(
                            'بالي، إندونيسيا',
                            style: const TextStyle(color: Colors.black54).normalFontSize.regular,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  MainButton(
                    text: 'Follow',
                    width: context.width * .18,
                    color: AppColors.mainColor,
                    onPressed: () {},
                  ),
                ],
              ),
              Text(
                recipe.description!,
                style: const TextStyle().normalFontSize.regular,
              ).paddingVertical(15),
              const SizedBox(height: 15),
            ],
          ).paddingAll(15),
        ],
      ).padding(AppConfig.pagePadding).scrollable(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: MainButton(
        text: serviceLocator<LocalizationClass>().appLocalizations!.next,
        color: AppColors.mainColor,
        width: context.width,
        onPressed: () {
          context.pushNamed(RoutesNames.recipeDetails, extra: recipe.id);
        },
      ).paddingHorizontal(8).padding(AppConfig.pagePadding).hero('button'),
    );
  }
}

// @Deprecated('')
// class _NewWidget extends StatelessWidget {
//   const _NewWidget();

//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       slivers: [
//         TransitionAppBar(
//           extent: 320,
//           avatar: Container(
//             decoration: BoxDecoration(
//               borderRadius: AppConfig.borderRadius,
//               image: const DecorationImage(
//                 image: AssetImage(PngPath.food),
//                 fit: BoxFit.fitWidth,
//               ),
//             ),
//           ).hero('picture'),
//           title: Text(
//             'How to make french toast',
//             style: const TextStyle().largeFontSize.extraBold,
//           ),
//         ),
//         SliverList(
//           delegate: SliverChildListDelegate(
//             [
//               SizedBox(
//                 height: MediaQuery.of(context).size.height,
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 15),
//                     Row(
//                       children: [
//                         const Icon(
//                           Icons.star_rate_rounded,
//                           color: AppColors.yellow,
//                         ),
//                         Text(
//                           '4.5',
//                           style: const TextStyle().normalFontSize.semiBold,
//                         ).paddingHorizontal(5),
//                         Text(
//                           '(300 Reviews)',
//                           style: const TextStyle(color: Colors.black54).normalFontSize.regular,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 15),
//                     Row(
//                       children: [
//                         Image.asset(PngPath.user),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Roberta Anny',
//                               style: const TextStyle().normalFontSize.semiBold,
//                             ).paddingHorizontal(5),
//                             Row(
//                               children: [
//                                 const Icon(
//                                   Icons.location_on_rounded,
//                                   color: AppColors.mainColor,
//                                 ),
//                                 Text(
//                                   'Bali, Indonesia',
//                                   style: const TextStyle(color: Colors.black54).normalFontSize.regular,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         const Spacer(),
//                         MainButton(
//                           text: 'Follow',
//                           width: context.width * .18,
//                           color: AppColors.mainColor,
//                           onPressed: () {},
//                         ),
//                       ],
//                     ),
//                     Text(
//                       'Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum numquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentium optio, eaque rerum! Provident similique accusantium nemo autem. Veritatis obcaecati tenetur iure eius earum ut molestias architecto voluptate aliquam nihil, eveniet aliquid culpa officia aut! Impedit sit sunt quaerat, odit, tenetur error, harum nesciunt ipsum debitis quas aliquid. Reprehenderit, quia. Quo neque error repudiandae fuga? Ipsa laudantium molestias eos sapiente officiis modi at sunt excepturi expedita sint? Sed quibusdam recusandae alias error harum maxime adipisci amet laborum. Perspiciatis minima nesciunt dolorem! Officiis iure rerum voluptates a cumque velit',
//                       style: const TextStyle().normalFontSize.regular,
//                     ).paddingVertical(15),
//                     const SizedBox(height: 15),
//                   ],
//                 ).paddingAll(15),
//               )
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
