require "CSV"
require_relative 'conjugationermodule'

$incrementer = 0
$language_specific_increment = 1
$language_specific_form_option = "plain non-past/plain past/te form/i form/ifs/potential/passive/causative/causative passive/volitional/conjectural/alternative/imperative/honorific?"
p "Would you like to play with N2 or N4"
level_option = gets.chomp.upcase
if level_option == "N2"
  $row_specifier_range = 1..505
  $arr_of_arrs = CSV.read('jlptverbs100.csv')
  $upper_limit = 505
  $form_hash = {"np" => 2..5, "p" => 6..9, "tf" => 10..14, "if" => 15, "ifs" => 16..27, "po" => 28..31, "pa" => 32..35, "c" => 36..42, "cp" => 43..46, "v" => 47..50, "co" => 51..54, "a" => 55..58, "i" => 59..62, "h" => 63..66, "non-past" => 2..5, "past" => 6..9, "te form" => 10..14, "i form" => 15, "potential" => 28..31, "passive" => 32..35, "causative" => 36..42, "causative passive" => 43..46, "volitional" => 47..50, "conjectural" => 51..54, "alternative" => 55..58, "imperative" => 59..62, "honorific" => 63..66}
elsif level_option == "N4"
  $row_specifier_range = 1..190
  $arr_of_arrs = CSV.read('jlptverbs5.csv')
  $upper_limit = 190
  $form_hash = {"np" => 2..5, "p" => 6..9, "tf" => 10..14, "if" => 15, "ifs" => 16..27, "po" => 28..31, "pa" => 32..35, "c" => 36..43, "cp" => 48..51, "v" => 52..55, "co" => 56..59, "a" => 60..63, "i" => 64..67, "h" => 68..71, "non-past" => 2..5, "past" => 6..9, "te form" => 10..14, "i form" => 15, "potential" => 28..31, "passive" => 32..35, "causative" => 36..43, "causative passive" => 48..51, "volitional" => 52..55, "conjectural" => 56..59, "alternative" => 60..63, "imperative" => 64..67, "honorific" => 68..71}
else
  p "Please enter N2 or N4."
  level_and_language
end

def form_options
  # if $language_option = "JAPANESE"
question_beginning = "Which would you like to play with "
p question_beginning + $language_specific_form_option
$form_option = gets.chomp
$verb_form = $form_hash[$form_option]
time_length
end

def round

  $incorrect_array = []
  t1 = Time.now
  $amt_correct = 0
  $amt_incorrect = 0


  while true
    p $verb_form
    verb_form_chooser = rand($verb_form)
    row_specifier = (rand($row_specifier_range))
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
form_options
