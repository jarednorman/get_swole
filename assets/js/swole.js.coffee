#= require zepto/zepto
#= require bacon/dist/Bacon
#= require lodash/lodash
#= require handlebars/handlebars
#= require rails-behaviors/method

Handlebars.registerHelper "stringify", (data) -> JSON.stringify(data)

programTemplate = Handlebars.compile """
  <div class="program-maxes">
    {{#each exerciseTitles}}
      <div class="program-max">{{this}}</div>
    {{/each}}
    {{#each weeks}}
      <div class="program-week">
        {{#each this}}
          <div class="program-week-day" data-sets='{{stringify this}}'>
            &nbsp;
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
    _.map _.zip(names, maxes), (exercise) -> "#{exercise[0]}: #{exercise[1]}"

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

  templateParams = Bacon.combineTemplate({
    exerciseTitles: exerciseTitles,
    weeks: weeks
  })

  templateParams.onValue (params) ->
    $('.program').html programTemplate(params)
