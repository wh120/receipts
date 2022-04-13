import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/AppColors.dart';

class ObjectDropDown<T extends dynamic> extends StatefulWidget {
  final List<T> items;
  final String text;
  final ValueChanged<T> onChanged;
  T selectedValue;
   double width;
  ObjectDropDown({Key key, this.items, this.text, this.selectedValue, this.onChanged, this.width}) : super(key: key);
  @override
  State<ObjectDropDown<T>> createState() => _ObjectDropDownState<T>();
}

class _ObjectDropDownState<T extends dynamic> extends State<ObjectDropDown<T>> {


  @override
  Widget build(BuildContext context) {
    widget.width ??= 50.w;

    try {
      for(T element in widget.items){
        if(element != null) {
          element.name;
          break;
        }
      }

    } on NoSuchMethodError {
      return Text('First item not include name property');
    }on StateError{
      return Text('Items is empty');
    }catch(e){return Text(e.toString());}
    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        isExpanded: true,
        hint: Row(
          children: const [
            Icon(
              Icons.list,
              size: 16,
              color: AppColors.secondary,
            ),
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                'أختر',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: widget.items
            .map((item) => DropdownMenuItem<T>(
          value: item,
          child: FittedBox(
            child: Text(
              item?.name.toString(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ))
            .toList(),
        value: widget.selectedValue,
        onChanged: (value) {
          setState(() {
            widget.selectedValue = value ;
          });
          if( widget.onChanged != null )  widget.onChanged(value);
        },
        icon: const Icon(
          Icons.arrow_forward_ios_outlined,
        ),
        iconSize: 14,
        iconEnabledColor: AppColors.secondary,
        iconDisabledColor: Colors.grey,
        buttonHeight: 50,
        buttonWidth: widget.width,
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.black26,
          ),
          color: AppColors.primary,
        ),
        buttonElevation: 2,
        itemHeight: 40,
        itemPadding: const EdgeInsets.only(left: 14, right: 14),
        dropdownMaxHeight: 200,
       dropdownWidth: widget.width,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: AppColors.primary,
        ),
        dropdownElevation: 8,
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
        offset: const Offset(-20, 0),
      ),
    );
  }
}

class ObjectDropDownItem{
  final int id;
  final String name;

  bool operator ==(o) => o is ObjectDropDownItem  && id == o.id;

  ObjectDropDownItem({this.id, this.name});
}
