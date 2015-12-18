require_relative "../dumb_link"

describe "String#dumb_link" do
  let(:simple) { "Fundamentals of Programming" }
  let(:spaces) { "this and that" }
  let(:capital) { "THIS" }
  let(:specials) { '@#{$$%&}' }

  it "downcases all words" do
    expect(capital.dumb_link).to eq "this"
  end

  it "replaces spaces with hyphens" do
    expect(spaces.dumb_link).to eq "this-and-that"
  end

  it "replaces a string of non-alphanumeric characters with one hyphen" do
    expect(specials.dumb_link).to eq "-"
  end

  it "turns a simple string into something suitable for urls" do
    expect(simple.dumb_link).to eq "fundamentals-of-programming"
  end  
end
