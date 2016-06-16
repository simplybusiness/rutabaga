module RspecFormatter
  class Formatter
    RSpec::Core::Formatters.register self, :example_group_started, :example_group_finished

    def initialize(output)
      @group_nesting = 0
    end

    def example_group_started(example_group)
      @group_nesting += 1
    end

    def example_group_finished(notification)
      @group_nesting -= 1
      if @group_nesting == 0
        puts "rspec_core_formatter:file_path: #{notification.group.file_path}"
      end
    end
  end
end
