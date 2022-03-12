import '/core/constants/AppColors.dart';
import '/core/constants/AppTheme.dart';
import '/core/constants/constants.dart';
import '/features/AboutUs/data/AboutUsResponse.dart';
import '/features/Contact/data/contact.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;

class ContactsWidget extends StatelessWidget {
  final List<Contact> contacts;
  const ContactsWidget({Key key, this.contacts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: EdgeInsets.all(0),
          onTap: ()async{
            // String url = 'tel:00963987218505';
            // await canLaunch(url) ? await launch(url) : print ('Could not launch $url');
          },
          leading: Icon(getIcon(contacts[index].type) , color: AppColors.secondary[700],),
          title: Text(contacts[index].type.toString().tr() ,style: AppTheme.headline5,),

          trailing: Text(contacts[index].contactInfo,style: AppTheme.headline5,textDirection: TextDirection.ltr,),

        );

      },
    );
  }

  IconData getIcon(ContactType type) {
    switch (type) {
      case ContactType.Landline:
        return Icons.phone;
        break;
      case ContactType.PhoneNumber:
        return Icons.phone;
        break;
      case ContactType.Email:
        return Icons.mail;
        break;
      case ContactType.Website:
        return Icons.web;
        break;
      default:
        return Icons.web;
        break;
    }
  }




}
