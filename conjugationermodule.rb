
# module Conjugationermodule
#   extend self
  
  require 'CSV'
    $arr_of_arrs = CSV.read('jlptverbs5.csv')
class Conjugationer
    def vocab_chooser

      p "Would you like to choose specific words to play with?"
      $vocab_chooser_option = gets.chomp

      if $vocab_chooser_option == 'y' || $vocab_chooser_option == 'yes'

      incrementer = 0

      $verb_array_row_hash = {} #this hash has the infinitive as the key and the row number as the value
      while incrementer < 161

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
def value_builder

      $value_array = []
      $key_array.each do |key|
        value = $verb_array_row_hash[key]
        $value_array << value
      end
      round
    end

    def time_length

      while true

        p "How many seconds do you want your round to be?"

        length_option = gets.chomp

        if (/\A\d+\z/ =~ length_option)

          $round_length = length_option.to_i
          vocab_chooser

        else

          p "Please enter a number."
          time_length
        end
      end
    end
        # HOW CAN I DISABLE TIMED ROUNDS AND MAKE THEM UNLIMITED TIME?
    #   p "Would you like your rounds to be timed: y/n?"
    # timed_option = gets.chomp
    #
    # if timed_option == 'y'
    #
    #   time_length
    #
    # elsif timed_option == 'n'
    #   @round_length = -1
    #   round
    #
    # else
    #   p "Please enter {y} or {n}"
    # end

def form
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

def continue
  p "Would you like to continue?"
  p "y/n?"
  continue_option = gets.chomp
  if continue_option == 'y'
    form
  elsif continue_option == 'n'
    exit[0]
  else
    p "Please enter {y} or {n}."
    continue
  end
end

def study_list
  make_list_option = gets.chomp
   if make_list_option == "y"

     p "What would you like to name your study list?"
     study_list_name = gets.chomp
     file = File.open("#{study_list_name}.txt", "a+")
     $incorrect_array.each {|incorrect_element| file << "#{incorrect_element} \n"}
     continue

   elsif make_list_option == "n"

     continue

   else

     p "I'm sorry, please enter {y} for yes or {n} for no."
     study_list

   end
 end

def round

  $incorrect_array = []
  t1 = Time.now
  $amt_correct = 0
  $amt_incorrect = 0


  while true

    verb_form_chooser = rand($verb_form)
    row_specifier = (rand(1..216))
    # if $vocab_chooser_option == 'y' || $vocab_chooser_option == 'yes'
    #   verb_row = $arr_of_arrs[$value_array.sample]
    # elsif $vocab_chooser_option == 'n' || $vocab_chooser_option == 'no'
    #   verb_row = $arr_of_arrs[row_specifier]
    # end
    verb_row = $arr_of_arrs[row_specifier]
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
#form
end
#end
