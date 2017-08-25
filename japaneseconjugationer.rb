require "CSV"
require_relative 'conjugationermodule'

    $arr_of_arrs = CSV.read('jlptverbs5.csv')

    def vocab_chooser

      p "Would you like to choose specific words to play with?"
      $vocab_chooser_option = gets.chomp

      if $vocab_chooser_option == 'y' || $vocab_chooser_option == 'yes'

      incrementer = 0

      $verb_array_row_hash = {} #this hash has the infinitive as the key and the row number as the value
      while incrementer < 214

        incrementer += 1
        p verb_infinitive = $arr_of_arrs[incrementer][1]

        $verb_array_row_hash[verb_infinitive] = incrementer

      end

      $verb_array_row_hash
      p "What words would you like to play with?"
      p "Bear in mind, your selection is limited to the few hundred verbs in our database."

      $key_array = []
      build_array = true
      while build_array

        verb_select = gets.chomp
        if verb_select == 'done'
          value_builder
        end
        $key_array << verb_select

        p $key_array
      end
      elsif $vocab_chooser_option == 'n' || $vocab_chooser_option == 'no'
        round
      end
    #  end
    end

def form_options
  p "What form do you want to play with: plain non-past/plain past/te form/i form/ifs/potential/passive/causative/causative passive/volitional/conjectural/alternative/imperative?"
  $form_option = gets.chomp
  if $form_option  == "plain non-past" || $form_option  == "np"
    $verb_form = (2..5)
  elsif $form_option  == "plain past" || $form_option  == 'pp'
    $verb_form = (6..9)
  elsif $form_option  == "te form" || $form_option  == 'tf'
    $verb_form = (10..14)
  elsif $form_option  == "i form"
    $verb_form = (15..15)
  elsif $form_option  == "ifs"
    $verb_form = (16..26)
  elsif $form_option  == "potential" || $form_option  == 'po'
    $verb_form = (27..30)
  elsif $form_option  == "passive" || $form_option  == 'pa'
    $verb_form = (31..34)
  elsif $form_option  == "causative" || $form_option  == 'c'
    $verb_form = (35..42)
  elsif $form_option  == "causative passive" || $form_option  == 'cp'
    $verb_form = (43..50)
  elsif $form_option  == "volitional" || $form_option  == 'v'
    $verb_form = (51..54)
  elsif $form_option  == "conjectural" || $form_option  == 'co'
    $verb_form = (55..58)
  elsif $form_option  == "alternative" || $form_option  == 'a'
    $verb_form = (59..62)
  elsif $form_option  == "imperative" || $form_option  == 'i'
    $verb_form = (63..66)
  else
    "Please type an option from the list."
  end
  time_length
end

def round

  $incorrect_array = []
  t1 = Time.now
  $amt_correct = 0
  $amt_incorrect = 0


  while true

    verb_form_chooser = rand($verb_form)
    row_specifier = (rand(1..216))
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
     delta_i = delta.to_i


     if delta_i <= -$round_length
       $incorrect_string = $incorrect_array.to_s.gsub(Regexp.union('"', '[', ']', "~,"), '')
       decimal_correct = ($amt_correct / ($amt_correct + $amt_incorrect.to_f))
       percentage_correct = (decimal_correct.round(2) * 100).to_i
       p "Good job you got #{$amt_correct} correct and #{$amt_incorrect} incorrect!"
       p "That's a #{percentage_correct}%!!"
       if $incorrect_array.count > 0
       p "Here are the answers that you missed: #{$incorrect_string}."
       p "Would you like to export them into a .txt file in order to keep a study list?"
       study_list
     else
       continue.
     end

     end
end
end
end
form_options

# beta testing : all of the verbs are running as godan even when they are ichidan,
#the pp form includes the polite te form and te form, there are spaces that need to be removed from correct_answer s**, no affirmative past tense,

# missing casual(contextual) provisional a la 合うなら**
#"Polite Causative Passive" 焼かせられます **
# "Causal Passive Negative",Causal Passive Negative
# 言わせられない
