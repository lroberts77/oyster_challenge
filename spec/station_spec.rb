require 'station'

describe Station do
    
  it "station has correct name" do
    expect(subject.name).to eq "bank"
  end
  it "zone shows what zone I'm in" do
    expect(subject.zone).to eq "zone1"
  end
end