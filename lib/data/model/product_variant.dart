import 'package:flutter_ecommerce_shop/data/model/variant.dart';
import 'package:flutter_ecommerce_shop/data/model/variant_type.dart';

class Productvariant {
  VariantType variantype;
  List<Variant> variantList;

  Productvariant(this.variantype, this.variantList);
}
