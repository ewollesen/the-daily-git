require_relative "../test_helper"
require "daily"

describe Daily do
  before do
    @src_path = File.absolute_path("..")
    @daily = Daily.new(File.join(@src_path, "tdg-fixture"),
                       {date: "2012-05-20"})
  end

  describe "#generate" do
    it "generates a diff" do
      @daily.generate.must_match /Initial commit/
    end

    it "generates a diff for commits of the day previous to that specified" do
      @daily = Daily.new(File.join(@src_path, "tdg-fixture"),
                         {date: "2012-05-21"})
      @daily.generate.must_match /Add file3\.txt/
      @daily.generate.wont_match /Initial commit/
    end
  end

end
