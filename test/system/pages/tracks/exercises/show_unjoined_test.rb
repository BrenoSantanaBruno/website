require "application_system_test_case"
require_relative "../../../../support/capybara_helpers"

module Pages
  module Tracks
    module Exercises
      class ShowUnjoinedTest < ApplicationSystemTestCase
        include CapybaraHelpers

        test "exercise page for logged-out user" do
          track = create :track, slug: :ruby_1, title: "Ruby #{SecureRandom.hex}"
          create :hello_world_exercise, track: track
          ce = create :concept_exercise, track: track, slug: 'factory', status: :beta
          create :concept_exercise, track: track, slug: 'movie', status: :wip
          create :concept_exercise, track: track, slug: 'book', status: :active
          create :concept_exercise, track: track, slug: 'team', status: :deprecated
          pe = create :practice_exercise, track: track, slug: 'gram', status: :beta
          create :practice_exercise, track: track, slug: 'iso', status: :wip
          create :practice_exercise, track: track, slug: 'bob', status: :active
          create :practice_exercise, track: track, slug: 'leap', status: :deprecated
          create :concept, track: track, slug: 'basics'
          create :concept, track: track, slug: 'strings'
          create :concept, track: track, slug: 'dates'

          use_capybara_host do
            visit track_exercise_path(track, ce)
            assert_text "Sign up to Exercism to learn and master #{track.title}"
            assert_text "5 exercises"
            assert_text "3 concepts"

            visit track_exercise_path(track, pe)
            assert_text "Sign up to Exercism to learn and master #{track.title}"
            assert_text "5 exercises"
            assert_text "3 concepts"
          end
        end

        test "exercise page for unjoined user" do
          track = create :track, slug: :ruby_1, title: "Ruby #{SecureRandom.hex}"
          create :hello_world_exercise, track: track
          ce = create :concept_exercise, track: track, slug: 'factory', status: :beta
          create :concept_exercise, track: track, slug: 'movie', status: :wip
          create :concept_exercise, track: track, slug: 'book', status: :active
          create :concept_exercise, track: track, slug: 'team', status: :deprecated
          pe = create :practice_exercise, track: track, slug: 'gram', status: :beta
          create :practice_exercise, track: track, slug: 'iso', status: :wip
          create :practice_exercise, track: track, slug: 'bob', status: :active
          create :practice_exercise, track: track, slug: 'leap', status: :deprecated
          create :concept, track: track, slug: 'basics'
          create :concept, track: track, slug: 'strings'
          create :concept, track: track, slug: 'dates'

          user = create :user

          use_capybara_host do
            sign_in!(user)

            visit track_exercise_path(track, ce)
            assert_text "Join the #{track.title} track"
            assert_text "5 exercises"
            assert_text "3 concepts"

            visit track_exercise_path(track, pe)
            assert_text "Join the #{track.title} track"
            assert_text "5 exercises"
            assert_text "3 concepts"
          end
        end
      end
    end
  end
end