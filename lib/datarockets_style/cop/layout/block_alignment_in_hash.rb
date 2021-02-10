module DatarocketsStyle
  module Cop
    module Layout
      class BlockAlignmentInHash < RuboCop::Cop::Cop
        include RuboCop::Cop::Alignment
        MSG = "Align"
        def_node_matcher :hash_with_block?, <<-PATTERN
          (hash
            <(pair
              ({sym | str} _)
              (block ...)
            ) ...>
          )
        PATTERN

        def on_hash(node)
          return unless hash_with_block?(node)
        end

        # def autocorrect(node)
        #   RuboCop::Cop::AlignmentCorrector.correct(processed_source, node, column_delta)
        # end
      end
    end
  end
end

