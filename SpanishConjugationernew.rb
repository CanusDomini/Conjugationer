require "CSV"
require_relative 'conjugationermodule'
$arr_of_arrs = CSV.read('spanish_verb_database_fixed.csv')

$incrementer = -17
$upper_limit = 11430
$language_specific_increment = 18
$language_specific_form_option = "indicative/subjunctive?"
$tense_option_hash_of_arrs = {"indicative" => ["Present", "Future", "Imperfect", "Preterite", "Conditional", "Present Perfect", "Future Perfect", "Past Perfect", "Preterite (Archaic)", "Conditional Perfect"], "subjunctive" => ["Present", "Imperfect", "Future", "Present Perfect", "Future Perfect", "Past Perfect"]}
$form_hash_of_hashes = {"indicative" => {"Present" => 1, "Future" => 2, "Imperfect" => 3, "Preterite" => 4, "Conditional" => 5, "Present Perfect" => 6, "Future Perfect" => 7, "Past Perfect" => 8, "Preterite (Archaic)" => 9, "Conditional Perfect" => 10}, "subjunctive" => {"Present" => 11, "Imperfect" => 12, "Future" => 13, "Present Perfect" => 14, "Future Perfect" => 15, "Past Perfect" => 16}}
$row_specifier_interval = 18
$row_specifier_range = 0..635

def form_options
question_beginning = "Which would you like to play with "
p question_beginning + $language_specific_form_option
$mood = gets.chomp
form_specific_tense_option = $tense_option_hash_of_arrs[$mood]
p question_beginning + form_specific_tense_option.to_s.gsub(Regexp.union('"', '[', ']'), '')
$tense_option = gets.chomp
p $tense_choice = $form_hash_of_hashes[$mood][$tense_option]

time_length
end

def round

  $incorrect_array = []
  t1 = Time.now
  $amt_correct = 0
  $amt_incorrect = 0


  while true


    row_specifier = (18 * rand(0..635))
    if $vocab_chooser_option == 'y' || $vocab_chooser_option == 'yes'
      verb_row = $arr_of_arrs[$mood[$tense_choice] + $value_array.sample]
    elsif $vocab_chooser_option == 'n' || $vocab_chooser_option == 'no'
      verb_row = $arr_of_arrs[$tense_choice + row_specifier]
    end
    # verb_row = $arr_of_arrs[$mood[$tense_choice] + row_specifier]
    infinitive_verb = verb_row[1]
    random_form_chooser = rand(7..12)
    correct_answer = verb_row[random_form_chooser]
    form_question = $arr_of_arrs[0][random_form_chooser]
    mood = verb_row[3]
    meaning = verb_row[2]
    question = "#{infinitive_verb} #{form_question}"
    #question = "What is the #{form_question} #{tense_choice} of #{infinitive_verb} in the #{mood} mood?"
    correct_answer = verb_row[random_form_chooser]

    p question
    p form_question

     user_answer = gets.chomp
    #
     if user_answer == correct_answer

       $amt_correct += 1

       p "Correct! :)"

     else

      $amt_incorrect += 1
      $incorrect_array.push(correct_answer)

      p "Incorrect."
      p "Would you like to see the correct answer?"
      p "y/n?"

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

form_options
