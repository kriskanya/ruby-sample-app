require 'spec_helper'

describe ApplicationHelper do

  describe "full_title" do
    it "should include the page title" do
      expect(full_title("foo")).to match(/foo/)
      # Regular expressions (regexps) are patterns which describe the contents of a string.
      # They’re used for testing whether a string contains a given pattern, or extracting the portions that match.
      # They are created with the /pat/ and %r{pat} literals or the Regexp.new constructor.
    end

    it "should include the base title" do
      expect(full_title("foo")).to match(/^Ruby on Rails Tutorial Sample App/)
      # If the first character of a character class is a caret (^) the class is inverted: it matches any character except those named.
    end

    it "should not include a bar for the home page" do
      expect(full_title("")).not_to match(/\|/)
    end
  end
end
