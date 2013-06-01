#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
#
require 'twitter'
require 'open-uri'

class TwitterSeeker
  class << self
    def execute(domain='item.rakuten.co.jp')
      instance = self.new
      instance.search(domain)
    end
  end

  def search(domain)
    items = []
    Twitter.search(domain).results.map do |tweet|
      tweet.urls.each do |url|
        begin
          formated_url = format_url(url.expanded_url)
          if formated_url.include?("http://#{domain}") then
            item = {
              :url => formated_url,
              :created_at => tweet.created_at
            }
            items.push item
          end
        rescue
          next
        end
      end
    end
    return items
  end

  private
  def initialize
    init_twitter_client
  end

  def init_twitter_client
    Twitter.configure do |config|
      config.consumer_key = 'XXXXXXXXXX'
      config.consumer_secret = 'XXXXXXXXXXX'
      config.oauth_token = 'XXXXXXXXXXXX'
      config.oauth_token_secret = 'XXXXXXXXXXXX'
    end
  end

  def format_url(url)
    uri = url.kind_of?(URI) ? url : URI.parse(url)
    return open(uri).base_uri.to_s.gsub(/\?.*/,'')
  end
end
