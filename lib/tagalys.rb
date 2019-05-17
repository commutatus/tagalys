class Tagalys
  class << self
    require 'net/http'
    require 'uri'
    require 'json'

    def search(query=nil, filters=nil)
      return { status: "Either query or filter should be present" } if query == nil && filters == nil
      return { status: "Filter should be a hash" } if filters && filters.class != Hash
      request_body = {
        identification: identification,
        q: query.strip.length > 0 ? query : nil,
        qf: filters,
      	request: [
          "total",
          "results",
          "details",
          "sort_options",
          "filters"
        ]
      }.compact
      search_response = request_tagalys('/search', request_body)
    end

    def create_store(currencies, fields, tag_sets, sort_options)
      request_body = {
        identification: identification,
        stores: [
          {
            id: "1",
            label: "Store 1",
            currencies: currencies,
            fields: fields,
            tag_sets: tag_sets,
            sort_options: sort_options,
            locale: "en_US",
            timezone: "India/Kolkata",
            multi_currency_mode: "exchange_rate",
            products_count: 21532
          }
        ]
      }
      create_response = request_tagalys('/configuration', request_body)
    end

    def product_sync(link, product_count)
      request_body = {
        identification: identification,
      	link: link,
      	updates_count: product_count
      }
      create_response = request_tagalys('/products/sync_updates', request_body)
    end

    def request_tagalys(path, request_body)
      uri = URI.parse("https://api-r1.tagalys.com/v1/" + path)
      header = {'Content-Type': 'application/json'}
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri, header)
      puts request_body.to_json
      request.body = request_body.to_json

      # Send the request
      response = http.request(request)
      return JSON.parse(response.body)
    end

    def identification
      {
        client_code: "ED8FFD720193B471",
        store_id: "1",
        api_key: "3a257e305b32e7b4fa70b5e999730d5a"
      }
    end

  end
end
