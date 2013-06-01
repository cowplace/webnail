#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'capybara-webkit'
require 'headless'

class ScreenCapture
  class << self
    def execute(items)
      date = Time.now.strftime('%Y-%m-%d_%H-%M')
      h = Headless.new
      h.start
      driver = Capybara::Driver::Webkit.new 'web_capture'
      ObjectSpace.define_finalizer(driver) do
        h.destroy
      end
      items.each_with_index do |hash,idx|
        begin
          driver.visit hash[:url]
          next if driver.status_code == 404
          driver.render "#{date}_out#{idx}.jpg", :width => 100
          hash[:image] = "#{date}_out#{idx}.jpg"
        rescue
          next
        end
      end
      return items
    end
  end
end
