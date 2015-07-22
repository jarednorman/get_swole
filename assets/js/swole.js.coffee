#= require zepto/zepto
#= require bacon/dist/Bacon
#= require lodash/lodash
#= require handlebars/handlebars
#= require rails-behaviors/method

Handlebars.registerHelper "exerciseName", (exercise) -> exercise.name
Handlebars.registerHelper "exerciseMax", (exercise) -> exercise.max
Handlebars.registerHelper "stringify", (data) -> JSON.stringify(data)
Handlebars.registerHelper "displayReps", (set) -> set.reps
Handlebars.registerHelper "displayWeight", (set) -> set.weight

dayTemplate = Handlebars.compile """
  {{#each sets}}
    <div>{{displayReps this}} x {{displayWeight this}}</div>
  {{/each}}
"""

programTemplate = Handlebars.compile """
  <div class="program-maxes">
    {{#each exerciseTitles}}
      <div class="program-max">
        {{exerciseName this}}
        <br>
        {{exerciseMax this}}
      </div>
    {{/each}}
    {{#each weeks}}
      <div class="program-week">
        {{#each this}}
          <div class="program-week-day" data-sets='{{stringify this}}'>
          </div>
        {{/each}}
      </div>
    {{/each}}
  </div>
"""

$ ->
  program = Bacon.constant(swoleProgram)

  exerciseNames = program
    .map (program) ->
      _.map program, (exercise) -> exercise.name

  exerciseMaxes = program
    .map (program) ->
      _.map program, (exercise) -> exercise.oneRepMax

  exerciseTitles = exerciseNames.combine exerciseMaxes, (names, maxes) ->
    _.map _.zip(names, maxes), (exercise) -> {
      name: exercise[0],
      max: exercise[1]
    }

  weeks = program
    .map (program) ->
      _.map program, (exercise) ->
        exercise.weeks
    .map (weeks) ->
      # TODO: Jared is an idiot and rewrote unzip.
      daysInCycle = weeks[0].length
      _.times daysInCycle, (n) ->
        _.map weeks, (exerciseDays) ->
          exerciseDays[n]

  overviewTemplateParams = Bacon.combineTemplate({
    exerciseTitles: exerciseTitles,
    weeks: weeks
  })

  overviewTemplateParams.onValue (params) ->
    $('.program').html programTemplate(params)

  activeDay = $('.program').asEventStream('click', '.program-week-day')
    .map (clickEvent) -> $(clickEvent.target).data("sets")

  dayTemplateParams = activeDay.map (day) -> {sets: day}

  dayTemplateParams.onValue (params) ->
    $('.program-day').html dayTemplate(params)
