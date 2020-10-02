import 'package:find_resto/helper/image_asset_helper.dart';
import 'package:find_resto/presentation/views/foundation/app_text_style.dart';
import 'package:find_resto/presentation/views/foundation/color_palette.dart';
import 'package:find_resto/presentation/views/image_loader_view.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final Map<String, String> _informationList = {
    'ic_dicoding': '@didikmaulana',
    'ic_gmail': 'didikmaulana49@gmail.com',
    'ic_github': '@didik-maulana',
    'ic_blog': 'www.codingtive.com',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.islamicGreen,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Profile',
          style: AppTextStyle.heading(
            textColor: ColorPalette.white,
          ),
        ),
      ),
      body: _buildProfileListView(),
    );
  }

  Widget _buildProfileListView() {
    return ListView(
      children: [
        _buildHeaderStack(),
        _buildProfileContainer(),
      ],
    );
  }

  Widget _buildHeaderStack() {
    return Stack(
      children: [
        _buildHeaderBackground(),
        _buildHeaderContainer(),
      ],
    );
  }

  Widget _buildHeaderBackground() {
    return Container(
      height: 80.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(12.0),
          bottomLeft: Radius.circular(12.0),
        ),
        color: ColorPalette.islamicGreen,
      ),
    );
  }

  Widget _buildHeaderContainer() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 0.0),
      child: Card(
        elevation: 4.0,
        shadowColor: ColorPalette.shadowColor,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ImageLoaderView(
                imageAssets: ImageAssetHelper.getImagePath('ic_profile'),
                width: 80.0,
                height: 80.0,
                borderRadius: BorderRadius.circular(8.0),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Didik Maulana Ardiansyah',
                      style: AppTextStyle.subtitle(),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Mobile Developer',
                      style: AppTextStyle.body(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileContainer() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 32.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Me',
            style: AppTextStyle.heading(),
          ),
          SizedBox(height: 12.0),
          Text(
            "Hai, I'm Didik. Currently work as Software Engineer especially in Mobile Development. "
            "So far, My specialized in programming languages is Kotlin, Java, Swift, and Dart. "
            "I'm still enthusiastically sharing and learning something new.",
            style: AppTextStyle.body(),
          ),
          SizedBox(height: 28.0),
          Text(
            'Information',
            style: AppTextStyle.heading(),
          ),
          SizedBox(height: 12.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildInformationWidget(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildInformationWidget() {
    List<Widget> _informationWidget = [];

    _informationList.forEach((icon, text) {
      _informationWidget.add(Card(
        elevation: 2.0,
        shadowColor: ColorPalette.shadowColor,
        child: ListTile(
          leading: ImageLoaderView(
            imageAssets: ImageAssetHelper.getImagePath(icon),
            width: 24.0,
            height: 24.0,
          ),
          title: Text(
            text,
            style: AppTextStyle.subtitle(),
          ),
        ),
      ));
    });

    return _informationWidget;
  }
}
