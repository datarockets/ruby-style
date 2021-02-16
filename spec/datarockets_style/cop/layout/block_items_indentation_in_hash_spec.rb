RSpec.describe DatarocketsStyle::Cop::Layout::BlockItemsIndentationInHash do
  subject(:cop) { described_class.new }

  @config = {
    api: lambda do |key|
           fetch(key)
         end,
  }

  @test = {
    test: lambda do |i|
      i
    end,
  }

  it "registers offence when block in a hash indented wrong" do
    expect_offense <<~RUBY
      @config = {
        api: lambda do |key|
          fetch(key)
        end
      }
    RUBY
  end

  it "accepts block with relative to beginning indentation" do
    expect_no_offenses <<~RUBY
      @config = {
        api: lambda do |key|
               fetch(key)
             end
      }
    RUBY
  end
end
