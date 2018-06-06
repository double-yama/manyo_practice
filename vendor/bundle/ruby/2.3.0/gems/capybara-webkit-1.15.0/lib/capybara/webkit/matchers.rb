module Capybara
  module Webkit
    module RspecMatchers
      RSpec::Matchers.define :have_errors do |expected|
        match do |actual|
          actual = resolve(actual)
          actual.error_messages.any?
        end

        #RSpec 2 compatability
        send(respond_to?(:failure_message) ? :failure_message : :failure_message_for_should) do |_actual|
          "Expected Javascript errors, but there were none."
        end

        #RSpec 2 compatability
        send(respond_to?(:failure_message_when_negated) ? :failure_message_when_negated : :failure_message_for_should_not) do |actual|
          actual = resolve(actual)
          "Expected no Javascript errors, got:\n#{error_messages_for(actual)}"
        end

        def error_messages_for(obj)
          obj.error_messages.map do |m|
            "  - #{m[:message]}"
          end.join("\n")
        end

        def resolve(actual)
          if actual.respond_to? :page
            actual.page.driver
          elsif actual.respond_to? :driver
            actual.driver
          else
            actual
          end
        end
      end
    end
  end
end
