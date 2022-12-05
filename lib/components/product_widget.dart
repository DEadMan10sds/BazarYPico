import 'package:bazar_y_pico/Services/ProductCRUD.dart';
import 'package:bazar_y_pico/add_products/add_products_widget.dart';
import 'package:bazar_y_pico/description/description_widget.dart';

import '../Services/Auth_service.dart';
import '../edit_product/edit_product.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import '../flutter_flow/flutter_flow_util.dart';
import '../locator.dart';
import '../main.dart';

/*class ProductWidget extends StatefulWidget {
  const ProductWidget({Key? key}) : super(key: key);

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}*/

class ProductWidgetState extends StatelessWidget{

  ProductWidgetState(this.name, this.img, this._productID, this.unitPrice, this.stock, this.owner);

  final String name;
  final String img;
  final String stock;
  final String _productID;
  final String unitPrice;
  final String owner;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        locator<AuthService>().productSelected = _productID;
        await Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => const DescriptionWidget(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
        child: ListView(
          padding: EdgeInsets.zero,
          primary: false,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
              child: Container(
                width: double.infinity,
                height: 110,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme
                      .of(context)
                      .secondaryBackground,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x32000000),
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          img,
                          width: 120,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(8, 12, 16, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  name,
                                  style: FlutterFlowTheme
                                      .of(context)
                                      .title3
                                      .override(
                                    fontFamily: 'Outfit',
                                    color: const Color(0xFF32546D),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if(owner == locator<AuthService>().userID)
                                  FlutterFlowIconButton(
                                    borderColor: Colors.transparent,
                                    borderRadius: 10,
                                    borderWidth: 1,
                                    buttonSize: 40,
                                    icon: Icon(
                                      Icons.edit,
                                      color: FlutterFlowTheme.of(context).primaryColor,
                                      size: 25,
                                    ),
                                    onPressed: () async {
                                      locator<AuthService>().bazarSelected = _productID;
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const EditProductsWidget(),
                                        ),
                                      );
                                    },
                                  ),
                                if(owner == locator<AuthService>().userID)
                                  FlutterFlowIconButton(
                                    borderColor: Colors.transparent,
                                    borderRadius: 10,
                                    borderWidth: 1,
                                    buttonSize: 40,
                                    icon: Icon(
                                      Icons.delete,
                                      color: FlutterFlowTheme.of(context).primaryColor,
                                      size: 25,
                                    ),
                                    onPressed: () async {
                                      var response = await ProductCRUD.delete(productID: _productID);
                                      if(response.code != 200)
                                      {
                                        // ignore: use_build_context_synchronously
                                        return showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(response.message.toString()),
                                              );
                                            });
                                      }
                                      //print('IconButton pressed ...');
                                      // ignore: use_build_context_synchronously
                                      await Navigator.pushReplacement(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.fade,
                                          duration:
                                          const Duration(milliseconds: 300),
                                          reverseDuration:
                                          const Duration(milliseconds: 300),
                                          child: const NavBarPage(
                                              initialPage: 'Bazaars'),
                                        ),
                                      );
                                    },
                                  ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsetsDirectional.fromSTEB(8, 0, 16, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Stock: $stock',
                                  style: FlutterFlowTheme
                                      .of(context)
                                      .bodyText2
                                      .override(
                                    fontFamily: 'Outfit',
                                    color: const Color(0xFF80A7B8),
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsetsDirectional.fromSTEB(8, 0, 16, 12),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '\$${unitPrice}',
                                  style: FlutterFlowTheme
                                      .of(context)
                                      .subtitle1
                                      .override(
                                    fontFamily: 'Outfit',
                                    color: const Color(0xFFF3485B),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
