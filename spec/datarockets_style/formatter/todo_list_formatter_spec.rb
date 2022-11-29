RSpec.describe TodoListFormatter do
  subject(:formatter) { described_class.new(output) }

  let(:output) { StringIO.new }

  let(:files) do
    %w[lib/datarockets/style/verssion.rb spec/spec_helper.rb lib/datarockets/style.rb].map do |path|
      File.expand_path(path)
    end
  end

  describe "#finished" do
    let(:offenses_map) { [%w[CopB CopA CopC CopC], %w[CopA CopA], %w[CopB CopA CopC CopC CopC]] }
    let(:corrected_cops) { [] }

    context "when there are many offenses" do
      let(:result) do
        <<~OUTPUT
          Inspecting 3 files
          RRR
          3 files inspected, 11 offenses detected, 11 offenses autocorrectable

          CopA:
            Exclude:
              - 'lib/datarockets/style/verssion.rb' # 1
              - 'lib/datarockets/style.rb' # 1
              - 'spec/spec_helper.rb' # 2

          CopB:
            Exclude:
              - 'lib/datarockets/style/verssion.rb' # 1
              - 'lib/datarockets/style.rb' # 1

          CopC:
            Exclude:
              - 'lib/datarockets/style/verssion.rb' # 2
              - 'lib/datarockets/style.rb' # 3

        OUTPUT
      end

      before do
        formatter.started(files)

        files.each_with_index do |file, index|
          offenses = offenses_map[index].map do |cop_name|
            source_buffer = Parser::Source::Buffer.new("test", 1)
            source_buffer.source = "a\n"

            RuboCop::Cop::Offense.new(
              :refactor,
              Parser::Source::Range.new(source_buffer, 0, 1),
              "message",
              cop_name,
              corrected_cops.include?(cop_name) ? :corrected : :uncorrected,
            )
          end
          formatter.file_finished(file, offenses)
        end
      end

      it "sorts by offense name and file names" do
        formatter.finished(files)
        expect(output.string).to eq result
      end

      context "when the cop can be corrected" do
        let(:corrected_cops) { %w[CopA] }

        let(:corrected_result) do
          <<~OUTPUT
            Inspecting 3 files
            RRR
            3 files inspected, 11 offenses detected, 4 offenses corrected, 7 offenses autocorrectable

            CopB:
              Exclude:
                - 'lib/datarockets/style/verssion.rb' # 1
                - 'lib/datarockets/style.rb' # 1

            CopC:
              Exclude:
                - 'lib/datarockets/style/verssion.rb' # 2
                - 'lib/datarockets/style.rb' # 3

          OUTPUT
        end

        it "does not include corrected cops to report" do
          formatter.finished(files)
          expect(output.string).to eq corrected_result
        end
      end
    end
  end
end
