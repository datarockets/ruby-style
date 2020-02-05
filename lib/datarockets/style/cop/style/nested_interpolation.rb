module Datarockets
  module Style
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
            node.each_descendant(:begin) do |descendant_node|
              add_offense(descendant_node)
            end
          end
        end
      end
    end
  end
end
