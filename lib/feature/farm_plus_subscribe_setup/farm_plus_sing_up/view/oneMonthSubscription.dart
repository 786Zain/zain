import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase/store_kit_wrappers.dart';



class OneMonthSubscription extends StatefulWidget {
  createState() => OneMonthSubscriptionState();
}


// final String testID = 'fm_100_yearly';
final String testID2 = 'fm_99_mo';

class OneMonthSubscriptionState extends State<OneMonthSubscription> {

  /// The In App Purchase plugin
  InAppPurchaseConnection _iap = InAppPurchaseConnection.instance;

  /// Is the API available on the device
  bool _available = true;



  /// Products for sale
  List<ProductDetails> _products = [];

  /// Past purchases
  List<PurchaseDetails> _purchases = [];

  /// Updates to purchases
  StreamSubscription _subscription;

  /// Consumable credits the user can buy
  int _credits = 10;

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }


  /// Spend credits and consume purchase when they run pit
  void _spendCredits(PurchaseDetails purchase) async {

    /// Decrement credits
    setState(() { _credits--; });

    /// TODO update the state of the consumable to a backend database

    // Mark consumed when credits run out
    if (_credits == 0) {
      var res = await _iap.consumePurchase(purchase);
      await _getPastPurchases();
    }

  }
  /// Initialize data
  /// Initialize data
  void _initialize() async {

    // Check availability of In App Purchases
    _available = await _iap.isAvailable();

    if (_available) {

      await _getProducts();
      await _getPastPurchases();

      // Verify and deliver a purchase with your own business logic
      _verifyPurchase();

      _subscription = _iap.purchaseUpdatedStream.listen((data) => setState(() {
        print('NEW PURCHASE');
        _purchases.addAll(data);
        _verifyPurchase();
      }));

    }



  }

  /// Purchase a product
  void _buyProduct(ProductDetails prod) async{
    print('soemthind');
    //  final PurchaseParam purchaseParam = PurchaseParam(productDetails: prod);
    //  _iap.buyNonConsumable(purchaseParam: purchaseParam);
    // // _iap.buyConsumable(purchaseParam: purchaseParam, autoConsume: false);
    if (Platform.isIOS) {
      var paymentWrapper = SKPaymentQueueWrapper();
      var transactions = await paymentWrapper.transactions();
      for (var i = 0; i < transactions.length; i++) {
        await paymentWrapper.finishTransaction(transactions[i]);
      }
      await Future.delayed(Duration(milliseconds: 300));
    }

    var purchaseParam = PurchaseParam(productDetails: prod);
    var success = await _iap.buyNonConsumable(
        purchaseParam: purchaseParam
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(_available ? 'Open for Business' : 'Not Available'),

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var prod in _products)

            // UI if already purchased
              if (_hasPurchased(prod.id) != null)
                ...[
                  Text('$_credits', style: TextStyle(fontSize: 60)),
                  FlatButton(
                    child: Text('Consume'),
                    color: Colors.green,
                    onPressed: () => _spendCredits(_hasPurchased(prod.id)),
                  )
                ]

              // UI if NOT purchased
              else ...[
                Text(prod.title, style: Theme.of(context).textTheme.headline),
                Text(prod.description),
                Text(prod.price,
                    style: TextStyle(color: Colors.greenAccent, fontSize: 60)),
                FlatButton(
                  child: Text('Buy It'),
                  color: Colors.green,
                  onPressed: () {
                    print('presss here');
                    setState(() {
                      _buyProduct(prod);
                    });
                  },
                ),
              ]
          ],
        ),
      ),
    );
  }


// Private methods go here

  /// Get all products available for sale
  Future<void> _getProducts() async {
    Set<String> ids = Set.from([testID2]);
    ProductDetailsResponse response = await _iap.queryProductDetails(ids);

    setState(() {
      _products = response.productDetails;
    });
  }


  /// Gets past purchases
  Future<void> _getPastPurchases() async {
    QueryPurchaseDetailsResponse response = await _iap.queryPastPurchases();

    for (PurchaseDetails purchase in response.pastPurchases) {
      final pending = Platform.isIOS
          ? purchase.pendingCompletePurchase
          : !purchase.billingClientPurchase.isAcknowledged;

      if (pending) {
        InAppPurchaseConnection.instance.completePurchase(purchase);
      }
      // if(Platform.isIOS) {
      //   _iap.completePurchase(purchase);
      // }
    }

    setState(() {
      _purchases = response.pastPurchases;
    });
  }



  /// Returns purchase of specific product ID
  PurchaseDetails _hasPurchased(String productID) {
    return _purchases.firstWhere( (purchase) => purchase.productID == productID, orElse: () => null);
  }


  /// Your own business logic to setup a consumable
  void _verifyPurchase() {
    PurchaseDetails purchase = _hasPurchased(testID2);

    // TODO serverside verification & record consumable in the database

    if (purchase != null && purchase.status == PurchaseStatus.purchased) {
      _credits = 10;
    }
  }

}