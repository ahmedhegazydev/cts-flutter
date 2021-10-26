//import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
// import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class PDFWidget extends StatefulWidget {
  final bool portraitStatus;
  final String documentString;
  final String documentUrl;
  PDFWidget(this.portraitStatus, this.documentString, this.documentUrl);
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
    if (mounted) setState(() => _isLoading = true);
    // for testing annotation
    // widget.documentString =
    //     "{\"\'1\'\":[{\"Id\":\"0\",\"Page\":\"1\",\"X\":\"57\",\"Y\":\"227\",\"Type\":\"11\",\"Width\":\"210\",\"Height\":\"70\",\"ImageByte\":\"data:image/png;base64,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ef65c7ZzZ06Xs/zz+hv20/xj/CWdfmm/a++rr1P13a5576/f65ztffV1pvcPV3bX77Cf5h/jL+n0S/tde199narvds17f/1e52zvq68zvX+4srt+h/00/5DqCzr90n7X3ldfp+q7XfPeX7/XOdv76utM7x+u7K7fYT/NP4Ivp7+g0y/td+0xP3utbqfqu13z3l+/1znb++rrTO8fruyu32E/zT+AL2b15Zx+ab9zj51qL2eeV92h6817f/1e52zvK68zvYur++vn20/zl+NL2X0xp1/aT+1VyXmqukPXm/f++r3O2d5XXmd6F1f318+3n+Yvxhfy3Zdy+qX97r0Duxn4fKi6Q9eb9/76vc7Z3ldeZ3oXV/fXz7ef5i/Fl/HsCzn90n733pnqdbrX7nrz3l+/1znb+8rrTO/i6v76+fbT/GX4En7nF/fK613Z7VSvcfa6d+d//V5lsnu2U83P7lTu3Fk/236avwhfwO/+4l55ze94rWrn7N7d+V+/V5nsnu1U87M7lTt31s+2n+YvcvcLyL3q7rtZ5Wz33etNZp3J3X/jrDLZffea3azbf+fOnfWz7af5S/Dlm8aqnczUZD9ft0uqukrer9KpdjOdajfTqXYznWo3MzXdz9eukqpu4u699XPtp/lL8OWbpjPd61y5l895d+/drJKvt/f+v6v38lndvXezd+7eWz/XfpprrbXG9kdjrbXW2P5orLXWGtsfjbXWWmP7o7HWWmtsfzTWWmuN7Y/GWmutsf3RWGutNbY/Gmuttcb2R2OttdbY/mistdYa2x+NtdZaY/ujsdZaa2x/NNZaa43tj8Zaa62x/dFYa601tj8aa621xvZHY6211tj+aKy11hrbH4211lpj+6Ox1lprbH801lprje2PxlprrbH90VhrrTW2PxprrbXG9kdjrbXW2P5orF/hn3/++d/A57XWf8d+69bjJj8A3pncqeS9u6/xk/31v9963v4van3Jd/zDNHkN70zuVPLe3df4yf763289b/8X9cf8t/+h+K7nnb2O52f7a63P2G/dH/Nb/zE9++/2/Gz/N8q/01/8+62/Yf9XuW75xD9w717Hs3e7E9zPPC3/O+7+N929t9bU/q9r3ZL/OH3XP1TvXsezd7vvcK/KX3H17/PX/v7rs/Z/KX8IX/7f/A9A99/vvtt7hzu+d+e1zuSzPvH671x95rvdfK13e+985e76efZT/MGufNHyi3nl3id85fndXffdXufd/t3ZO9zrcma6l/z6V16j26XvcubOnfWz7Sf4g02/ZNXe9O4nfPXZ1X131c477/bvzq7itTLIPx88n6hec/o6071Dvq7v+c/vzut32k/wB5t+yaq9d3ffzezO69y5k6odd9XOO90+ffda72aHs3mHe5lUde90+9PXme4Z9zLw+VB163fZT+8Hm37Bqr13d9/N7M7rvLtzuDN3V+2c4U6XyrsZJjvGne5u13e+43Wu7II71d1pt36X/fR+ML5gky9Z7p3dezezO6/z7s7hbH7IHf6cd3yeytfifv7Z3s0w2QG7mcq7WaXbv/I6d3bf3fFOZv1e++n9cNMvm/e63clO6nazz1nV2dn8kK9T7VfdXWfPcG9nezl3KmfzSnWn6jqT3dw520V158j6vfbT+wWqL91PzzvdTt53rOvvymc5Z6o7XVDNnKuq1ziSqvnVfMV3vMZ61n56v0h+caukap6Z7BxBN+v6d7q9fI1uB2fzO/K5V16/upfpVLvkrrPX8Zykan7kO3zna61n7Ke3/qu++x+hp+0/gnN/7bP/t9pP718iv6xPfXF57hPPvuPsv/XO3+fq/l9x571aP9N+gv8S+YX9b355eVbmt6j+e/PvUc3P3LnzG+X7k1m/336K66P+2j8Yf+3v8yn5Pu179bfsp7nWWmtsfzTWWmuN7Y/GWmutof/8538AVL21URYiKBEAAAAASUVORK5CYII=\",\"ImageName\":\"C:\\\\everteam\\\\shared location\\\\Staging\\\\barcodes\\\\barcodeImg_2966759.png\",\"Text\":\"\",\"Readonly\":false,\"UserId\":\"-1\",\"Hidden\":false,\"ParentHeight\":0,\"ParentWidth\":0}]}"
    //         .replaceAll(r"\", '')
    //         .replaceAll('\\\\', '')
    //         .replaceAll(r"\'", '');
    // var newStr = jsonDecode(widget.documentString);
    // Uint8List bytes = base64Decode(newStr);
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(widget.documentUrl))
            .load(widget.documentUrl))
        .buffer
        .asUint8List();
    _pdfController = PdfController(
      document: PdfDocument.openData(bytes),
      initialPage: _initialPage,
    );

    if (mounted) setState(() => _isLoading = false);
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
                if (mounted)
                  setState(() {
                    _allPagesCount = document.pagesCount;
                  });
              },
              onPageChanged: (page) {
                if (mounted)
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
