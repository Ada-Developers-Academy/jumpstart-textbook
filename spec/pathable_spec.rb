require_relative "../pathable"
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
      it "requires a prefix" do
        expect{ Pathable.send(:builder) }.to raise_error(ArgumentError)
      end

      it "can accept a variable number of arguments after the first" do
        expect{ Pathable.send(:builder, "0", "1") }.to_not raise_error
        expect{ Pathable.send(:builder, "0", "1", "2", "taco") }.to_not raise_error
      end

      it "incorporates every non-nil value given into the resulting string" do
        expect(Pathable.send(:builder, "first", "2nd", "3rd")).to eq "first/2nd/3rd"
      end

      it "rejects given nils from the resulting string" do
        expect(Pathable.send(:builder, "first", nil, nil, "2nd", nil)).to eq "first/2nd"
      end
    end
  end

  context "Middleman Proxies" do
    it "generates paths suitable for middleman proxies" do
      expect( proxy_path unit ).to eq "/rspec/fundamentals-of-programming.html"
    end

    it "generates proxy paths that end in .html" do
      expect( proxy_path("test")[-5,5] ).to eq ".html"
    end

    it "generates paths to markdown files" do
      expect(markdown_path unit).to eq "/root/path/units/fundamentals-of-programming.md"
    end

    it "generates paths to markdown files that end in .md" do
      expect( markdown_path("test")[-3,3] ).to eq ".md"
    end
  end

  context "View-layer Breadcrumbs" do
    it "raises an error if the mixin doesn't implement `link_to`" do
      expect{ breadcrumb_link(unit) }.to raise_error(NotImplementedError)
    end

    it "invokes `link_to` and returns the result" do
      allow_any_instance_of(Pathable).to receive(:link_to).and_return(:called_link_to)
      expect(breadcrumb_link(unit)).to eq :called_link_to
    end
  end
end
