ages = [
  '<15',
  '15-20',
  '21-25',
  '26-30',
  '31-35',
  '36-50',
  '51-75',
  '>75'
]

experience_levels= [
  'No/Little',
  'Moderate',
  'Experienced',
  'Unknown'
]

outcomes = [
  'Deadly',
  'Serious',
  'Minor',
  'Head / Brain Injury'
]

types_of_climbing = [
  'Descent',
  'Roped',
  'Trad Climbing',
  'Sport',
  'Top-Rope',
  'Aid & Big Wall Climbing',
  'Unroped',
  'Solo',
  'Climbing Alone',
  'Bouldering',
  'Non-climbing',
  'Alpine/Mountaineering',
  'Ice Climbing'
]

alpine_or_ice_factors = [
  'Piton/Ice Screw',
  'Ascent Illness',
  'Crampon Issues',
  'Glissading',
  'Ski-related',
  'Poor Position'
]

natural_factors = [ 
  'Visibility',
  'Severe Weather / Act of God',
  'Natural Rockfall',
  'Wildlife'
]

alpine_or_ice_natural_factors = [
  'Avalanche',
  'Poor Cond/Seasonal Risk',
  'Cornice / Snow Bridge Collapse',
  'Bergschrund',
  'Crevasse / Moat / Berschrund',
  'Icefall / Serac / Ice Avalanche',
  'Exposure'
]

human_factors = [
  'Non-Ascent Illness',
  'Off-route',
  'Rushed',
  'Run Out',
  'Crowds',
  'Inadequate Food/Water',
  'No Helmet',
  'Late in Day',
  'Late Start',
  'Party Separated',
  'Ledge Fall',
  'Gym / Artificial',
  'Gym Climber',
  'Fatigue',
  'Large Group',
  'Distracted',
  'Object Dropped/Dislodged',
  'Handhold/Foothold Broke',
  'Knot & Tie-in Error',
  'No Backup or End Knot',
  'Gear Broke',
  'Intoxicated',
  'Inadequate Equipment',
  'Inadequate Protection / Pulled',
  'Anchor Failure / Error',
  'Stranded / Lost / Overdue',
  'Belay Error',
  'Rappel Error',
  'Lowering Error',
  'Miscommunication',
  'Pendulum'
]

months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
]

desc 'create tags for incidents'
task :create_tags => :environment do
  counter = 0

  puts 'creating age range tags'
  ages.each do |age_range| 
    counter += 1
    Tag.create(category: 'Age Range', label: age_range)
  end

  puts 'creating experience level tags'
  experience_levels.each do |experience_level|
    counter += 1
    Tag.create(category: 'Experience Level', label: experience_level)
  end
  
  puts 'creating outcome tags'
  outcomes.each do |outcome|
    counter += 1
    Tag.create(category: 'Outcome', label: outcome)
  end

  puts 'creating types_of_climbing tags'
  types_of_climbing.each do |climbing_type|
    counter += 1
    Tag.create(category: 'Type of Climbing', label: climbing_type)
  end

  puts 'creating alpine_or_ice factor tags'
  alpine_or_ice_factors.each do |alpine_factor|
    counter += 1
    Tag.create(category: 'Alpine or Ice Factor', label: alpine_factor)
  end

  puts 'creating natural factor tags'
  natural_factors.each do |natural_factor|
    counter += 1
    Tag.create(category: 'Natural Factors', label: natural_factor)
  end

  puts 'creating alpine_or_ice_natural_factors tags'
  alpine_or_ice_natural_factors.each do |alpine_natural_factor|
    counter += 1
    Tag.create(category: 'Alpine or Ice Natural Factors', label: alpine_natural_factor)
  end

  puts 'creating human_factor tags'
  human_factors.each do |human_factor|
    counter += 1
    Tag.create(category: 'Human Factor', label: human_factor)
  end

  puts 'creating month tags'
  months.each do |month|
    counter += 1
    Tag.create(category: 'Month', label: month)
  end

  puts "Created #{counter} tags"
end
