module DatarocketsStyle
  module Cop
    module Style
      # This cop checks nested interpolations
      #
      # @example
      #
      # # bad
      # "Hello, #{user.blank? ? 'guest' : "dear #{user.name}"}"
      #
      # # good
      # user_name = user.blank? ? 'guest' : "dear #{user.name}"
      # "Hello, #{user_name}"
      class NestedInterpolation < RuboCop::Cop::Cop
        include RuboCop::Cop::Interpolation

        MSG = "Redundant nested interpolation.".freeze

        def on_interpolation(node)
          node.each_descendant(:dstr) do |descendant_node|
            detect_double_interpolation(descendant_node)
          end
        end

        private

        def detect_double_interpolation(node)
          node.each_child_node(:begin) do |begin_node|
            add_offense(begin_node)
          end
        end
      end
    end
  end
end
