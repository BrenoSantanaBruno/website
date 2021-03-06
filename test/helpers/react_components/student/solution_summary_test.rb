require_relative "../react_component_test_case"

module Student
  class SolutionSummaryTest < ReactComponentTestCase
    test "component renders correctly" do
      track = create :track
      exercise = create :concept_exercise, track: track
      solution = create :concept_solution, exercise: exercise
      iteration = create :iteration, solution: solution

      component = ReactComponents::Student::SolutionSummary.new(solution).to_s

      assert_component(
        component,
        "student-solution-summary",
        {
          solution: SerializeSolutionForStudent.(solution),
          request: {
            endpoint: Exercism::Routes.api_solution_url(solution.uuid, sideload: [:iterations]),
            options: {
              initialData: {
                iterations: [SerializeIteration.(iteration)]
              }
            }
          },
          is_concept_exercise: true,
          links: {
            tests_passed_locally_article: "#",
            all_iterations: Exercism::Routes.track_exercise_iterations_path(track, exercise),
            community_solutions: "#",
            learn_more_about_mentoring_article: "#",
            mentoring_info: "#",
            complete_exercise: Exercism::Routes.complete_api_solution_url(solution.uuid)
          }
        }
      )
    end
  end
end