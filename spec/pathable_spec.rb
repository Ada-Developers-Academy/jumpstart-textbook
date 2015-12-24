require_relative "../lib/pathable"
include Pathable

describe Pathable do
  let(:site_url) { "/rspec" }
  let(:root_path) { "/root/path" }

  let(:unit) { "Fundamentals of Programming" }
  let(:chapter) { "Introduction to Ruby" }
  let(:lecture) { "Core Data Types" }
  let(:special_lecture ) { "Flow Control & Conditionals" }

  context "Private Methods" do
    describe "Pathable#dumb_link" do
      it "downcases all words" do
        expect( Pathable.send(:dumb_link, unit) ).to eq "fundamentals-of-programming"
      end

      it "replaces spaces with hyphens" do
        expect( Pathable.send(:dumb_link, lecture) ).to eq "core-data-types"
      end

      it "replaces a continuous set of non-alphanumeric/space characters with one hyphen" do
        expect( Pathable.send(:dumb_link, special_lecture) ).to eq "flow-control-conditionals"
      end
    end

    describe "Pathable#builder" do
      it "incorporates every non-nil value given into the resulting array" do
        expect(Pathable.send(:builder, ["first", "2nd", "3rd"])).to eq ["first", "2nd", "3rd"]
      end

      it "resulting array contains no nils" do
        expect(Pathable.send(:builder, ["first", nil, nil, "2nd", nil])).to eq ["first", "2nd"]
      end
    end
  end

  context "Public Methods" do
    describe "Pathable#proxy_path" do
      it "generates paths suitable for middleman proxies" do
        expect( proxy_path site_url, unit ).to eq "/rspec/fundamentals-of-programming.html"
      end

      it "generates proxy paths that end in .html" do
        expect( proxy_path(site_url, unit)[-5,5] ).to eq ".html"
      end
    end

    describe "Pathable#mardown_path" do
      it "generates paths to markdown files" do
        expect( markdown_path root_path, unit ).to eq "/root/path/units/fundamentals-of-programming.md"
      end

      it "generates paths to markdown files that end in .md" do
        expect( markdown_path(root_path, unit)[-3,3] ).to eq ".md"
      end
    end

    describe "Pathable#breadcrumb_link" do
      it "return an array of Strings suitable for passing to link_to" do
        crumb = breadcrumb_link site_url, unit
        text, path = crumb

        expect(crumb).to be_a(Array)
        expect(text).to eq "Fundamentals of Programming"
        expect(path).to eq "/rspec/fundamentals-of-programming"
      end
    end
  end
end
