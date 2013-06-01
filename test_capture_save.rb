#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'rubygems'

require 'pp'

require './twitter_seeker.rb'
require './screen_capture.rb'
require './image_modifier.rb'
require './mongo_gate.rb'

if __FILE__ == $0 then
  domain = 'item.rakuten.co.jp'
  tweets = TwitterSeeker.execute(domain)
  pages = ScreenCapture.execute(tweets)
  images = ImageModifier.execute(pages)
  gate = MongoGate.new('test', 'item')
  images.each do |image|
    filename = image[:image]
    unless filename.nil? then
      gate.add({
        :url => image[:url],
        :domain => domain,
        :height => image[:height],
        :data => open(filename, 'r+b').read,
        :created_at => image[:created_at]
      })
    end
  end
  gate.close
end
