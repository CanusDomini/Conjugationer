require "CSV"

    $arr_of_arrs = CSV.read('./jehle_verb_database.csv')

    def time_length

      while true

        p "How many seconds do you want your round to be?"

        length_option = gets.chomp

        if (/\A\d+\z/ =~ length_option)

          $round_length = length_option.to_i
          round

        else

          p "Please enter a number."

        end
      end
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

def mood_options

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

# def time_length
#
#   while true
#
#     p "How many seconds do you want your rounds to be?"
#
#     $round_length = gets.chomp.to_i
#
#     if $round_length.is_a? Integer
#
#       round
#
#     else
#
#       p "Please enter a number."
#
#     end
# end


def round

  t1 = Time.now
  $amt_correct = 0
  $amt_incorrect = 0


  while true


    row_specifier = (18 * rand(0..635))
    verb_row = $arr_of_arrs[$mood[$tense_choice] + row_specifier]
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
     delta_i = delta.to_i


     if delta_i <= -$round_length
       decimal_correct = ($amt_correct / ($amt_correct + $amt_incorrect.to_f))
       percentage_correct = (decimal_correct.round(2) * 100).to_i
       p "Good job you got #{$amt_correct} correct and #{$amt_incorrect} incorrect!"
       p "That's a #{percentage_correct}%!!"
       exit(0)
     end
end
end

mood_options
