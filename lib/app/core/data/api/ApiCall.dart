import 'package:dio/dio.dart';

import '../../constants_and_enums/static_data.dart';

class CallApi {
  static final dio = Dio();

//https://manpoweracademy.nitg-eg.com/mohamedmekhemar/signleteacher/apis.php?nationalid=ali&fname=ali&secondname=abbass&thirdname=ali&lname=ali&email=ali&password=ali&phone1=ali&phone2=ali&role=5&city=ali&readandwrite=0&academicqualification=0&scientificdegree=0&coursetype=0&job=ali&address=ali&gender=0
//https://manpoweracademy.nitg-eg.com/mohamedmekhemar/signleteacher/apis.php?function=register&nationalid=11111111111167&fname=test1&secondname=test2&thirdname=test3&lname=test4&email=test11182@gmail.com&password=123456&phone1=01122334455&phone2=011122335545&role=5&city=city&readandwrite=1&academicqualification=1&scientificdegree=0&coursetype=0&job=my job&address=my address&gender=0

  static getRequest(String url) async {
    final response = await dio.get(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else {
      return response.statusMessage;
    }
  }

  static Uri buildRegisterUrlParams({
    required String fname,
    required String lname,
    required String email,
    required String password,
    required String phone1,
  }) {
    return Uri.parse('https://salem-mar3y.com/salem_apis/signleteacher/apis3.php?')
        .replace(queryParameters: {
      'function': 'register',
      'fname': fname,
      'lname': lname,
      'email': email,
      'password': password,
      'phone1': phone1,
    });
  }
}
