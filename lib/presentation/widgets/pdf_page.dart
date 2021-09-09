import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';

class PDFPage extends StatefulWidget {
  @override
  _PDFPageState createState() => _PDFPageState();
}

class _PDFPageState extends State<PDFPage> {
  bool _isLoading = true;
  late PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    setState(() => _isLoading = true);
    document = await PDFDocument.fromURL(
      "http://conorlastowka.com/book/CitationNeededBook-Sample.pdf",
    );
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            width: 750,
            height: double.infinity,
            color: Colors.grey,
            child: PDFViewer(
              document: document,
              zoomSteps: 1,
              showPicker: false,
              showNavigation: false,
              showIndicator: false,
              scrollDirection: Axis.vertical,
            ),
          );
  }
}
