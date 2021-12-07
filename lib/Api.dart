import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:youtube_app/model/Video.dart';

const CHAVE_YOUTUBE_API = "AIzaSyCp5Gb158KnQTLKSMPic9LAE0eQIMuQnl4";
const ID_CANAL = "UCVHFbqXqoYvEWM1Ddxl0QDg";
const URL_BASE = "https://www.googleapis.com/youtube/v3/";

class Api {

  /*A interroacao utilizada apos o list foi tulizada para informar que a lista
  podera ser nula
   */
  Future<List<Video>>? pesquisar (String pesquisa) async {
    http.Response response = await http.get(Uri.parse(
        URL_BASE + "search"
            "?part=snippet"
            "&type=video"
            "&maxResults=20"
            "&order=date"
            "&key=$CHAVE_YOUTUBE_API"
        //PARAMETRO ABAIXO PODE SER ALTERADO PARA RETORNAR OS VIDEOS DESEJADOS DO YT
            "&channelId=$ID_CANAL"
            "&q=$pesquisa"
    )
    );

    if( response.statusCode == 200 ){


      Map<String, dynamic> dadosJson = json.decode( response.body );

      List<Video> videos = dadosJson["items"].map<Video>(
              (map){
            return Video.fromJson(map);
            //return Video.converterJson(map);
          }
      ).toList();

      return videos;

      /*for( var video in videos ){
        print("resultado: " + video.titulo! );
      }*/
      //print("Resultado: " + videos.toString() );

      /*
      for( var video in dadosJson["items"] ){
        print("Resultado: " + video.toString() );
      }*/
      //print("resultado: " + dadosJson["items"].toString() );

    }else{

      print("Status: " + response.statusCode.toString());

    }

  }

}

