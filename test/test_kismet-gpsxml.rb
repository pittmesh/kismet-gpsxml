require 'helper'

describe Kismet::GPSXML::Reader do
  subject { Kismet::GPSXML::Reader }

  describe "Expected methods" do
    it "responds to from_io" do
      subject.must_respond_to :from_io
    end

    it "responds to points" do
      subject.public_instance_methods.must_include :bssids_by_lat_long
      # subject.must_respond_to :points # this doesn't work on classes, just instances
    end

    it "cannot be initialized directly" do
      expect{ subject.new StringIO.new }.to_raise NoMethodError
    end
  end

  describe "IO operations" do
    let(:text_xml_io) { File.open test_xml_location }
    let(:text_write_io) { File.open test_write_location, 'w' }


    before do
      text_xml_io.rewind
      @reader = subject.from_io text_xml_io
    end

    #after do
     #puts "what %s" % passed?
      #if passed?
      #  if File.exists?(text_write_io) || File.exists?(test_write_location)
      #    File.unlink test_write_location
      #  end
      #end
    #end


    it "retrieves points" do
      @reader.bssids_by_lat_long.wont_be_empty
    end

    it "retrieves the expected number of points" do
      @reader.bssids_by_lat_long.size.must_equal 4 # one should be filtered out
    end

    it "filters bssid = 00:00:00:00:00:00" do
      points_with_bad_bssid = @reader.bssids_by_lat_long.select{|position,bssid| bssid == '00:00:00:00:00:00'}
      points_with_bad_bssid.must_be_empty
    end

    it "writes the expected number of points" do
      count = @reader.write_interesting_nodes_to_file text_write_io
      text_write_io.close
      count.must_equal 4
    end

    it "writes the expected number of points, then doesn't filter more" do
      count1 = @reader.write_interesting_nodes_to_file text_write_io
      text_write_io.close
      @reader2 = subject.from_io File.open(test_write_location)
      count2 = @reader2.write_interesting_nodes_to_file File.open(test_write_location("-second"), 'w')

      count1.must_equal count2
    end
  end
end
