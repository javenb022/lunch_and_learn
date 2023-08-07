require "rails_helper"

RSpec.describe LearningResourcesFacade, :vcr do
  describe "can create a LearningResource poro" do
    it "get_learning_resources(search)" do
      learning_resources = LearningResourcesFacade.new.resources("japan")

      expect(learning_resources).to be_an(Array)
      expect(learning_resources.count).to eq(1)
      expect(learning_resources[0]).to be_a(LearningResource)
      expect(learning_resources[0].country).to be_a(String)
      expect(learning_resources[0].video).to be_a(Hash)
      expect(learning_resources[0].video[:title]).to be_a(String)
      expect(learning_resources[0].video[:youtube_video_id]).to be_a(String)
      expect(learning_resources[0].images).to be_an(Array)
      expect(learning_resources[0].images.count).to be <= 10
      expect(learning_resources[0].images[0]).to be_a(Hash)
      expect(learning_resources[0].images[0][:url]).to be_a(String)
      expect(learning_resources[0].images[0][:alt_tag]).to be_a(String)
    end
  end
end