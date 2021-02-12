# frozen_string_literal: true

module DatarocketsStyle
  module Cop
    module RSpec
      # Checks that tests use `before` instead of RoR unit-test `setup` method (part of `rspec-rails` gem)
      #
      # bad
      #
      # setup do
      #   allow(post).to receive(:publish!)
      # end
      #
      # good
      #
      # before do
      #   allow(post).to receive(:publish!)
      # end
      class PreferBeforeOverSetup < RuboCop::Cop::Cop
        MSG = "Use `before` instead of `setup`."

        def_node_matcher :setup_call?, <<-PATTERN
          (block
            (send _ :setup)
            (args) _)
        PATTERN

        def on_block(node)
          return unless setup_call?(node)

          add_offense(node)
        end

        def autocorrect(node)
          lambda do |corrector|
            block_internals = node.source.split(/ /)
            corrector.replace node.loc.expression, ["before", *block_internals[1..-1]].join(" ")
          end
        end
      end
    end
  end
end
