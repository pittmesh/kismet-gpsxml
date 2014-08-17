require 'helper'

describe Kismet::GPSXML::Reader do
  subject { Kismet::GPSXML::Reader }

  describe "Expected methods" do
    it "responds to from_io" do
      subject.must_respond_to :from_io
    end

    it "responds to points" do
      subject.public_instance_methods.must_include :points
      # subject.must_respond_to :points # this doesn't work on classes, just instances
    end

    it "cannot be initialized directly" do
      expect{ subject.new StringIO.new }.to_raise NoMethodError
    end
  end

  describe "IO operations" do
    let(:text_xml_io) { File.open test_xml_location }

    before do
      text_xml_io.rewind
      @reader = subject.from_io text_xml_io
    end

    it "retrieves points" do
      @reader.points.wont_be_empty
    end

    it "retrieves the expected number of points" do
      @reader.points.size.must_equal 4 # one should be filtered out
    end

    it "filters bssid = 00:00:00:00:00:00" do
      points_with_bad_bssid = @reader.points.select{|position,bssid| bssid == '00:00:00:00:00:00'}
      points_with_bad_bssid.must_be_empty
    end

  end
end
