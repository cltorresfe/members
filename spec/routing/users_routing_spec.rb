require "rails_helper"

RSpec.describe UsersController, type: :routing do
  describe "routing" do

    it "routes to #edit" do
      expect(:get => "/profile").to route_to("users#edit")
    end

    it "routes to #update via PUT" do
      expect(:put => "/profile").to route_to("users#update")
    end

  end
end
