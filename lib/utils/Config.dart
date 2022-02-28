import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';


const bool DEBUG_MODE = true ;

/* firebase Mail and Password
password :Assel2224
email :assel.firebase@gmail.com

 */
launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

//api-iraqsoft.com:32369

class FilterTypes{
  static const int BY_PHONE = 1 ;
  static const int BY_ID = 2 ;
  static const int BY_ZONE = 3 ;
}