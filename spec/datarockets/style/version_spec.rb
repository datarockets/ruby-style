RSpec.describe "Datarockets::Style::Version" do
  describe "::VERSION" do
    it "contains the current version" do
      expect(Datarockets::Style::VERSION).not_to be nil
    end
  end
end
