#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'mongo'

class MongoGate
  def initialize(db_name, coll_name)
    @db = Mongo::Connection.new.db(db_name)
    @coll = @db.collection(coll_name)
  end

  def add(attrs)
    bsoned_img = BSON::Binary.new(attrs[:data],BSON::Binary::SUBTYPE_BYTES)
    @coll.insert({
      :url => attrs[:url],
      :domain => attrs[:domain],
      :height => attrs[:height],
      :image => bsoned_img,
      :created_at => attrs[:created_at]
    })
  end 

  def close
    @db.connection.close
  end
end
