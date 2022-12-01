# frozen_string_literal: true

module RubocopExamples
  class HashStyles
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
