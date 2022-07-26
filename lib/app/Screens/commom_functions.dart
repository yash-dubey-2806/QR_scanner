
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class CommonFuntion {
  snackBar(String message, context) {
    return ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        
         content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.warning,color: Colors.red,size: 25,),
            SizedBox(
              width: 20,
            ),
            Text(message,style: TextStyle(  color: Colors.orange,fontSize: 22),),
          ],
        ),
        duration: Duration(seconds: 4),
        backgroundColor: Colors.white,
      ),
    );
  }
  

  loaderHandlerShow(context) {
    Loader.show(
      context,
      isSafeAreaOverlay: false,
      overlayColor: Colors.black26,
      progressIndicator: CircularProgressIndicator(
        backgroundColor: Colors.white,
        color: Colors.orange,
      ),
      themeData: Theme.of(context).copyWith(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.green,
        ),
      ),
    );
  }

  loaderHandlerHide() {
    Loader.hide();
  }

  
}

// void main() {
//   final DateTime now = DateTime.now();
//   final DateFormat formatter = DateFormat('h:mm a');
//   final String formatted = formatter.format(now);
//   print(formatted);

//   var data = "3:00".toString() + formatted;
//   print((formatted + "3:00").toString());

//   main(si, formatted) {
//     String s = "4454-3444-5674";
//     var concatenate = StringBuffer();
//     var x = formatted.split(si);
//     x.forEach((item) {
//       concatenate.write(item);
//     });

//     print(concatenate);
//     return concatenate;
//   }

//   var first = main('PM', formatted);
//   var second = main(':', first.toString());
//   var metadata = int.parse(second.toString());
//   print((metadata + 300).toString());

//   // something like 2013-04-20
// }
