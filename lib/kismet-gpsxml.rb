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
      next unless interesting_gpsxml_node? node
      point = point_info node
      lat, lon, bssid = point.values
      key = [lat,lon].join(",")
      points[key] = Set.new if points[key].nil?
      points[key].add bssid
    end
    points
  end

  # Returns the number of interesting_gpsxml_nodes it wrote
  def write_interesting_nodes_to_file io
    counter = 0
    reader.each do |node|
      unless undesirable_node? node
        io.write node_to_string(node)
        counter += 1 if interesting_gpsxml_node? node
      end
    end
    counter
  end

  private

  def is_gpspoint? node
    node.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT &&
    node.name == "gps-point"
  end

  def interesting_gpsxml_node? node
    is_gpspoint?(node) &&
    node.attribute("bssid") != "00:00:00:00:00:00"
  end

  def undesirable_node? node
    is_gpspoint?(node) &&
    (
      node.attribute("bssid") == "00:00:00:00:00:00" ||
      node.attribute("bssid") == "GP:SD:TR:AC:KL:OG"
    )
  end

  def node_to_string node
    case node.node_type
    when Nokogiri::XML::Reader::TYPE_ELEMENT
      open_node_with_attrs(node)
    when Nokogiri::XML::Reader::TYPE_END_ELEMENT
      close_node(node)
    when Nokogiri::XML::Reader::TYPE_DOCUMENT_TYPE
      node.outer_xml
    when Nokogiri::XML::Reader::TYPE_TEXT
      node.value
    end
  end

  def close_node node
    "</"+node.name+">"
  end

  def open_node_with_attrs node
    name = node.name
    attrs = node.attributes.collect{|k,v| '%s="%s"'%[k,v] }.join(' ')
    closing = node.self_closing? ? '/' : ''
    "<#{[name,attrs].join(' ')}#{closing}>"
  end

  def point_info node
    {lat: node.attribute("lat").to_f.round(rounding),
     lon: node.attribute("lon").to_f.round(rounding),
     bssid: node.attribute("bssid")}
  end
end
