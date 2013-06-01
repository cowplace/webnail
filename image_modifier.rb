#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'mini_magick'

class ImageModifier
  class << self
    def execute(items)
      instance = self.new
      items.each do |item|
        filename = item[:image]
        item[:height] = instance.resize(filename) unless filename.nil?
      end
      return items
    end
  end

  def resize(filename)
    image = MiniMagick::Image.new(filename)
    resized_height = image[:height]*100/image[:width]
    image.define "jpeg:size=100x#{resized_height}"
    image.resize "100x#{resized_height}"
    return resized_height
  end
end
