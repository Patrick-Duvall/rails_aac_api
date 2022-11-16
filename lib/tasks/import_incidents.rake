require 'csv'
require 'pry'

tagmap = {
  '15'.to_sym => '<15',
  '1520'.to_sym => '15-20',
  '2125'.to_sym => '21-25',
  '2630'.to_sym => '26-30',
  '3135'.to_sym => '31-35',
  '3650'.to_sym => '36-50',
  '5175'.to_sym => '51-75',
  '75'.to_sym => '>75',
  nolittle: 'No/Little',
  moderate: 'Moderate',
  experienced: 'Experienced',
  unknown: 'Unknown',
  deadly: 'Deadly',
  serious: 'Serious',
  minor: 'Minor',
  head_brain_injury: 'Head / Brain Injury',
  descent: 'Descent',
  roped: 'Roped',
  trad_climbing: 'Trad Climbing',
  sport: 'Sport',
  toprope: 'Top-Rope',
  aid_big_wall_climbing: 'Aid & Big Wall Climbing',
  pendulum: 'Pendulum',
  unroped: 'Unroped',
  solo: 'Solo',
  climbing_alone: 'Climbing Alone',
  bouldering: 'Bouldering',
  nonclimbing: 'Non-climbing',
  alpinemountaineering: 'Alpine/Mountaineering',
  pitonice_screw: 'Piton/Ice Screw',
  ascent_illness: 'Ascent Illness',
  crampon_issues: 'Crampon Issues',
  ice_climbing: 'Ice Climbing',
  glissading: 'Glissading',
  skirelated: 'Ski-related',
  poor_position: 'Poor Position',
  poor_condseasonal_risk: 'Poor Cond/Seasonal Risk',
  avalanche: 'Avalanche',
  cornice_snow_bridge_collapse: 'Cornice / Snow Bridge Collapse',
  bergschrund: 'Bergschrund',
  crevasse_moat_berschrund: 'Crevasse / Moat / Berschrund',
  icefall_serac_ice_avalanche: 'Icefall / Serac / Ice Avalanche',
  exposure: 'Exposure',
  nonascent_illness: 'Non-Ascent Illness',
  visibility: 'Visibility',
  severe_weather: 'Severe Weather / Act of God',
  wildlife: 'Wildlife',
  natural_rockfall: 'Natural Rockfall',
  offroute: 'Off-route',
  rushed: 'Rushed',
  run_out: 'Run Out',
  crowds: 'Crowds',
  inadequate_foodwater: 'Inadequate Food/Water',
  no_helmet: 'No Helmet',
  late_in_day: 'Late in Day',
  late_start: 'Late Start',
  party_separated: 'Party Separated',
  ledge_fall: 'Ledge Fall',
  gym_artificial: 'Gym / Artificial',
  gym_climber: 'Gym Climber',
  fatigue: 'Fatigue',
  large_group: 'Large Group',
  distracted: 'Distracted',
  object_droppeddislodged: 'Object Dropped/Dislodged',
  handholdfoothold_broke: 'Handhold/Foothold Broke',
  knot_tiein_error: 'Knot & Tie-in Error',
  no_backup_or_end_knot: 'No Backup or End Knot',
  gear_broke: 'Gear Broke',
  intoxicated: 'Intoxicated',
  inadequate_equipment: 'Inadequate Equipment',
  inadequate_protection_pulled: 'Inadequate Protection / Pulled',
  anchor_failure_error: 'Anchor Failure / Error',
  stranded_lost_overdue: 'Stranded / Lost / Overdue',
  belay_error: 'Belay Error',
  rappel_error: 'Rappel Error',
  lowering_error: 'Lowering Error',
  miscommunication: 'Miscommunication',
  january: 'January',
  february: 'February',
  march: 'March',
  april: 'April',
  may: 'May',
  june: 'June',
  july: 'July',
  august: 'August',
  september: 'September',
  october: 'October',
  november: 'November',
  december: 'December'
}

desc 'import accident data to DB'
task import_incidents: :environment do
  incidents_table = CSV.table('lib/tasks/accidents-data.csv')
  incident_counter = 0
  tag_counter = 0

  incidents_table.each do |incident|
    # Description blocks contain location, description, and analysis
    # Location is always the first line, and the description and analysis are seperated by 'analysis'
    # on its own line. So, we split the array, find the index of 'analysis' assign the first line to
    # location, and the lines on either side of 'analysis' to description and analysis.
    text = incident[:text]
    lines = text.split("\n")
    location = lines[0]

    analysis_start = lines.index { |line| line.match?(/analysis/i) }

    if analysis_start
      description = lines[1...analysis_start].join(' ')
      analysis = lines[analysis_start + 1 .. -1].join(' ')
    else

      description = lines[1..-1].join(' ') # needed for when 'analysis' split is not present
    end

    ActiveRecord::Base.transaction do
      new_incident = Incident.create!(
        title: incident[:accident_title],
        year: incident[:publication_year],
        location: location,
        description: description,
        analysis: analysis
      )

      tagmap.each_key do |tag|
        next unless incident[tag]
        # Transform csv to match tag format for ages
        tag = '<15' if tag == '15'
        tag = '>75' if tag == '75'

        tag_iterations = incident[tag] == 'Y' ? 1 : incident[tag] # needed to normalize 'Y' in data
        tag_iterations.times do # needed for multiple age tagsgs
          IncidentTag.create!(
            incident: new_incident,
            tag: Tag.find_by(label: tagmap[tag])
          )
          tag_counter += 1
        end
      end
    end
    incident_counter += 1
  end
  puts "Created #{incident_counter} Incidents with #{tag_counter} tags"
end
