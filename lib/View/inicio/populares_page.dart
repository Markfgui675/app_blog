import 'package:app_blog/View/resources/assets_manager.dart';
import 'package:app_blog/View/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:advanced_icon/advanced_icon.dart';
import 'package:line_icons/line_icon.dart';

class PopularesPage extends StatefulWidget {
  const PopularesPage({super.key});

  @override
  State<PopularesPage> createState() => _PopularesPageState();
}

class _PopularesPageState extends State<PopularesPage> {

  AdvancedIconState _state = AdvancedIconState.primary;

  void _changeState(){
    setState(() {
      if(_state == AdvancedIconState.primary){
        _state = AdvancedIconState.secondary;
      } else {
        _state = AdvancedIconState.primary;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _iniciais(),

        ],
      ),
    );
  }

  Widget _iniciais(){
    return Padding(
      padding: const EdgeInsets.only(top: AppPadding.p20, left: AppPadding.p12, right: AppPadding.p12, bottom: AppPadding.p20),
      child: SizedBox(
        height: AppSize.s380,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index){
              return Container(
                height: AppSize.s300,
                width: AppSize.s300,
                margin: const EdgeInsets.only(right: AppMargin.m12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    image: DecorationImage(
                      image: AssetImage(AssetsManager.image),
                      fit: BoxFit.cover
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: AppSize.s300,
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppPadding.p20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        gradient: LinearGradient(
                          begin: AlignmentDirectional.bottomEnd,
                          end: Alignment.center,
                          colors: [
                            Colors.black12,
                            Colors.black38,
                            Colors.black
                          ]
                        )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                        ],
                      ),
                    )
                  ],
                ),
              );
            }
        ),
      ),
    );
  }

}

