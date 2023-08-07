require "rails_helper"

RSpec.describe ImageFacade, :vcr do
  describe "can create an Image poro" do
    it "get_images(search)" do
      images = ImageFacade.new.get_images("japan")

      expect(images).to be_an(Array)
      expect(images.count).to eq(10)
      expect(images[0]).to be_a(Image)
      expect(images[0].url).to be_a(String)
      expect(images[0].alt_tag).to be_a(String)
      expect(images[0].id).to be(nil)
    end
  end
end