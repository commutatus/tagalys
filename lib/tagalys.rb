require 'tagalys/configuration'

module Tagalys
  class << self
    attr_accessor :configuration
    require 'net/http'
    require 'uri'
    require 'json'

    def configuration
      @configuration ||= Configuration.new
    end

    def reset
      @configuration = Configuration.new
    end

    def configure
      yield(configuration)
    end

    def search(query = nil, filters = nil, sort = nil, page = 1, per_page = 30)
      return { status: "Either query or filter should be present" } if query == nil && filters == nil
      # return { status: "Filter should be a hash" } if filters && filters.class != Hash
      request_body = {
        identification: identification,
        q: query.strip.length > 0 ? query : nil,
        sort: sort,
        qf: filters,
        page: page,
        per_page: per_page,
      	request: [
          "banners",
          "details",
          "filters",
          "results",
          "sort_options",
          "total",
          "variables"
        ]
      }.compact
      search_response = request_tagalys('/search', request_body)
    end

    def get_page_details(page_name, filters = nil, sort = nil, page = 1, per_page = 30)
      request_body = {
        identification: identification,
        sort: sort,
        f: filters,
        page: page,
        per_page: per_page,
      	request: [
          "banners",
          "details",
          "filters",
          "results",
          "sort_options",
          "total",
          "variables"
        ]
      }.compact
      search_response = request_tagalys('/mpages/' + page_name, request_body)
    end

    def get_page_list(page = 1, per_page = 30)
      request_body = {
        identification: identification,
      	request: ["url_component", "variables"],
        page: page,
        per_page: per_page
      }.compact
      search_response = request_tagalys('/mpages/', request_body)
    end

    def get_similar_products(product_id)
      request_body = {
        identification: identification,
        max_products: 16,
      	request: [
          "details",
          "results"
        ]
      }.compact
      search_response = request_tagalys("/products/#{product_id}/similar", request_body)
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
        client_code: configuration.client_code,
        store_id: configuration.store_id,
        api_key: configuration.api_key
      }
    end

  end
end
