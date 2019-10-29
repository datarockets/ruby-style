require "open3"

module Datarockets
  module Style
    # Formatter for showing files with offenses and show the count of offenses for each file.
    # This class calls rubocop CLI and process the result.
    class ErrorsFormatter
      # Show file name with offenses for current cop and the count of that offenses
      # * file - file name with detected offenses
      # * count -  the count of offenses
      FileGroup = Struct.new(:file, :count) do
        def to_s
          "    - '#{file}' # #{count}"
        end
      end

      # Collect all information
      # * rule - the name of the cop
      # * lines - lines for current cop
      RuleGroup = Struct.new(:rule, :lines) do
        def file_groups
          @_file_groups ||= lines.group_by(&:file).map do |file, lines|
            FileGroup.new(file, lines.count)
          end
        end

        def file_groups_result
          file_groups
            .sort_by(&:file)
            .map(&:to_s)
            .join("\n")
        end

        def to_s
          "#{rule}:\n  Exclude:\n" + file_groups_result
        end
      end

      attr_reader :stdout

      def initialize
        @stdout, @_stderr, @_status = Open3.capture3 "bundle ex rubocop"
      end

      def to_s
        rules.map(&:to_s).join("\n\n")
      end

      private

      def rules
        lines.group_by(&:rule).map { |rule, lines| RuleGroup.new(rule, lines) }
      end

      def lines
        @_lines ||= Parser.new(stdout).call
      end
    end
  end
end
