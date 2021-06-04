import 'package:einkaufsapp/services/services.dart';
import 'package:einkaufsapp/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        title: Text("Produkt Detail"),
      ),
      body: Center(
          child: FutureBuilder<Product>(
              future: futureProduct,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  isLoading = true;
                } else {
                  isLoading = false;
                }

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
              subtitle: Text(product.brand ?? ""),
            ),
            Divider(),
            ListTile(
              leading: Icon(FontAwesomeIcons.barcode),
              title: Text(product.barCode),
            ),
            Divider(),
            ListTile(
              title: Text("Nutri-Score",
                  style: Theme.of(context).textTheme.headline5),
              trailing: SvgPicture.network(
                'https://static.openfoodfacts.org/images/misc/nutriscore-${product.scores.nutri}.svg',
                width: 50,
                height: 50,
              ),
            ),
            Divider(),
            ListTile(
              title: Text("Eco-Score",
                  style: Theme.of(context).textTheme.headline5),
              trailing: SvgPicture.network(
                'https://static.openfoodfacts.org/images/attributes/ecoscore-${product.scores.eco}.svg',
                width: 50,
                height: 50,
              ),
            ),
            Divider(),
            ListTile(
              title:
                  Text("Zutaten", style: Theme.of(context).textTheme.headline6),
            ),
            Flexible(child: Text(product.ingredients ?? "")),
            Divider(),
            ListTile(
              title: Text("Nährwerte",
                  style: Theme.of(context).textTheme.headline6),
              subtitle: Text("je 100g"),
            ),
            NutrimentWidget(nutriments: product.nutriments)
          ],
        ),
      ),
    );
  }
}
