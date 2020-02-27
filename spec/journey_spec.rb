require 'journey'

describe Journey do
    let (:station) {double :station, zone: 1}

    it "can tell a journey isn't completed" do
    expect(subject).not_to be_complete
    end

end