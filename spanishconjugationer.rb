require "CSV"
require_relative 'conjugationermodule'

    $arr_of_arrs = CSV.read('spanish_verb_database_fixed.csv')

    def vocab_chooser

      p "Would you like to choose specific words to play with?"
      $vocab_chooser_option = gets.chomp

      if $vocab_chooser_option == 'y' || $vocab_chooser_option == 'yes'

      incrementer = -17

      $verb_array_row_hash = {} #this hash has the infinitive as the key and the row number as the value
      while incrementer < 11430

        incrementer += 18
        p verb_infinitive = $arr_of_arrs[incrementer][0]

        $verb_array_row_hash[verb_infinitive] = incrementer - 1

      end

      $verb_array_row_hash
      p "What words would you like to play with?"
      p "Bear in mind, your selection is limited to the few hundred verbs in our database."

      $key_array = []
      build_array = true
      while build_array

        verb_select = gets.chomp.downcase
        if verb_select == 'done' || verb_select == 'DONE'
          value_builder
        end
        if $verb_array_row_hash.key?("#{verb_select}") == false
          p "Please only copy and paste words from the list."
        else
        $key_array << verb_select
        end

        p $key_array
      end
      elsif $vocab_chooser_option == 'n' || $vocab_chooser_option == 'no'
        round
      end
    #  end
    end



def tense_indicative

    p "What tense do you want to play with?"

    p "present, future, imperfect, preterite, conditional,  present_perfect, future_perfect,  past_perfect, conditional_perfect, preterite_archaic"

    $tense_choice = gets.chomp.to_sym
# WHY DOES THE END OF THE STRING BECOME VARIABLES?
        if ($tense_choice != :present) & ($tense_choice != :future) & ($tense_choice != :imperfect) & ($tense_choice != :preterite) & ($tense_choice != :conditional) & ($tense_choice != :present_perfect) & ($tense_choice != :future_perfect) & ($tense_choice != :past_perfect) & ($tense_choice != :conditional_perfect) & ($tense_choice != :preterite_archaic)


          p "Please enter a tense from the list."
          tense_indicative

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
time_length
end

def tense_subjunctive

    p "What tense do you want to play with?"

    p "present, future, imperfect, present_perfect, future_perfect, past_perfect"

    $tense_choice = gets.chomp.to_sym

        if ($tense_choice != :present) & ($tense_choice != :future) & ($tense_choice != :imperfect) & ($tense_choice != :present_perfect) & ($tense_choice != :future_perfect) & ($tense_choice != :past_perfect)


          p "Please enter a tense from the list."
          tense_subjunctive

        end
                time_length
end

def form_options

  while true

    p "What mood do you want to play with: indicative/subjunctive?"

    $mood_player_choice = gets.chomp

    if $mood_player_choice == "indicative" || $mood_player_choice == "i"

        $mood = { present: 1, future: 2, imperfect: 3, preterite: 4, conditional: 5,  present_perfect: 6, future_perfect: 7,  past_perfect: 8, preterite_archaic: 9, conditional_perfect: 10}

        tense_indicative

    elsif $mood_player_choice == "subjunctive" || $mood_player_choice == "s"

        $mood = { present: 11, future: 12, imperfect: 13, present_perfect: 14, future_perfect: 15, past_perfect: 16}

        tense_subjunctive

      else

        p "Sorry, please type in either {indicative} or simply {i} for the indicative mood or {subjunctive} or simply {s} for the subjunctive."


      end
    end
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
      verb_row = $arr_of_arrs[$mood[$tense_choice] + row_specifier]
    end
    # verb_row = $arr_of_arrs[$mood[$tense_choice] + row_specifier]
    infinitive_verb = verb_row[0]
    random_form_chooser = rand(7..12)
    correct_answer = verb_row[random_form_chooser]
    form_question = $arr_of_arrs[0][random_form_chooser]
    mood = verb_row[3]
    meaning = verb_row[1]
    question = "#{infinitive_verb} #{form_question}"
    #question = "What is the #{form_question} #{tense_choice} of #{infinitive_verb} in the #{mood} mood?"
    correct_answer = verb_row[random_form_chooser]

    p "#{infinitive_verb} (#{meaning})"
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
