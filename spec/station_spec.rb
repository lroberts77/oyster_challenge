require 'station'

describe Station do
    let(:station) { Station.new("harrow", 5)}
    
  it "station has correct name" do
    expect(station.name).to eq "harrow"
  end
  it "zone shows what zone I'm in" do
    expect(station.zone).to eq 5
  end
end