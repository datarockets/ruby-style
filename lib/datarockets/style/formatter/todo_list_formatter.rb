require "pathname"
require_relative "./todo_list_formatter/report_summary"

# This formatter works like default formattter (display dots for files with no offenses and
# letters for files with problems in the them).
#
# In the end, it shows report with sorted cops and files which can be added to rubocop config.
#
# Here's the format:
#
# Inspecting 3 files
# .CC
# 3 files inspected, 1005001 offenses detected
#
# LineLength
#   Exclude:
#     - "really/bad/file.rb" # 100500
#     - "almost/ok.rb" # 1
class TodoListFormatter < RuboCop::Formatter::ProgressFormatter
  attr_reader :offense_list

  FileOffence = Struct.new(:file_path, :cop_name)

  def started(target_files)
    super
    @offense_list = []
  end

  def file_finished(file, offenses)
    count_stats(offenses)
    report_file_as_mark(offenses)

    return if offenses.empty?

    path = Pathname.new(file).relative_path_from(Pathname.new(Dir.pwd))

    offenses.reject(&:corrected?).each do |offense|
      offense_list << FileOffence.new(path, offense.cop_name)
    end
  end

  def finished(inspected_files)
    report_summary(inspected_files.length,
      @total_offense_count,
      @total_correction_count)
    output.puts

    Datarockets::Style::Formatter::TodoListFormatter::ReportSummary.new(offense_list).call(output)
  end
end
