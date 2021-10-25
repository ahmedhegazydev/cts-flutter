//import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class PDFWidget extends StatefulWidget {
  final bool portraitStatus;
  final String documentString;
  final String documentUrl;
  const PDFWidget(this.portraitStatus, this.documentString, this.documentUrl);
  @override
  _PDFWidgetState createState() => _PDFWidgetState();
}

class _PDFWidgetState extends State<PDFWidget> {
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
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(widget.documentUrl))
            .load(widget.documentUrl))
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
    return Container(
      width: widget.portraitStatus == true
          ? MediaQuery.of(context).size.width - 70
          : MediaQuery.of(context).size.width / 1.5,
      color: Colors.transparent,
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : PdfView(
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
