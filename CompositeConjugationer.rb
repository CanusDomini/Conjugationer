require "CSV"
require_relative 'conjugationermodule'

def level_and_language
  p "What language do you want to play with: Japanese/German/Spanish/Italian?"
  $language_option = gets.chomp.upcase

  if $language_option == "JAPANESE" || $language_option == "J"
    $row_specifier_interval = 1
    $incrementer = 0
    $language_specific_increment = 1
    $language_specific_form_option = "plain non-past/plain past/te form/i form/ifs/potential/passive/causative/causative passive/volitional/conjectural/alternative/imperative/honorific?"
    p "Would you like to play with N2 or N4"
    level_option = gets.chomp.upcase
    if level_option == "N2"
      $row_specifier_range = 1..505
      $arr_of_arrs = CSV.read('jlptverbs100.csv')
      $upper_limit = 505
    elsif level_option == "N4"
      $row_specifier_range = 1..190
      $arr_of_arrs = CSV.read('jlptverbs5.csv')
      $upper_limit = 190
      $form_hash = {"np" => 2..5, "p" => 6..9, "tf" => 10..14, "if" => 15, "ifs" => 16..27, "po" => 28..31, "pa" => 32..35, "c" => 36..43, "cp" => 48..51, "v" => 52..55, "co" => 56..59, "a" => 60..63, "i" => 64..67, "h" => 68..71, "non-past" => 2..5, "past" => 6..9, "te form" => 10..14, "i form" => 15, "potential" => 28..31, "passive" => 32..35, "causative" => 36..43, "causative passive" => 48..51, "volitional" => 52..55, "conjectural" => 56..59, "alternative" => 60..63, "imperative" => 64..67, "honorific" => 68..71}
    else
      p "Please enter N2 or N4."
      level_and_language
    end
  elsif $language_option == "GERMAN" || $language_option == "G"
    $arr_of_arrs = CSV.read('GermanVerbs.csv')
    $incrementer = 0
    $upper_limit = 431
    $language_specific_increment = 1
    $language_specific_form_option = "indicative/subjunctive/conditional?"
    $tense_option_hash_of_arrs = {"indicative" => ["present", "perfect", "past", "pluperfect", "future 1", "future 2"], "subjunctive" => ["present", "perfect", "past", "pluperfect"], "conditional" => ["present", "perfect"]}
    $form_hash_of_hashes = {"indicative" => {"present" => 6..11, "perfect" => 13..18, "past" => 20..25, "pluperfect" => 27..32, "future 1" => 34..39, "future 2" => 41..46}, "subjunctive" => {"present" => 48..53, "perfect" => 55..60, "past" => 62..67, "pluperfect" => 69..74}, "conditional" => {"present" => 76..81, "perfect" => 83..88}}
    $row_specifier_interval = 1
    $row_specifier_range = 1..431
  elsif $language_option == "SPANISH" || $language_option == "S"
    $arr_of_arrs = CSV.read('spanish_verb_database_fixed.csv')
    $incrementer = -17
    $upper_limit = 11430
    $language_specific_increment = 18
    $language_specific_form_option = "indicative/subjunctive?"
    $tense_option_hash_of_arrs = {"indicative" => ["Present", "Future", "Imperfect", "Preterite", "Conditional", "Present Perfect", "Future Perfect", "Past Perfect", "Preterite (Archaic)", "Conditional Perfect"], "subjunctive" => ["Present", "Imperfect", "Future", "Present Perfect", "Future Perfect", "Past Perfect"]}
    $form_hash_of_hashes = {"indicative" => {"Present" => 2, "Future" => 3, "Imperfect" => 4, "Preterite" => 5, "Conditional" => 6, "Present Perfect" => 7, "Future Perfect" => 8, "Past Perfect" => 9, "Preterite (Archaic)" => 10, "Conditional Perfect" => 11}, "subjunctive" => {"Present" => 11, "Imperfect" => 12, "Future" => 13, "Present Perfect" => 14, "Future Perfect" => 15, "Past Perfect" => 16}}
    $row_specifier_interval = 18
    $row_specifier_range = 0..635
  elsif $language_option == "ITALIAN" || $language_option == "I"
    $arr_of_arrs = CSV.read('italianverbs2.csv')
    $incrementer = -14
    $upper_limit = 3075
    $language_specific_increment = 15
    $language_specific_form_option = "indicativo/congiuntivo/condizionale/imperativo?"
    $tense_option_hash_of_arrs =
    $form_hash_of_hashes =
    $row_specifier_interval = 15
    $row_specifier_range = 0..206
  else
    p "Please enter one of the aforementioned languages."
    level_and_language
  end
  form_options
end

def form_options
  # if $language_option = "JAPANESE"
question_beginning = "Which would you like to play with "
p question_beginning + $language_specific_form_option
$form_option = gets.chomp
form_specific_tense_option = $tense_option_hash_of_arrs[$form_option]
p question_beginning + form_specific_tense_option.to_s.gsub(Regexp.union('"', '[', ']'), '')
$tense_option = gets.chomp
p $verb_form = $form_hash_of_hashes[$form_option][$tense_option]

time_length
end

def round

$incorrect_array = []
t1 = Time.now
$amt_correct = 0
$amt_incorrect = 0


while true

verb_form_chooser = rand($verb_form)
row_specifier = ($row_specifier_interval * rand($row_specifier_range))
if $vocab_chooser_option == 'y' || $vocab_chooser_option == 'yes'
  verb_row = $arr_of_arrs[$value_array.sample]
elsif $vocab_chooser_option == 'n' || $vocab_chooser_option == 'no'
  verb_row = $arr_of_arrs[row_specifier]
end
# verb_row = $arr_of_arrs[row_specifier]
hiragana_verb = verb_row[1]
kanji_verb = verb_row[2]
correct_answer = verb_row[verb_form_chooser]
form_question = $arr_of_arrs[0][verb_form_chooser]
mood = verb_row[3]
meaning = verb_row[0]
#question = "What is the #{form_question} #{tense_choice} of #{infinitive_verb} in the #{mood} mood?"
# p $form_option
# p $verb_form
p verb_row
p row_specifier
p verb_form_chooser
p "#{kanji_verb} (#{hiragana_verb})"
p "#{meaning}"
p form_question

 user_answer = gets.chomp
#
 if user_answer == correct_answer

   $amt_correct += 1

   p "Correct! :)"

 else

  $amt_incorrect += 1

  p "Incorrect."
  p "Would you like to see the correct answer?"
  p "y/n?"

  $incorrect_array.push(correct_answer)
  hint_request = gets.chomp

  if hint_request == "y"
    p correct_answer

   end
 end

 t2 = Time.now
 delta = t1 - t2
 $delta_i = delta.to_i
 round_ending


end
end
#form_options
 level_and_language
