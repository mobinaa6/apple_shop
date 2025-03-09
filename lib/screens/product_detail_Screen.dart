// ignore_for_file: file_names

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_shop/bloc/basket/basket_bloc.dart';
import 'package:flutter_ecommerce_shop/bloc/basket/basket_event.dart';
import 'package:flutter_ecommerce_shop/bloc/comment/comment_bloc.dart';
import 'package:flutter_ecommerce_shop/bloc/comment/comment_event.dart';
import 'package:flutter_ecommerce_shop/bloc/comment/comment_state.dart';
import 'package:flutter_ecommerce_shop/bloc/product/product_bloc.dart';
import 'package:flutter_ecommerce_shop/bloc/product/product_event.dart';
import 'package:flutter_ecommerce_shop/bloc/product/product_state.dart';
import 'package:flutter_ecommerce_shop/constants/colors.dart';
import 'package:flutter_ecommerce_shop/data/model/product.dart';
import 'package:flutter_ecommerce_shop/data/model/product_image.dart';
import 'package:flutter_ecommerce_shop/data/model/product_properties.dart';
import 'package:flutter_ecommerce_shop/data/model/product_variant.dart';
import 'package:flutter_ecommerce_shop/data/model/variant_type.dart';
import 'package:flutter_ecommerce_shop/di/di.dart';
import 'package:flutter_ecommerce_shop/util/extentions/double_extention.dart';
import 'package:flutter_ecommerce_shop/widgets/cached_Image.dart';
import 'package:flutter_ecommerce_shop/widgets/loading_animatin.dart';

import '../data/model/variant.dart';

// ignore: must_be_immutable
class productDetailScreen extends StatefulWidget {
  Product product;
  productDetailScreen(this.product, {super.key});

  @override
  State<productDetailScreen> createState() => _productDetailScreenState();
}

class _productDetailScreenState extends State<productDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var bloc = ProductBloc();

        bloc.add(
          ProductinitializeEvent(
            widget.product.id,
            widget.product.categoryId,
          ),
        );
        return bloc;
      },
      child: DetailContentWidget(parentWidget: widget),
    );
  }
}

class DetailContentWidget extends StatelessWidget {
  DetailContentWidget({
    super.key,
    required this.parentWidget,
  });

  final productDetailScreen parentWidget;
  var postioned = 0.0;
  var imageProfile =
      Image.asset('images/icon_profile_comment.png', color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        if (state is ProductLoadingState) {
          return const Center(
            child: LoadingAnimation(),
          );
        } else if (state is ProductDetailRequestSuccessState) {
          return SafeArea(
              child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 35, right: 35, bottom: 32, top: 15),
                  child: Container(
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 16,
                        ),
                        Image.asset('images/icon_apple_blue.png'),
                        Expanded(
                            child: state.ProductCategory.fold((l) {
                          return const Text(
                            'جزِئیات محصول',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'SB',
                              fontSize: 16,
                              color: CustomColors.blue,
                            ),
                          );
                        }, (productCategory) {
                          return Text(
                            productCategory.title!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'SB',
                              fontSize: 16,
                              color: CustomColors.blue,
                            ),
                          );
                        })),
                        ///////////////////
                        ///Text(
                        ///Text(

                        Image.asset(
                          'images/icon_back.png',
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    parentWidget.product.name,
                    style: const TextStyle(
                        fontFamily: 'SB', fontSize: 16, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              state.ProductImageList.fold((exceptionError) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(exceptionError),
                  ),
                );
              }, (ProductImageList) {
                return GalleryWidget(
                    ProductImageList, parentWidget.product.thumbnail);
              }),
              /////////////////////////////
              state.ProductVariant.fold((exceptionError) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(exceptionError),
                  ),
                );
              }, (ProductVariantList) {
                return VariantContainerGenerator(ProductVariantList);
              }),
              //
              if (state is ProductDetailRequestSuccessState) ...{
                state.productProperties.fold((exception) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(exception),
                    ),
                  );
                }, (properties) {
                  return ProductpropertiesContainer(properties);
                }),
                ProductDescription(parentWidget.product.description),
                SliverToBoxAdapter(
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        isDismissible: true,
                        showDragHandle: true,
                        useSafeArea: true,
                        backgroundColor: CustomColors.backgroundScreenColor,
                        context: context,
                        builder: (context) {
                          return BlocProvider(
                            create: (context) {
                              final bloc = CommentBloc(locator.get());
                              bloc.add(CommentInitializeEvent(
                                  parentWidget.product.id));
                              return bloc;
                            },
                            child: CommentBottomsheet(parentWidget.product.id),
                          );
                        },
                      );
                    },
                    child: Container(
                      margin:
                          const EdgeInsets.only(top: 24, left: 44, right: 44),
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 1,
                          color: CustomColors.grey,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Image.asset('images/icon_left_category.png'),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'مشاهده',
                              style: TextStyle(
                                  fontFamily: 'SB',
                                  fontSize: 12,
                                  color: CustomColors.blue),
                            ),
                            const Spacer(),
                            state.commentList.fold((exception) {
                              return Center(
                                child: Text(exception),
                              );
                            }, (commentList) {
                              postioned = commentList.length <= 4
                                  ? commentList.length * 15
                                  : 65;
                              return Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  if (commentList.isNotEmpty) ...{
                                    Container(
                                      height: 26,
                                      width: 26,
                                      margin: const EdgeInsets.only(left: 8),
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: commentList[0].avatar.isEmpty
                                          ? imageProfile
                                          : CachedImage(
                                              ImageUrl: commentList[0]
                                                  .userThumbnailUrl),
                                    ),
                                    if (commentList.length >= 2) ...{
                                      Positioned(
                                        right: 15,
                                        child: Container(
                                          height: 26,
                                          width: 26,
                                          margin:
                                              const EdgeInsets.only(left: 8),
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: commentList[1].avatar.isEmpty
                                              ? Image.asset(
                                                  'images/icon_profile_comment.png',
                                                  color: Colors.white,
                                                )
                                              : CachedImage(
                                                  ImageUrl: commentList[1]
                                                      .userThumbnailUrl),
                                        ),
                                      ),
                                    },
                                    if (commentList.length >= 3) ...{
                                      Positioned(
                                        right: 30,
                                        child: Container(
                                          height: 26,
                                          width: 26,
                                          margin:
                                              const EdgeInsets.only(left: 8),
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: commentList[2].avatar.isEmpty
                                              ? imageProfile
                                              : CachedImage(
                                                  ImageUrl: commentList[2]
                                                      .userThumbnailUrl),
                                        ),
                                      ),
                                    },
                                    if (commentList.length >= 4) ...{
                                      Positioned(
                                        right: 45,
                                        child: Container(
                                          height: 26,
                                          width: 26,
                                          margin:
                                              const EdgeInsets.only(left: 8),
                                          decoration: BoxDecoration(
                                              color: Colors.amber[600],
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: commentList[3].avatar.isEmpty
                                              ? imageProfile
                                              : CachedImage(
                                                  ImageUrl: commentList[3]
                                                      .userThumbnailUrl),
                                        ),
                                      ),
                                    },
                                    Positioned(
                                      right: postioned,
                                      child: Container(
                                        height: 26,
                                        width: 26,
                                        margin: const EdgeInsets.only(left: 8),
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Center(
                                          child: Text(
                                            commentList.length > 10
                                                ? '10+'
                                                : commentList.length.toString(),
                                            style: const TextStyle(
                                                fontFamily: 'SB',
                                                fontSize: 12,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  } else ...{
                                    const Text(
                                      'no comment',
                                      style: TextStyle(
                                          color: CustomColors.blue,
                                          fontWeight: FontWeight.w500),
                                    )
                                  }
                                ],
                              );
                            }),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'نظرات کاربران',
                              style: TextStyle(
                                  fontFamily: 'SM', color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      right: 38,
                      left: 44,
                      bottom: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PriceTagButton(parentWidget.product),
                        AddToBasketButton(parentWidget.product),
                      ],
                    ),
                  ),
                ),
              },
            ],
          ));
        } else {
          return const Center(
            child: Text('خطایی در دریافت اطلاعات به وجود آمده است'),
          );
        }
      }),
    );
  }
}

class CommentBottomsheet extends StatefulWidget {
  const CommentBottomsheet(
    this.productID, {
    super.key,
  });
  final String productID;
  @override
  State<CommentBottomsheet> createState() => _CommentBottomsheetState();
}

class _CommentBottomsheetState extends State<CommentBottomsheet> {
  final TextEditingController _textEditingController = TextEditingController();
  bool isvisible = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        if (state is CommentLoadingState) {
          return const Center(
            child: LoadingAnimation(),
          );
        }
        return Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  if (state is CommentRequestSuccessState) ...{
                    state.commentList.fold((exception) {
                      ////// show message when error
                      return const SliverToBoxAdapter(
                        child: Center(
                          child: Text('خطایی در دریافت نظرات پیش امده '),
                        ),
                      );
                    }, (commetnList) {
                      if (commetnList.isEmpty) {
                        // show message when comment is empty
                        return const SliverPadding(
                          padding: EdgeInsets.only(top: 180),
                          sliver: SliverToBoxAdapter(
                              child: Center(
                            child: Text(
                              'نظری برای این محصول ثبت نشده',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'sb',
                                color: Colors.black,
                              ),
                            ),
                          )),
                        );
                      }
                      return SliverList(
                        //show liast comment
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(16.0),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          //show another name when name user is empty
                                          (commetnList[index].username.isEmpty)
                                              ? 'کاربر'
                                              : commetnList[index].username,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          commetnList[index].text,
                                          textAlign: TextAlign.end,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  (commetnList[index].avatar.isEmpty)
                                      // show another image when image profile is empty
                                      ? SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: Image.asset(
                                              'images/icon_profile_comment.png'),
                                        )
                                      : SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: CachedImage(
                                            ImageUrl: commetnList[index]
                                                .userThumbnailUrl,
                                          ),
                                        ),
                                ],
                              ),
                            );
                          },
                          childCount: commetnList.length,
                        ),
                      );
                    })
                  }
                ],
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  right: 16,
                  left: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  children: [
                    ////////text filed for post comment
                    TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 3,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: CustomColors.blue,
                            width: 3,
                          ),
                        ),
                      ),
                    ),

                    if (state is CommentPostResponseState) ...{
                      state.response.fold((exception) {
                        // show toast error for post comment no success
                        // Fluttertoast.showToast(
                        //     msg: exception,
                        //     toastLength: Toast.LENGTH_SHORT,
                        //     gravity: ToastGravity.CENTER,
                        //     timeInSecForIosWeb: 1,
                        //     textColor: Colors.white,
                        //     fontSize: 16.0);
                        return const Text('');
                      }, (textResult) {
                        // show toast for post commet success
                        // Fluttertoast.showToast(
                        //     msg: textResult,
                        //     toastLength: Toast.LENGTH_SHORT,
                        //     gravity: ToastGravity.CENTER,
                        //     timeInSecForIosWeb: 1,
                        //     textColor: Colors.white,
                        //     fontSize: 16.0);
                        return const Text('');
                      })
                    },
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 12,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          //send event to bloc when text field is not empty
                          if (_textEditingController.text.isNotEmpty) {
                            context.read<CommentBloc>().add(
                                  CommentPostEvent(
                                    widget.productID,
                                    _textEditingController.text,
                                  ),
                                );
                            _textEditingController.text = '';
                          } else {
                            // Fluttertoast.showToast(
                            //     msg: 'لطفا متنی را وارد کنید',
                            //     toastLength: Toast.LENGTH_SHORT,
                            //     gravity: ToastGravity.CENTER,
                            //     timeInSecForIosWeb: 1,
                            //     textColor: Colors.white,
                            //     fontSize: 16.0);
                          }
                        },
                        // button افزودن نظر محصول
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              height: 62,
                              decoration: BoxDecoration(
                                color: CustomColors.blue,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: const SizedBox(
                                  height: 53,
                                  child: Center(
                                      child: Text(
                                    //show message defult
                                    'افزودن نظر محصول',
                                    style: TextStyle(
                                      fontFamily: 'SB',
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  )),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ProductpropertiesContainer extends StatefulWidget {
  List<Property> productProperties;
  ProductpropertiesContainer(
    this.productProperties, {
    Key? key,
  }) : super(key: key);

  @override
  State<ProductpropertiesContainer> createState() =>
      _ProductpropertiesContainerState();
}

class _ProductpropertiesContainerState
    extends State<ProductpropertiesContainer> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(top: 24, left: 44, right: 44),
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1,
                  color: CustomColors.grey,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Image.asset('images/icon_left_category.png'),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'مشاهده',
                      style: TextStyle(
                          fontFamily: 'SB',
                          fontSize: 12,
                          color: CustomColors.blue),
                    ),
                    const Spacer(),
                    const Text('مشخصات فنی',
                        style: TextStyle(fontFamily: 'sm', fontSize: 14)),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: Container(
              margin: const EdgeInsets.only(top: 24, left: 44, right: 44),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1,
                  color: CustomColors.grey,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.productProperties.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          '${widget.productProperties[index].value} :${widget.productProperties[index].title}',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                              fontFamily: 'sm', height: 1.8, fontSize: 16),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDescription extends StatefulWidget {
  String productDescription;

  ProductDescription(
    this.productDescription, {
    Key? key,
  }) : super(key: key);

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(top: 24, left: 44, right: 44),
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1,
                  color: CustomColors.grey,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Image.asset('images/icon_left_category.png'),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'مشاهده',
                      style: TextStyle(
                          fontFamily: 'SB',
                          fontSize: 12,
                          color: CustomColors.blue),
                    ),
                    const Spacer(),
                    const Text(
                      'توضیحات محصول',
                      style: TextStyle(fontFamily: 'SM', color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: Container(
              margin: const EdgeInsets.only(top: 24, left: 44, right: 50),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1,
                  color: CustomColors.grey,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                widget.productDescription,
                textAlign: TextAlign.right,
                style: const TextStyle(
                    fontFamily: 'sm', height: 1.8, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VariantContainerGenerator extends StatelessWidget {
  final List<Productvariant> productVariantList;

  VariantContainerGenerator(
    this.productVariantList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Column(
      children: [
        for (var ProductVariant in productVariantList) ...{
          if (ProductVariant.variantList.isNotEmpty) ...{
            VariantGeneratorChild(ProductVariant)
          }
        }
      ],
    ));
  }
}

class VariantGeneratorChild extends StatelessWidget {
  Productvariant _productvariant;
  VariantGeneratorChild(this._productvariant, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28, right: 48, left: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            _productvariant.variantype.title!,
            style: const TextStyle(
              fontFamily: 'Sm',
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          if (_productvariant.variantype.type == VariantTypeEnum.COLOR) ...{
            ColorVariantList(_productvariant.variantList)
          },
          if (_productvariant.variantype.type == VariantTypeEnum.STORAGE) ...{
            StorageVarinatList(_productvariant.variantList)
          },
        ],
      ),
    );
  }
}

class GalleryWidget extends StatefulWidget {
  final List<ProductImage> productImageList;
  String? defaultProductThumbnail;
  int _selectedIndex = 0;

  GalleryWidget(
    this.productImageList,
    this.defaultProductThumbnail, {
    Key? key,
  }) : super(key: key);

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 44),
        child: Container(
          height: 284,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 14, right: 14, top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset('images/icon_star.png'),
                          const SizedBox(
                            width: 3,
                          ),
                          const Text(
                            '4.5',
                            style: TextStyle(
                              fontFamily: 'Sm',
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: CachedImage(
                            ImageUrl: widget.productImageList.isNotEmpty
                                ? widget.productImageList[widget._selectedIndex]
                                    .imageUrl!
                                : widget.defaultProductThumbnail!),
                      ),
                      const Spacer(),
                      Image.asset('images/icon_favorite_deactive.png')
                    ],
                  ),
                ),
              ),
              if (widget.productImageList.isNotEmpty) ...{
                SizedBox(
                  height: 70,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 44, right: 44, top: 10),
                    child: ListView.builder(
                      itemCount: widget.productImageList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                widget._selectedIndex = index;
                              });
                            },
                            child: Container(
                              height: 70,
                              width: 70,
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: CustomColors.grey,
                                ),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: CachedImage(
                                      radius: 15,
                                      ImageUrl: widget
                                          .productImageList[index].imageUrl!)),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              }
            ],
          ),
        ),
      ),
    );
  }
}

class AddToBasketButton extends StatelessWidget {
  Product product;
  AddToBasketButton(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 62,
          width: 140,
          decoration: BoxDecoration(
              color: CustomColors.blue,
              borderRadius: BorderRadius.circular(15)),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: GestureDetector(
              onTap: () {
                context
                    .read<ProductBloc>()
                    .add(ProductAddToBasketEvent(product));
                context.read<BasketBloc>().add(BasketFetchFromHiveEvent());
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(seconds: 1),
                    content: Text('محصول به سبد خرید اضافه شد'),
                  ),
                );
              },
              child: const SizedBox(
                height: 53,
                width: 146,
                child: Center(
                    child: Text(
                  'افزودن به سبد خرید',
                  style: TextStyle(
                    fontFamily: 'SB',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                )),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class PriceTagButton extends StatelessWidget {
  PriceTagButton(this._product, {super.key});
  Product _product;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      Container(
        height: 62,
        width: 135,
        decoration: BoxDecoration(
            color: CustomColors.green, borderRadius: BorderRadius.circular(15)),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 53,
            width: 160,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    'تومان',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'SM',
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _product.price.FormatPriceWithCommas(),
                        style: const TextStyle(
                          fontFamily: 'SM',
                          fontSize: 12,
                          color: Colors.white,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Text(
                        _product.realprice.FormatPriceWithCommas(),
                        style: const TextStyle(
                          fontFamily: 'SM',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                      child: Text(
                        '3%',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'SB',
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}

class ColorVariantList extends StatefulWidget {
  List<Variant> vaiantList;

  ColorVariantList(this.vaiantList, {super.key});

  @override
  State<ColorVariantList> createState() => _ColorVariantListState();
}

class _ColorVariantListState extends State<ColorVariantList> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 30,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.vaiantList.length,
          itemBuilder: (context, index) {
            String color = 'ff${widget.vaiantList[index].value}';
            int hexColor = int.parse(color, radix: 16);
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(2),
                height: 30,
                width: 30,
                margin: const EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  border: _selectedIndex == index
                      ? Border.all(
                          width: 1,
                          color: CustomColors.blueIndicator,
                          strokeAlign: BorderSide.strokeAlignOutside)
                      : Border.all(width: 2, color: Colors.white),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(hexColor),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class StorageVarinatList extends StatefulWidget {
  List<Variant> StorageVariant;
  StorageVarinatList(this.StorageVariant, {super.key});

  @override
  State<StorageVarinatList> createState() => _StorageVarinatListState();
}

class _StorageVarinatListState extends State<StorageVarinatList> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 26,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.StorageVariant.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: Container(
                height: 25,
                margin: const EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: _selectedIndex == index
                      ? Border.all(
                          color: CustomColors.blueIndicator,
                          width: 2,
                        )
                      : Border.all(
                          color: CustomColors.grey,
                          width: 1,
                        ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Text(
                      widget.StorageVariant[index].value!,
                      style: const TextStyle(
                        fontFamily: 'SB',
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
