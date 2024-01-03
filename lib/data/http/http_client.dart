import 'package:http/http.dart' as http;

//10
abstract class IHttpClient{
  Future get({required String url});
}
//11
class HttpClient implements IHttpClient{

  //12
  final client = http.Client();

  @override
  Future get({required String url}) async{
    //13
   return await client.get(Uri.parse(url)); //precisa converter a string em URI
  }

}