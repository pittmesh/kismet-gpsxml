require 'oga'
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
    new ::Oga::XML::PullParser.new(io)
  end

  def initialize xml_reader
    @reader = xml_reader
    @rounding = 4
  end

  def points
    points = {}
    reader.parse do |node|
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
    node.class == ::Oga::XML::Element &&
    node.name == "gps-point" &&
    node.attribute("bssid") != "00:00:00:00:00:00"
  end

  def point_info node
    {lat: node.attribute("lat").value.to_f.round(rounding),
     lon: node.attribute("lon").value.to_f.round(rounding),
     bssid: node.attribute("bssid")}
  end
end
