# frozen_string_literal: true

RSpec.describe DatarocketsStyle::Formatter::TodoListFormatter::ReportSummary do
  subject(:report_offenses) { described_class.new(offense_list).call(output) }

  let(:output) { StringIO.new }

  let(:offense_list) do
    [
      TodoListFormatter::FileOffence.new("test1.rb", "CopA"),
      TodoListFormatter::FileOffence.new("test1.rb", "CopA"),
      TodoListFormatter::FileOffence.new("test1.rb", "CopC"),
      TodoListFormatter::FileOffence.new("test2.rb", "CopA"),
      TodoListFormatter::FileOffence.new("test3.rb", "CopB"),
      TodoListFormatter::FileOffence.new("test3.rb", "CopB"),
    ].shuffle
  end

  let(:result) do
    <<~OUTPUT
      CopA:
        Exclude:
          - 'test1.rb' # 2
          - 'test2.rb' # 1

      CopB:
        Exclude:
          - 'test3.rb' # 2

      CopC:
        Exclude:
          - 'test1.rb' # 1

    OUTPUT
  end

  it "sorts by offense name and file names" do
    report_offenses
    expect(output.string).to eq(result)
  end
end
