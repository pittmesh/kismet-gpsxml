require 'nokogiri'
require 'set'

module Kismet
  module GPSXML
  end
end

class Kismet::GPSXML::Reader

  private_class_method :new

  attr_reader :reader
  attr_accessor :rounding

  def self.from_io io
    new Nokogiri::XML::Reader.from_io(io)
  end

  def initialize xml_reader
    @reader = xml_reader
    @rounding = 4
  end

  def bssids_by_lat_long
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

  private

  def interesting_node? node
    node.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT &&
    node.name == "gps-point" &&
    node.attribute("bssid") != "00:00:00:00:00:00"
  end

  def point_info node
    {lat: node.attribute("lat").to_f.round(rounding),
     lon: node.attribute("lon").to_f.round(rounding),
     bssid: node.attribute("bssid")}
  end
end
