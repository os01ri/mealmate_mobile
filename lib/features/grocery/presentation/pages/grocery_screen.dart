import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/widget_extensions.dart';
import '../../../../core/ui/theme/colors.dart';
import '../../../../core/ui/ui_messages.dart';
import '../../../../core/ui/widgets/cache_network_image.dart';
import '../../../../core/ui/widgets/loading_widget.dart';
import '../../../recipe/presentation/widgets/app_bar.dart';

import '../../data/models/index_grocery_response_model.dart';
import '../cubit/grocery_cubit.dart';

class GroceryPage extends StatefulWidget {
  const GroceryPage({super.key});

  @override
  State<GroceryPage> createState() => GroceryPageState();
}

class GroceryPageState extends State<GroceryPage> {
  late final GroceryCubit _groceryCubit;
  @override
  void initState() {
    _groceryCubit = GroceryCubit();
    _groceryCubit.getGroceryItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: RecipeAppBar(
        context: context,
        centerText: true,
        actions: const [],
        title: "Your Grocery",
      ),
      body: BlocProvider(
        create: (context) => _groceryCubit,
        child: BlocConsumer<GroceryCubit, GroceryState>(
          listener: (context, state) {
            if (state.deleteGroceryItemStatus ==
                DeleteGroceryItemStatus.loading) {
              Toaster.showLoading();
            }
            if (state.deleteGroceryItemStatus == DeleteGroceryItemStatus.init ||
                state.deleteGroceryItemStatus ==
                    DeleteGroceryItemStatus.success) {
              Toaster.closeLoading();
            }
            if (state.deleteGroceryItemStatus ==
                DeleteGroceryItemStatus.failed) {
              Toaster.closeLoading();
              Toaster.showToast('try again');
            }
          },
          bloc: _groceryCubit,
          builder: (context, state) {
            return state.status == GroceryStatus.success
                ? Container(
                    color: AppColors.mainColor.withOpacity(.1),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            height: context.height * .47,
                            child: ListView.builder(
                              itemCount: state.cartItems.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: GroceryItemWidget(
                                    item: state.cartItems[index],
                                    onAdd: () {},
                                    onRemove: () {},
                                    onDelete: () {
                                      _groceryCubit.deleteGroceryItem(
                                          state.cartItems[index].id!);
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ]),
                  )
                : state.status == GroceryStatus.failed
                    ? SizedBox.shrink()
                    : LoadingWidget();
          },
        ),
      ),
    );
  }
}

class GroceryItemWidget extends StatefulWidget {
  const GroceryItemWidget({
    super.key,
    required this.item,
    required this.onAdd,
    required this.onRemove,
    required this.onDelete,
  });

  final IndexGroceryDataModel item;
  final VoidCallback onAdd, onDelete, onRemove;

  @override
  State<GroceryItemWidget> createState() => _GroceryItemWidgetState();
}

class _GroceryItemWidgetState extends State<GroceryItemWidget> {
  @override
  void initState() {
    log('${widget.item..ingredient!.name}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Row(
        children: [
          CachedNetworkImage(
            hash: widget.item.ingredient!.hash ?? '',
            url: widget.item.ingredient!.url ?? '',
            fit: BoxFit.fitHeight,
            width: context.width * .2,
            height: context.width * .2,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.item.ingredient!.name ?? "Ingredients"),
              Text(
                  '${(widget.item.quantity! * widget.item.ingredient!.priceBy!)} ${widget.item.unit!.code}'),
              // Text(
              // "total ${widget.item.ingredient!.priceBy! * widget.item.ingredient!.quantity} ${widget.item.ingredient!.unit!.code}"),
            ],
          ),
          const Spacer(),
          FittedBox(
            fit: BoxFit.fitHeight,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              height: context.height * .08,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.delete_outline,
                    color: AppColors.mainColor,
                    size: context.height * .03,
                  ).onTap(() => widget.onDelete()),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     const Icon(
                  //       Icons.add,
                  //       color: AppColors.mainColor,
                  //     ).onTap(() => widget.onAdd()),
                  //     Container(
                  //       width: context.width * .2,
                  //       height: context.height * .03,
                  //       color: AppColors.mainColor,
                  //       padding: const EdgeInsets.all(4),
                  //       child: FittedBox(
                  //         fit: BoxFit.contain,
                  //         child: Text(
                  //           "${widget.item.ingredient!.id}",
                  //           style: AppTextStyles.styleWeight600(
                  //               fontSize: 22, color: Colors.white),
                  //         ),
                  //       ),
                  //     ),
                  //     const Icon(Icons.remove).onTap(() => widget.onRemove()),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
