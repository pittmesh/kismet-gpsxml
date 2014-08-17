require 'nokogiri'
require 'set'

module Kismet
  module GPSXML
  end
end

class Kismet::GPSXML::Reader

  attr_reader :reader
  attr_accessor :rounding

  def initialize xml_reader
    @reader = xml_reader
    @rounding = 4
  end

  def self.from_io io
    self.new Nokogiri::XML::Reader.from_io(io)
  end

  def points
    points = {}
    reader.each do |node|
      next unless interesting_node? node
      point = point_info node
      lat, lon, bssid = point.values
      key = [lat,lon].join(",")
      points[key] = Set.new if points[key].nil?
      points[key].add bssid
    end
    points
  end

  def interesting_node? node
    node.name == "gps-point" &&
    node.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT &&
    node.attribute("bssid") != "00:00:00:00:00:00"
  end

  def point_info node
    {lat: node.attribute("lat").to_f.round(rounding),
     lon: node.attribute("lon").to_f.round(rounding),
     bssid: node.attribute("bssid")}
  end
end
