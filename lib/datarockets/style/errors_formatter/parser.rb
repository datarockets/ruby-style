module Datarockets
  module Style
    class ErrorsFormatter
      # Parse the rubocop CLI result for getting info about failed file and cop
      # Gets stdout result of rubocop CLI.
      class Parser
        COP_REGEXP = %r{^((\w|/|\.)+):\d+:\d+: \w: ((\w|/)+)}.freeze

        ResultLine = Struct.new(:file, :rule)

        attr_reader :stdout

        def initialize(stdout)
          @stdout = stdout
        end

        def call
          stdout_lines.map { |line| ResultLine.new(line[1], line[3]) }
        end

        private

        def stdout_lines
          stdout.split("\n")
            .map do |line|
              line.match(COP_REGEXP)
            end
            .reject(&:nil?)
        end
      end
    end
  end
end
