import 'package:find_resto/base/state_converter.dart';
import 'package:find_resto/domain/entities/restaurant_entity.dart';
import 'package:find_resto/presentation/detail/restaurant_detail_bloc.dart';
import 'package:find_resto/presentation/views/foundation/app_text_style.dart';
import 'package:find_resto/presentation/views/foundation/color_palette.dart';
import 'package:find_resto/presentation/views/icon_text_view.dart';
import 'package:find_resto/presentation/views/image_loader_view.dart';
import 'package:find_resto/presentation/views/shimmer_view.dart';
import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatefulWidget {
  static const String route = '/restaurantDetail';
  final int restaurantId;

  RestaurantDetailScreen({Key key, this.restaurantId}) : super(key: key);

  @override
  _RestaurantDetailScreenState createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  final _bloc = RestaurantDetailBloc();
  final _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _bloc.setIsCollapseAppBar(_scrollController.offset > 140.0);
    });

    _bloc.getRestaurantById(widget.restaurantId);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _bloc.restaurantStream,
        builder: (
          BuildContext context,
          AsyncSnapshot<StateConverter<RestaurantEntity>> snapshot,
        ) {
          try {
            final state = snapshot.data;
            if (state.isLoading) {
              return _buildDetailShimmerView();
            } else {
              return _buildDetailNestedScroll(state.data);
            }
          } catch (error) {
            return SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildDetailNestedScroll(RestaurantEntity restaurant) {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          StreamBuilder(
            stream: _bloc.isCollapseAppBar,
            builder: (
              BuildContext context,
              AsyncSnapshot<bool> snapshot,
            ) {
              try {
                final isAppBarCollapse = snapshot.data ?? false;

                return SliverAppBar(
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: isAppBarCollapse
                          ? ColorPalette.gray900
                          : ColorPalette.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  floating: true,
                  pinned: true,
                  elevation: 4.0,
                  shadowColor: ColorPalette.white,
                  expandedHeight: 200.0,
                  title: Text(
                    isAppBarCollapse ? restaurant.name : '',
                    style: AppTextStyle.heading(),
                  ),
                  backgroundColor: ColorPalette.white,
                  flexibleSpace: FlexibleSpaceBar(
                    background:
                        _buildRestaurantImage(restaurant.featuredImageUrl),
                  ),
                );
              } catch (error) {
                return SizedBox();
              }
            },
          ),
        ];
      },
      body: _buildRestaurantDetail(restaurant),
    );
  }

  Widget _buildRestaurantImage(String imageUrl) {
    return ImageLoaderView(
      imageUrl: imageUrl,
      width: double.infinity,
      height: 250.0,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(24.0),
        bottomRight: Radius.circular(24.0),
      ),
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.transparent, Colors.black54],
      ),
    );
  }

  Widget _buildRestaurantDetail(RestaurantEntity restaurant) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                restaurant.name,
                style: AppTextStyle.heading(),
              ),
              SizedBox(height: 8.0),
              IconTextView(
                iconData: Icons.fastfood,
                iconSize: 16.0,
                text: restaurant.cuisines,
                textStyle: AppTextStyle.body(),
              ),
              SizedBox(height: 8.0),
              IconTextView(
                iconData: Icons.star,
                iconSize: 16.0,
                iconColor: Colors.orangeAccent,
                text: restaurant.userRating?.ratingFormatted,
                textStyle: AppTextStyle.body(),
              ),
              SizedBox(height: 24.0),
              _buildTitleAndDescription(
                'Location',
                restaurant.location?.address,
              ),
              SizedBox(height: 24.0),
              _buildTitleAndDescription(
                'Timings',
                restaurant.timings,
              ),
              SizedBox(height: 24.0),
              _buildTitleAndDescription(
                'Price',
                'Price range : ${restaurant.priceFormatted}',
              ),
              SizedBox(height: 24.0),
              Text(
                'Highlights',
                style: AppTextStyle.subtitle(),
              ),
              SizedBox(height: 4.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: restaurant.highlights.map((highlight) {
                  return Text(
                    '- $highlight',
                    style: AppTextStyle.body(),
                  );
                }).toList(),
              ),
              SizedBox(height: 24.0),
              _buildTitleAndDescription(
                'Contact',
                restaurant.phoneNumbers,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTitleAndDescription(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.subtitle(),
        ),
        SizedBox(height: 4.0),
        Text(
          description,
          style: AppTextStyle.body(),
        ),
      ],
    );
  }

  Widget _buildDetailShimmerView() {
    return ListView(
      children: [
        ShimmerView(height: 250.0),
        SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 8,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ShimmerView(
                    width: double.infinity,
                    height: 24.0,
                  ),
                  SizedBox(height: 16.0),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
