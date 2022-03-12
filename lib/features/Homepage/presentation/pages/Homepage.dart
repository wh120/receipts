import '/core/Boilerplate/GetModel/widgets/GetModel.dart';

import '/features/Homepage/data/SliderListModel.dart';
import '/features/Homepage/repo/SlideRepository.dart';
import '/features/Notifications/data/models/Notification.dart';


import '../../../../core/Boilerplate/Pagination/cubits/pagination_cubit.dart';
import '../../../../core/Boilerplate/Pagination/widgets/PaginationList.dart';
import '../../../../core/utils/Navigation/Navigation.dart';
import '../../../../core/widgets/ColumnBuilder.dart';
import '../../../../core/widgets/SectionTitle.dart';
import '../../../../core/widgets/appbar/GeneralAppBar.dart';
import '../../../../core/widgets/carousels/CarouselWithIndicator.dart';

import '/features/Notifications/domain/repository/NotificationRepository.dart';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: GeneralAppBar(
        title: 'Home Page'.tr(),

      ),
      body: buildSlider(),
    );
  }

  _buildBody(){


  }

  buildSlider(){
    return GetModel<SliderListModel>(
      repositoryCallBack: (data) => SlideRepository.getSlides(),
      modelBuilder: (model) => slideBuilder(model),
    );
  }





  slideBuilder(SliderListModel slides){


    List<Slide> list = slides.list;

    return   CarouselWithIndicator(
      imgList: List.generate(list.length, (index) => list[index].photoRelativePath),
    );
  }


}


