import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

/*class ProductWidget extends StatefulWidget {
  const ProductWidget({Key? key}) : super(key: key);

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}*/

class ProductWidgetState extends StatelessWidget{

  ProductWidgetState(this.name, this.img, this.productID, this.unitPrice, this.stock);

  final String name;
  final String img;
  final String stock;
  final String productID;
  final String unitPrice;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        print(productID);
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
                            padding:
                            const EdgeInsetsDirectional.fromSTEB(8, 12, 16, 0),
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
