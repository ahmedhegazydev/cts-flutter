//import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class PDFPage extends StatefulWidget {
  @override
  _PDFPageState createState() => _PDFPageState();
}

class _PDFPageState extends State<PDFPage> {
  bool _isLoading = true;
  //late PDFDocument document;

  static final int _initialPage = 0;
  int _actualPageNumber = _initialPage, _allPagesCount = 0;
  bool isSampleDoc = true;
  late PdfController _pdfController;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    setState(() => _isLoading = true);
    var url = "http://conorlastowka.com/book/CitationNeededBook-Sample.pdf";
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(url)).load(url))
        .buffer
        .asUint8List();
    _pdfController = PdfController(
      document: PdfDocument.openData(bytes),
      initialPage: _initialPage,
    );

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: Container(
              child: CircularProgressIndicator(),
              width: MediaQuery.of(context).size.width / 2,
            ),
          )
        : Container(
            width: MediaQuery.of(context).size.width / 2,
            //  height: double.infinity,
            color: Colors.grey,
            child: PdfView(
              scrollDirection: Axis.vertical,
              controller: _pdfController,
              onDocumentLoaded: (document) {
                setState(() {
                  _allPagesCount = document.pagesCount;
                });
              },
              onPageChanged: (page) {
                setState(() {
                  _actualPageNumber = page;
                });
                print(_actualPageNumber);
                print("of");
                print(_allPagesCount);
              },
              onDocumentError: (error) {
                Text('Error Creating Document');
                print(error);
              },
            ),
            //  PDFViewer(
            //   document: document,
            //   zoomSteps: 1,
            //   showPicker: false,
            //   showNavigation: false,
            //   showIndicator: false,
            //   scrollDirection: Axis.vertical,
            // ),
          );
  }
}
