# Tagalys Setup
First install the tagalys gem into the application.
```
gem 'tagalys'
```
Create a configuration file like `config/initializers/tagalys.rb` and paste the following and replace the credentials
```
Tagalys.configure do |config|
  config.client_code = "xxxxxxxxxxx"
  config.store_id = "yyyyyyyyyyy"
  config.api_key = "zzzzzzzzzzzzzz"
end
```
### Step 1
First step is to create the store in tagalys. If store is already created ignore this step.
```
currencies = [
        {
          "id": "INR",
          "label": "₹",
          "fractional_digits": 2,
          "rounding_mode": "round",
          "exchange_rate": 66.77,
          "default": false
        }
      ]
// core fields like sku, price, sale_price etc. described in the next section don't have to be defined here, but they can be for the purpose of overriding labels or other options.
fields = [
        {
          "name": "sale_price",
          "type": "float",
          "label": "Final Price",
          "currency": true,
          "filters": true,
          "search": false
        }
      ]

tag_sets = [
      {
        "tag_set": {
          "id": "__categories",
          "label": "categories"
        },
        "items": [
          {
            "id": "6",
            "label": "Accessories",
            "items": [ // items can be nested
              {
                "id": "18",
                "label": "Eyewear"
              }
            ]
          }
        ]
      }
    ]

sort_options = [
        {
          "field": "name",
          "label": "Name"
        },
        {
          "field": "price",
          "label": "Price"
        }
      ]
Tagalys.create_store(currencies, fields, tag_sets, sort_options)
```
### Step 2
Once the store is setup, Now sync all the products.
```
Tagalys.product_sync(url, product_count) # url to the jsonl file which contains the product details.
```

### Step 3
To search a product from the store.
```
Tagalys.search('gold')

{"identification":{"client_code":"ED8FFD720193B471","store_id":"1","api_key":"3a257e305b32e7b4fa70b5e999730d5a"},"q":"gold","request":["total","results","details","sort_options","filters"]}
=> {"total"=>8, "results"=>["5339", "5338", "5336", "5335", "5334", "5332", "5331", "5330"], "filters"=>[{"id"=>"gender", "name"=>"Gender", "type"=>"checkbox", "items"=>[{"id"=>"244", "name"=>"Men", "count"=>1, "selected"=>false}]}, {"id"=>"finishes", "name"=>"Finishes", "type"=>"checkbox", "items"=>[{"id"=>"221", "name"=>"Miligrain Effect", "count"=>1, "selected"=>false}]}, {"id"=>"occassion", "name"=>"Occassion", "type"=>"checkbox", "items"=>[{"id"=>"249", "name"=>"Engagement", "count"=>1, "selected"=>false}]}, {"id"=>"collection", "name"=>"Collection", "type"=>"checkbox", "items"=>[{"id"=>"310", "name"=>"Gold & Silver Collection", "count"=>1, "selected"=>false}, {"id"=>"331", "name"=>"Silver - Kundan Collection ", "count"=>1, "selected"=>false}]}, {"id"=>"product_style", "name"=>"Product Style", "type"=>"checkbox", "items"=>[{"id"=>"235", "name"=>"Contemporary", "count"=>1, "selected"=>false}]}, {"id"=>"gem_stone", "name"=>"Gem Stone", "type"=>"checkbox", "items"=>[{"id"=>"168", "name"=>"Alexandrite", "count"=>2, "selected"=>false}, {"id"=>"164", "name"=>"Agate", "count"=>1, "selected"=>false}]}, {"id"=>"product_type", "name"=>"Product Type", "type"=>"checkbox", "items"=>[{"id"=>"162", "name"=>"Jhumki", "count"=>4, "selected"=>false}, {"id"=>"165", "name"=>"Necklace", "count"=>2, "selected"=>false}, {"id"=>"163", "name"=>"Earring", "count"=>1, "selected"=>false}, {"id"=>"258", "name"=>"Pendant", "count"=>1, "selected"=>false}]}, {"id"=>"metal_karatage", "name"=>"Metal Karatage", "type"=>"checkbox", "items"=>[{"id"=>"210", "name"=>"18K", "count"=>5, "selected"=>false}, {"id"=>"212", "name"=>"22K", "count"=>2, "selected"=>false}]}, {"id"=>"color_of_metal", "name"=>"Color of Metal", "type"=>"checkbox", "items"=>[{"id"=>"216", "name"=>"Black Rhodium", "count"=>1, "selected"=>false}]}, {"id"=>"metal_type", "name"=>"Metal Type", "type"=>"checkbox", "items"=>[{"id"=>"268", "name"=>"Gold", "count"=>6, "selected"=>false}, {"id"=>"252", "name"=>"White Gold", "count"=>2, "selected"=>false}]}], "page"=>1, "per_page"=>24, "sort_options"=>[{"id"=>"trending", "label"=>"Trending", "selected"=>true}, {"id"=>"price", "label"=>"Price", "selected"=>false, "directions"=>[{"direction"=>"asc", "label"=>"Price (asc)", "selected"=>false}, {"direction"=>"desc", "label"=>"Price (desc)", "selected"=>false}]}], "details"=>[{"__id"=>5339, "name"=>"Gold Round Pendant with Pearl Mala", "sku"=>"GHCSNE-2251", "link"=>"URL", "image_url"=>"//s3-eu-west-1.amazonaws.com/gehna-storage/not_available_image.jpg", "price"=>295.0, "sale_price"=>295.0, "in_stock"=>true}, {"__id"=>5338, "name"=>"Produt 2", "sku"=>"", "link"=>"URL", "image_url"=>"IMAGE_URL", "price"=>295.0, "sale_price"=>295.0, "in_stock"=>true}, {"__id"=>5336, "name"=>"Test product 6", "sku"=>"GHCSNE-1082", "link"=>"URL", "image_url"=>"//s3-eu-west-1.amazonaws.com/gehna-storage/not_available_image.jpg", "price"=>295.0, "sale_price"=>295.0, "in_stock"=>true}, {"__id"=>5335, "name"=>"Test Product 35", "sku"=>"GHJH-1081", "link"=>"URL", "image_url"=>"//s3-eu-west-1.amazonaws.com/gehna-storage/not_available_image.jpg", "price"=>295.0, "sale_price"=>295.0, "in_stock"=>true}, {"__id"=>5334, "name"=>"Some namne", "sku"=>"GHER-1080", "link"=>"URL", "image_url"=>"//s3-eu-west-1.amazonaws.com/gehna-storage/not_available_image.jpg", "price"=>295.0, "sale_price"=>295.0, "in_stock"=>true}, {"__id"=>5332, "name"=>"Test Product 35", "sku"=>"GHJH-1079", "link"=>"URL", "image_url"=>"//s3-eu-west-1.amazonaws.com/gehna-storage/not_available_image.jpg", "price"=>295.0, "sale_price"=>295.0, "in_stock"=>true}, {"__id"=>5331, "name"=>"Sofa", "sku"=>"GHJH-1078", "link"=>"URL", "image_url"=>"IMAGE_URL", "price"=>295.0, "sale_price"=>295.0, "in_stock"=>true}, {"__id"=>5330, "name"=>"Testing variation", "sku"=>"JH-1077", "link"=>"URL", "image_url"=>"IMAGE_URL", "price"=>295.0, "sale_price"=>295.0, "in_stock"=>true}], "query"=>"gold", "status"=>"OK"}
```

We can also search with tag set. For that we have to send the second parameter in `Hash`.
```
Tagalys.search("gold", {product_type: [162]})
```

We can also pass in pagination values as third and fourth params
```
# Tagalys.search(search_query, filters, sort, page_number, per_page)
Tagalys.search("gold", {product_type: [162]}, "sale_price-asc", 3, 25)
# 3 => Page number
# 25 => per_page count
```
### Step 4
To get list of pages from tagalys.
```
Tagalys.get_page_list


{
  "status": "OK",
  "total": 1,
  "results": [
    {
      "name": "Necklaces",
      "url_component": "necklace",
      "variables": {
          "page_title": "Buy Gold and Diamond Necklace Set for Women Online in Chennai, India | Gehna...",
          "description": "Buy Gold and Diamond Necklace Set",
          "meta_keywords": "",
          "meta_description": "Buy Gold and Diamond Necklace Set..."
      },
      "platform": false,
      "total": 31
    }
  ]
}
```

By default it fetches 30 list from page 1, we can pass pagination params here as well.
```
Tagalys.get_page_list(2, 30)
```

### Step 5
To get details of particular page from tagalys.
```
# Tagalys.search(page_name, filters, sort, page_number, per_page)
Tagalys.get_page_details(page_name, {price: {selected_min: "4000", selected_max: "1000"}})


{
  "status": "OK",
  "total": 1,
  "name": "Necklaces",
  "sort_options": [
    {
      "id": "trending",
      "label": "Trending",
      "selected": true
    },
    ...
  ],
  "total": 31,
  "filters": [
    {
      "id": "price",
      "name": "Price",
      "type": "range",
      "currency": true,
      "min": 31700,
      "max": 796040
    },
    ...
  ],
  "results": [
    "1830",
    "1831"
  ],
  "details": [
    {
      "__id": "1830",
      "name": "Resplendent Diamond Necklace",
      "sku": "GHDINE-2289 ",
      "link": "http://stage.gehnaindia.com/resplendent-diamond-necklace.html",
      "image_url": "https://stage.gehnaindia.com/media/tagalys/product_thumbnails/r/e/resplendent_diamond_necklace.png",
      "price": 278200,
      "sale_price": 278200,
      "in_stock": true,
      "shippingfast": [
        "No"
      ],
      "show_out_of_stocks": [
        "No"
      ]
    },
  ]
}
```

### Step 6
This is for search input box, Dropdown data population

```
Tagalys.surface_search(query, query_count, product_count)
Tagalys.surface_search('ge', 4, 4)

{
  "status": "OK",
  "queries": [
    {
      "query": [
        "Explore",
        "Jewelry By Gemstones",
        "Diamond Jewelry"
      ],
      "filter": {
        "__categories": [
          "117"
        ]
      },
      "in": {
        "tag_set": {
          "id": "jewellerytype",
          "name": "Jewellery Type"
        },
        "hierarchy": [
          {
            "id": "551",
            "name": "Earrings"
          }
        ]
      }
    },
    ....
  ],
  ],
  "products": [
    {
      "__id": "1756",
      "name": "Peerless Gold and Pearl Filigree Earrings",
      "sku": "GHCSER-1831",
      "link": "https://www.gehnaindia.com/peerless-gold-and-pearl-filigree-earrings.html",
      "image_url": "https://cdn.gehnaindia.com/media/tagalys/product_thumbnails/P/e/Peerless_Gold_and_Pearl_Filigree_Earrings-1.jpg",
      "price": 12220.0,
      "sale_price": 12220.0,
      "introduced_at": "20181103T193945.000+0000",
      "in_stock": true,
      "shippingfast": [
        "No"
      ],
      "show_out_of_stocks": [
        "No"
      ],
      "_id": "1756"
    },
    ....
  ]
}
```

### Tagalys Documentation reference

The Gem is built based on the following documentation provided by tagalys.

[Frontend Integration] (https://www.tagalys.com/docs/api/front-end/#tagalys-front-end-api)

[Custom Integration ] (https://www.tagalys.com/docs/api/custom-integration/#overview)
