import 'package:find_resto/base/state_converter.dart';
import 'package:find_resto/domain/entities/restaurant_entity.dart';
import 'package:find_resto/helper/image_asset_helper.dart';
import 'package:find_resto/presentation/detail/restaurant_detail_screen.dart';
import 'package:find_resto/presentation/list/restaurant_list_bloc.dart';
import 'package:find_resto/presentation/views/empty_view.dart';
import 'package:find_resto/presentation/views/foundation/app_text_style.dart';
import 'package:find_resto/presentation/views/foundation/color_palette.dart';
import 'package:find_resto/presentation/views/restaurant_card.dart';
import 'package:find_resto/presentation/views/shimmer_view.dart';
import 'package:flutter/material.dart';

class RestaurantListScreen extends StatefulWidget {
  @override
  _RestaurantListScreenState createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  final _bloc = RestaurantListBloc();
  final _searchTextController = TextEditingController();

  @override
  void initState() {
    _bloc.searchRestaurant();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    _searchTextController.dispose();
    super.dispose();
  }

  void searchRestaurant() {
    _bloc.searchRestaurant();
    FocusManager.instance.primaryFocus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            _buildHeaders(),
            _buildSearchTextField(),
            _buildRestaurantStreamBuilder(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaders() {
    return Column(
      children: [
        SizedBox(height: 24.0),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today Find\nSpecial Resto For You',
                  style: AppTextStyle.heading(),
                ),
              ],
            ),
            Spacer(),
            CircleAvatar(
              backgroundImage:
                  AssetImage(ImageAssetHelper.getImagePath('ic_profile')),
            ),
          ],
        ),
        SizedBox(height: 20.0),
      ],
    );
  }

  Widget _buildSearchTextField() {
    return Card(
      elevation: 4.0,
      shadowColor: ColorPalette.shadowColor,
      margin: const EdgeInsets.only(bottom: 20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: TextField(
          controller: _searchTextController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search for restaurants',
            labelStyle: AppTextStyle.body(),
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                searchRestaurant();
              },
            ),
          ),
          textInputAction: TextInputAction.search,
          onEditingComplete: () {
            searchRestaurant();
          },
          onChanged: (String text) => _bloc.setQueryText(text),
        ),
      ),
    );
  }

  Widget _buildRestaurantStreamBuilder() {
    return StreamBuilder(
      stream: _bloc.restaurantsStream,
      builder: (
        BuildContext context,
        AsyncSnapshot<StateConverter<List<RestaurantEntity>>> snapshot,
      ) {
        try {
          final state = snapshot.data;

          if (state.isLoading) {
            return _buildShimmerColumn();
          } else if (state.data.isNotEmpty) {
            return _buildRestaurantCardList(context, state.data);
          } else {
            return _buildEmptySearch();
          }
        } catch (error) {
          return SizedBox();
        }
      },
    );
  }

  Widget _buildRestaurantCardList(
    BuildContext context,
    List<RestaurantEntity> restaurants,
  ) {
    return Column(
      children: restaurants
          .map(
            (restaurant) => RestaurantCard(
              title: restaurant.name,
              description: restaurant.location?.address ?? '',
              ratingText: restaurant.userRating?.ratingFormatted,
              imageUrl: restaurant.thumbnailUrl,
              margin: const EdgeInsets.only(bottom: 12.0),
              onTap: () {
                if (restaurant.id.isNotEmpty) {
                  Navigator.pushNamed(context, RestaurantDetailScreen.route,
                      arguments: int.parse(restaurant.id));
                }
              },
            ),
          )
          .toList(),
    );
  }

  Widget _buildShimmerColumn() {
    List<Widget> shimmerViews = [];

    for (int index = 0; index <= 4; index++) {
      shimmerViews.add(_buildShimmerRestaurantCard());
    }

    return Column(
      children: shimmerViews,
    );
  }

  Widget _buildShimmerRestaurantCard() {
    return Card(
      elevation: 4.0,
      shadowColor: ColorPalette.shadowColor,
      margin: const EdgeInsets.only(bottom: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ShimmerView(
              width: 80.0,
              height: 80.0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerView(
                      width: double.infinity,
                      height: 12.0,
                    ),
                    SizedBox(height: 4.0),
                    ShimmerView(
                      width: double.infinity,
                      height: 32.0,
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        ShimmerView(
                          width: 100.0,
                          height: 12.0,
                        ),
                        Spacer(),
                        ShimmerView(
                          width: 40.0,
                          height: 12.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptySearch() {
    return Container(
      margin: const EdgeInsets.only(top: 50.0, left: 24.0, right: 24.0),
      child: EmptyView(
        imageName: 'ic_empty_search',
        title: 'Restaurant Not Found',
        message: 'Search with other keywords to find your special restaurant',
      ),
    );
  }
}
