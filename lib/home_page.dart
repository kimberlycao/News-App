import 'package:flutter/material.dart';
import 'model.dart';
import 'api_service.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<NewsModel> _newsModel;

  @override
  void initState() {
    _newsModel = APIService().getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Tech News",
                      style: GoogleFonts.breeSerif(fontSize: 30.0)),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: Color(0xFF032B56)),
                child: FutureBuilder<NewsModel>(
                  future: _newsModel,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.articles.length,
                          itemBuilder: (context, index) {
                            var article = snapshot.data.articles[index];
                            var formattedTime = DateFormat('dd MMM - HH:mm')
                                .format(article.publishedAt);
                            return Container(
                              height: 100,
                              margin: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Card(
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Image.network(
                                          article.urlToImage,
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  SizedBox(width: 16),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(formattedTime,
                                            style: GoogleFonts.breeSerif(
                                                color: Colors.white)),
                                        Text(
                                          article.title,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.breeSerif(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        Text(article.description,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.breeSerif(
                                                color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    } else
                      return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
