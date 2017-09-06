require "CSV"
require_relative 'conjugationermodule'

    $arr_of_arrs = CSV.read('italianverbs2.csv')

    def vocab_chooser

      p "Would you like to choose specific words to play with?"
      $vocab_chooser_option = gets.chomp

      if $vocab_chooser_option == 'y' || $vocab_chooser_option == 'yes'

      incrementer = -14

      $verb_array_row_hash = {} #this hash has the infinitive as the key and the row number as the value
      while incrementer < 3075

        incrementer += 15
        p verb_infinitive = $arr_of_arrs[incrementer][0]

        $verb_array_row_hash[verb_infinitive] = incrementer - 1

      end

      $verb_array_row_hash
      p "What words would you like to play with?"
      p "Bear in mind, your selection is limited to the few hundred verbs in our database."

      $key_array = []
      build_array = true
      while build_array

        verb_select = gets.chomp.upcase

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

def tense_indicativo

    p "What tense do you want to play with?"
    p "presente, imperfetto, passato_remoto, futuro_semplice, passato_prossimo,  trapassato_prossimo, trapassato_remoto,  futuro_anteriore"
    $tense_choice = gets.chomp.to_sym

    if ($tense_choice != :presente) & ($tense_choice != :imperfetto) & ($tense_choice != :passato_remoto) & ($tense_choice != :futuro_semplice) & ($tense_choice != :passato_prossimo) & ($tense_choice != :trapassato_prossimo) & ($tense_choice != :trapassato_remoto) & ($tense_choice != :futuro_anteriore)


      p "Please enter a tense from the list."
      tense_indicativo

    end

  time_length

end

def tense_congiuntivo

    p "What tense do you want to play with?"

    p "presente, imperfetto, passato, trapassato"

    $tense_choice = gets.chomp.to_sym

        if ($tense_choice != :presente) & ($tense_choice != :imperfetto) & ($tense_choice != :passato) & ($tense_choice != :trapassato)


          p "Please enter a tense from the list."
          tense_congiuntivo

        end
                time_length
end

def tense_condizionale

    p "What tense do you want to play with?"

    p "presente, passato"

    $tense_choice = gets.chomp.to_sym

        if ($tense_choice != :presente) & ($tense_choice != :passato)


          p "Please enter a tense from the list."
          tense_condizionale

        end
                time_length
end

def tense_imperativo

    p "What tense do you want to play with?"

    p "presente"

    $tense_choice = gets.chomp.to_sym

        if ($tense_choice != :presente)


          p "Please enter a tense from the list."
          tense_imperativo

        end
                time_length
end

def form_options

  while true

    p "What mood do you want to play with: indicativo/congiuntivo/condizionale/imperativo?"

    $mood_player_choice = gets.chomp

    if $mood_player_choice == "indicativo" || $mood_player_choice == "i"

        $mood = { presente: 1, imperfetto: 2, passato_remoto: 3, futuro_semplice: 4, passato_prossimo: 5,  trapassato_prossimo: 6, trapassato_remoto: 7,  futuro_anteriore: 8}

        tense_indicativo

    elsif $mood_player_choice == "congiuntivo" || $mood_player_choice == "cg"

        $mood = { presente: 9, imperfetto: 10, passato: 11, trapassato: 12}

        tense_congiuntivo

    elsif $mood_player_choice == "condizionale" || $mood_player_choice == "cd"

        $mood = { presente: 13, passato: 14}

        tense_condizionale

    elsif $mood_player_choice == "imperativo" || $mood_player_choice == "i"

        $mood = { presente: 15}

        tense_imperativo

      else

        p "Sorry, please type in either {indicativo} or simply {i}, {congiuntivo} or simply {cg}, {condizionale} or simply {cd}, or {imperativo} or {i}."


      end
    end
end

def round

  $incorrect_array = []
  t1 = Time.now
  $amt_correct = 0
  $amt_incorrect = 0


  while true


    row_specifier = (15 * rand(0..206))
    if $vocab_chooser_option == 'y' || $vocab_chooser_option == 'yes'
      verb_row = $arr_of_arrs[$mood[$tense_choice] + $value_array.sample]
    elsif $vocab_chooser_option == 'n' || $vocab_chooser_option == 'no'
      verb_row = $arr_of_arrs[$mood[$tense_choice] + row_specifier]
    end
    # verb_row = $arr_of_arrs[$mood[$tense_choice] + row_specifier]
    infinitive_verb = verb_row[0]
    random_form_chooser = rand(4..9)
    form_question = $arr_of_arrs[0][random_form_chooser]
    mood = verb_row[3]
    meaning = verb_row[1]
    question = "#{infinitive_verb} #{form_question}"
    #question = "What is the #{form_question} #{tense_choice} of #{infinitive_verb} in the #{mood} mood?"
    correct_answer = verb_row[random_form_chooser].lstrip!

    p "#{infinitive_verb} #{meaning}"
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
