# encoding: UTF-8

require "avalara/version"
require "avalara/errors"
require "avalara/configuration"

require "avalara/api"

require "avalara/types"
require "avalara/request"
require "avalara/response"

module Avalara
  def self.config
    Avalara::API.configuration
  end

  def self.geographical_tax(latitude, longitude, sales_amount)
    uri = [
      config.endpoint,
      config.version,
      "tax",
      "#{latitude},#{longitude}",
      "get"
    ].join("/")

    response = API.get(uri,
      headers: API.headers_for("0"),
      query: {saleamount: sales_amount},
      basic_auth: authentication
    )

    Avalara::Response::Tax.new(response)
  rescue Timeout::Error
    puts "Timed out"
    raise TimeoutError
  end

  def self.get_tax(invoice)
    uri = [
      config.endpoint,
      config.version,
      "tax",
      "get"
    ].join("/")

    response = API.post(uri,
      body: invoice.to_json,
      headers: API.headers_for(invoice.to_json.length),
      basic_auth: authentication
    )

    return case response.code
    when 200..299
      Response::Invoice.new(response)
    when 400..599
      raise ApiError.new(Response::Invoice.new(response))
    else
      raise ApiError.new(response)
    end
  rescue Timeout::Error => e
    raise TimeoutError.new(e)
  rescue ApiError => e
    raise e
  rescue Exception => e
    raise Error.new(e)
  end

  def self.validate_address(address_hash)

  end

  private

  def self.authentication
    {
      username: config.username,
      password: config.password
    }
  end
end
