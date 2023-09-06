// To parse this JSON data, do
//
//     final subscriptionProductsModel = subscriptionProductsModelFromJson(jsonString);

import 'dart:convert';

SubscriptionProductsModel subscriptionProductsModelFromJson(String str) =>
    SubscriptionProductsModel.fromJson(json.decode(str));

String subscriptionProductsModelToJson(SubscriptionProductsModel data) =>
    json.encode(data.toJson());

class SubscriptionProductsModel {
  String? object;
  List<ProductsDatum>? data;
  bool? hasMore;
  String? url;

  SubscriptionProductsModel({
    this.object,
    this.data,
    this.hasMore,
    this.url,
  });

  factory SubscriptionProductsModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionProductsModel(
        object: json["object"],
        data: json["data"] == null
            ? []
            : List<ProductsDatum>.from(
                json["data"]!.map((x) => ProductsDatum.fromJson(x))),
        hasMore: json["has_more"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "object": object,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "has_more": hasMore,
        "url": url,
      };
}

class ProductsDatum {
  String? id;
  String? object;
  bool? active;
  List<dynamic>? attributes;
  int? created;
  String? defaultPrice;
  dynamic description;
  List<Feature>? features;
  List<dynamic>? images;
  bool? livemode;
  Metadata? metadata;
  String? name;
  dynamic packageDimensions;
  dynamic shippable;
  dynamic statementDescriptor;
  dynamic taxCode;
  String? type;
  dynamic unitLabel;
  int? updated;
  dynamic url;

  ProductsDatum({
    this.id,
    this.object,
    this.active,
    this.attributes,
    this.created,
    this.defaultPrice,
    this.description,
    this.features,
    this.images,
    this.livemode,
    this.metadata,
    this.name,
    this.packageDimensions,
    this.shippable,
    this.statementDescriptor,
    this.taxCode,
    this.type,
    this.unitLabel,
    this.updated,
    this.url,
  });

  factory ProductsDatum.fromJson(Map<String, dynamic> json) => ProductsDatum(
        id: json["id"],
        object: json["object"],
        active: json["active"],
        attributes: json["attributes"] == null
            ? []
            : List<dynamic>.from(json["attributes"]!.map((x) => x)),
        created: json["created"],
        defaultPrice: json["default_price"],
        description: json["description"],
        features: json["features"] == null
            ? []
            : List<Feature>.from(
                json["features"]!.map((x) => Feature.fromJson(x))),
        images: json["images"] == null
            ? []
            : List<dynamic>.from(json["images"]!.map((x) => x)),
        livemode: json["livemode"],
        metadata: json["metadata"] == null
            ? null
            : Metadata.fromJson(json["metadata"]),
        name: json["name"],
        packageDimensions: json["package_dimensions"],
        shippable: json["shippable"],
        statementDescriptor: json["statement_descriptor"],
        taxCode: json["tax_code"],
        type: json["type"],
        unitLabel: json["unit_label"],
        updated: json["updated"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "active": active,
        "attributes": attributes == null
            ? []
            : List<dynamic>.from(attributes!.map((x) => x)),
        "created": created,
        "default_price": defaultPrice,
        "description": description,
        "features": features == null
            ? []
            : List<dynamic>.from(features!.map((x) => x.toJson())),
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "livemode": livemode,
        "metadata": metadata?.toJson(),
        "name": name,
        "package_dimensions": packageDimensions,
        "shippable": shippable,
        "statement_descriptor": statementDescriptor,
        "tax_code": taxCode,
        "type": type,
        "unit_label": unitLabel,
        "updated": updated,
        "url": url,
      };
}

class Feature {
  String? name;

  Feature({
    this.name,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata();

  Map<String, dynamic> toJson() => {};
}
