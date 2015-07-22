module GetSwole
  class Schedule
    def initialize(user)
      @user = user
    end

    def to_json
      [
        {
          name: "Bench Press",
          oneRepMax: user.one_rep_max_bench,
          weeks: calculate_weeks(user.one_rep_max_bench)
        },
        {
          name: "Deadlift",
          oneRepMax: user.one_rep_max_deadlift,
          weeks: calculate_weeks(user.one_rep_max_deadlift)
        },
        {
          name: "Military Press",
          oneRepMax: user.one_rep_max_military,
          weeks: calculate_weeks(user.one_rep_max_military)
        },
        {
          name: "Squat",
          oneRepMax: user.one_rep_max_squat,
          weeks: calculate_weeks(user.one_rep_max_squat)
        }
      ].to_json
    end

    private

    REPS = [
      [5, 5, 5, 10, 10, 10, 10, 10],
      [3, 3, 3, 10, 10, 10, 10, 10],
      [5, 3, 1, 10, 10, 10, 10, 10],
      [5, 5, 5]
    ]

    SCALE = [
      [0.65, 0.75, 0.85, 0.50, 0.50, 0.50, 0.50, 0.50],
      [0.70, 0.80, 0.90, 0.50, 0.50, 0.50, 0.50, 0.50],
      [0.75, 0.85, 0.95, 0.50, 0.50, 0.50, 0.50, 0.50],
      [0.55, 0.65, 0.75]
    ]

    BAR = 45

    attr_reader :user

    def calculate_weeks(one_rep_max)
      (0..3).map do |week|
        (0..REPS[week].length - 1).map do |set|
          {
            reps: REPS[week][set],
            weight: weight(SCALE[week][set], one_rep_max)
          }
        end
      end
    end

    def weight(scale, one_rep_max)
      return scale if scale.nil?
      round_to_nearest(
        scale * one_rep_max - BAR,
        user.nearest_round || 10
      ) + BAR
    end

    def round_to_nearest(value, nearest)
      (value / nearest).round * nearest
    end
  end
end
