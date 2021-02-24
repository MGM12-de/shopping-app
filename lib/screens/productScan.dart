import 'package:einkaufsapp/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductScanScreen extends StatefulWidget {
  @override
  _ProductScanState createState() => _ProductScanState();
}

class _ProductScanState extends State<ProductScanScreen> {
  String _scanBarcode = 'Unknown';
  bool isLoading = false;
  Future<Product> futureProduct;

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanBarcodeNormal() async {
    Locale myLocale = Localizations.localeOf(context);
    print(myLocale.languageCode);
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ffc30f", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      futureProduct = Product.fetchProduct(myLocale, _scanBarcode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan"),
      ),
      body: Center(
          child: FutureBuilder<Product>(
              future: futureProduct,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ProductDetail(product: snapshot.data);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                if (isLoading) {
                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                } else {
                  return Text("Nothing scanned yet");
                }
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scanBarcodeNormal();
        },
        child: Icon(FontAwesomeIcons.barcode),
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }
}

class ProductDetail extends StatelessWidget {
  final Product product;
  const ProductDetail({this.product}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(product.pictureUrl))),
              ),
              title: Text(product.name ?? ""),
              subtitle: Text(product.brand),
            ),
            Row(
              children: [
                Icon(FontAwesomeIcons.barcode),
                Text(" "),
                Text(product.barCode),
              ],
            ),
            Row(
              children: [
                Text("Zutaten", style: Theme.of(context).textTheme.headline6),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Flexible(child: Text(product.ingredients ?? "")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
