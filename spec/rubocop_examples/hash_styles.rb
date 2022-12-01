# frozen_string_literal: true

module RubocopExamples
  class HashStyles
    def initialize
      # issue: https://github.com/datarockets/ruby-style/issues/179
      @test = {
        test: lambda do |i|
          i
        end,
      }
    end

    # issue: https://github.com/datarockets/ruby-style/issues/176
    def test1
      MemberResponse.create!({
        subscription: member_response.subscription,
        question_code: "investment_amount",
        response_text: astr,
      })
    end
  end
end
