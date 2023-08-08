require "rails_helper"

RSpec.describe ApiKey do
  describe "validations" do
    it { should belong_to :user }
  end
end