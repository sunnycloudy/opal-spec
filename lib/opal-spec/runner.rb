module Spec
  class Runner
    # Simple autorunner. Specs will be loaded bu the given glob, and
    # then run on document ready.
    #
    #   # run specs from test/ instead of spec/
    #   Spec::Runner.autorun 'test/**/*'
    #
    # @param [String] glob files to run
    # def self.autorun(glob = "spec/**/*")
    #   Document.ready? do
    #     Dir[glob].each { |s| require s }
    #     Runner.new.run
    #   end
    # end

    def self.autorun
      %x{
        setTimeout(function() {
          #{ Runner.new.run };
        }, 0);
      }
    end

    def initialize
      @formatter = BrowserFormatter.new
    end

    def run
      groups = ExampleGroup.example_groups
      @formatter.start
      groups.each { |group| group.run self }
      @formatter.finish
    end

    def example_group_started group
      @formatter.example_group_started group
    end

    def example_group_finished group
      @formatter.example_group_finished group
    end

    def example_started example
      @formatter.example_started example
    end

    def example_passed example
      @formatter.example_passed example
    end

    def example_failed example
      @formatter.example_failed example
    end
  end
end