module DatarocketsStyle
  module Cop
    module Layout
      # This cop checks for block internals indentation inside a hash
      #
      # bad
      #
      # config = {
      #   api: lambda do |key|
      #     fetch(key)
      #   end
      # }
      #
      # good
      #
      # config = {
      #   api: lambda do |key|
      #          fetch(key)
      #        end
      # }
      #
      # better
      #
      # config = {
      #   api: lambda { |key| fetch(key) }
      # }
      class BlockItemsIndentationInHash < RuboCop::Cop::Cop
        include RuboCop::Cop::Alignment

        MSG = "Use %<configured_indentation_width>d spaces for block internals " \
              "relative to the block beginning (at %<block_column_delta>d)".freeze

        attr_reader :block_column_delta

        def_node_matcher :hash_with_block?, <<-PATTERN
          (hash
            <(pair
              ({sym | str} _)
              (block ...)
            ) ...>
          )
        PATTERN

        # def on_kwbegin(node)
        #   # Check indentation against end keyword but only if it's first on its
        #   # line.
        #   return unless begins_its_line?(node.loc.end)
        #
        #   check_alignment(node.children, node.loc.column)
        # end

        def on_hash(node)
          return unless hash_with_block?(node)

          node.children.each do |pair_node|
            _key_node, value_node = pair_node.children

            next unless value_node.type == :block
            next if value_node.single_line?

            @block_column_delta = value_node.loc.column

            check_alignment(value_node.children, value_node.loc.column)
          end
        end

        # Refer to Rubocop::Cop::Alignment#check_alignment mixin method for documentation
        def check_alignment(items, base_column)
          each_bad_alignment(items, base_column) do |current|
            expr = current.source_range

            if offenses.any? { |o| within?(expr, o.location) }
              add_offense(nil, location: expr, message: format_message)
            else
              add_offense(current, message: format_message)
            end
          end
        end

        # def register_offense(node, location: nil)
        #   add_offense(node, location: location, message: format_message)
        # end

        def format_message
          format(
            MSG,
            configured_indentation_width: configured_indentation_width,
            block_column_delta: block_column_delta
          )
        end

        def autocorrect(node)
          RuboCop::Cop::AlignmentCorrector.correct(
            processed_source,
            node,
            required_indentation
          )
        end
        
        def required_indentation
          column_delta + configured_indentation_width
        end
      end
    end
  end
end
