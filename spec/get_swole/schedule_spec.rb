require 'spec_helper'

RSpec.describe GetSwole::Schedule do
  let(:user) do
    GetSwole::User.new(
      one_rep_max_bench: 125,
      one_rep_max_deadlift: 205,
      one_rep_max_military: 60,
      one_rep_max_squat: 150
    )
  end

  let(:schedule) { GetSwole::Schedule.new(user) }

  describe ".to_json" do
    subject { schedule.to_json }

    it "renders to the correct json" do
      expect(subject).to eq [
        {
          name:"Bench Press",
          oneRepMax:125,
          weeks: [
            [
              {reps:5, weight:85},
              {reps:5, weight:95},
              {reps:5, weight:105},
              {reps:10, weight:65},
              {reps:10, weight:65},
              {reps:10, weight:65},
              {reps:10, weight:65},
              {reps:10, weight:65}
            ],
            [
              {reps:3, weight:85},
              {reps:3, weight:105},
              {reps:3, weight:115},
              {reps:10, weight:65},
              {reps:10, weight:65},
              {reps:10, weight:65},
              {reps:10, weight:65},
              {reps:10, weight:65}
            ],
            [
              {reps:5, weight:95},
              {reps:3, weight:105},
              {reps:1, weight:115},
              {reps:10, weight:65},
              {reps:10, weight:65},
              {reps:10, weight:65},
              {reps:10, weight:65},
              {reps:10, weight:65}
            ],
            [
              {reps:5, weight:65},
              {reps:5, weight:85},
              {reps:5, weight:95}
            ]
          ]
        },
        {
          name:"Deadlift",
          oneRepMax:205,
          weeks: [
            [
              {reps:5, weight:135},
              {reps:5, weight:155},
              {reps:5, weight:175},
              {reps:10, weight:105},
              {reps:10, weight:105},
              {reps:10, weight:105},
              {reps:10, weight:105},
              {reps:10, weight:105}
            ],
            [
              {reps:3, weight:145},
              {reps:3, weight:165},
              {reps:3, weight:185},
              {reps:10, weight:105},
              {reps:10, weight:105},
              {reps:10, weight:105},
              {reps:10, weight:105},
              {reps:10, weight:105}
            ],
            [
              {reps:5, weight:155},
              {reps:3, weight:175},
              {reps:1, weight:195},
              {reps:10, weight:105},
              {reps:10, weight:105},
              {reps:10, weight:105},
              {reps:10, weight:105},
              {reps:10, weight:105}
            ],
            [
              {reps:5, weight:115},
              {reps:5, weight:135},
              {reps:5, weight:155}
            ]
          ]
        },
        {
          name:"Military Press",
          oneRepMax:60,
          weeks: [
            [
              {reps:5, weight:35},
              {reps:5, weight:45},
              {reps:5, weight:55},
              {reps:10, weight:25},
              {reps:10, weight:25},
              {reps:10, weight:25},
              {reps:10, weight:25},
              {reps:10, weight:25}
            ],
            [
              {reps:3, weight:45},
              {reps:3, weight:45},
              {reps:3, weight:55},
              {reps:10, weight:25},
              {reps:10, weight:25},
              {reps:10, weight:25},
              {reps:10, weight:25},
              {reps:10, weight:25}
            ],
            [
              {reps:5, weight:45},
              {reps:3, weight:55},
              {reps:1, weight:55},
              {reps:10, weight:25},
              {reps:10, weight:25},
              {reps:10, weight:25},
              {reps:10, weight:25},
              {reps:10, weight:25}
            ],
            [
              {reps:5, weight:35},
              {reps:5, weight:35},
              {reps:5, weight:45}
            ]
          ]
        },
        {
          name:"Squat",
          oneRepMax:150,
          weeks: [
            [
              {reps:5, weight:95},
              {reps:5, weight:115},
              {reps:5, weight:125},
              {reps:10, weight:75},
              {reps:10, weight:75},
              {reps:10, weight:75},
              {reps:10, weight:75},
              {reps:10, weight:75}
            ],
            [
              {reps:3, weight:105},
              {reps:3, weight:125},
              {reps:3, weight:135},
              {reps:10, weight:75},
              {reps:10, weight:75},
              {reps:10, weight:75},
              {reps:10, weight:75},
              {reps:10, weight:75}
            ],
            [
              {reps:5, weight:115},
              {reps:3, weight:125},
              {reps:1, weight:145},
              {reps:10, weight:75},
              {reps:10, weight:75},
              {reps:10, weight:75},
              {reps:10, weight:75},
              {reps:10, weight:75}
            ],
            [
              {reps:5, weight:85},
              {reps:5, weight:95},
              {reps:5, weight:115}
            ]
          ]
        }
      ].to_json
    end
  end
end
