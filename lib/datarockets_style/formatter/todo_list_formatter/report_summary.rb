# frozen_string_literal: true

module DatarocketsStyle
  module Formatter
    module TodoListFormatter
      # Get file of pairs: file path and cop name - and prepare report for ToDo list formatter.
      #
      # Example of result:
      #
      # LineLength
      #   Exclude:
      #     - "really/bad/file.rb" # 100500
      #     - "almost/ok.rb" # 1
      class ReportSummary
        attr_reader :offense_list

        FileGroup = Struct.new(:file, :offenses_count) do
          def print(output)
            output.puts "    - '#{file}' # #{offenses_count}"
          end
        end

        OffenseGroup = Struct.new(:cop_name, :offenses) do
          def file_groups
            @_file_groups ||= offenses.group_by(&:file_path).map do |file, offenses|
              FileGroup.new(file, offenses.length)
            end
          end

          def print(output)
            output.puts("#{cop_name}:")
            output.puts("  Exclude:")
            file_groups.sort_by(&:file).each do |file_group|
              file_group.print(output)
            end
            output.puts
          end
        end

        def initialize(offense_list)
          @offense_list = offense_list
        end

        def call(output)
          offense_groups.sort_by(&:cop_name).each { |group| group.print(output) }
        end

        private

        def offense_groups
          @_offense_groups ||= offense_list.group_by(&:cop_name)
            .map { |cop_name, offenses| OffenseGroup.new(cop_name, offenses) }
        end
      end
    end
  end
end
