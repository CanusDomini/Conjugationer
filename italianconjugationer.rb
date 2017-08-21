require "CSV"

    $arr_of_arrs = CSV.read('italianverbs2.csv')

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

def mood_options

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


def continue
  p "Would you like to continue?"
  p "y/n?"
  continue_option = gets.chomp
  if continue_option == 'y'
    mood_options
  elsif continue_option == 'n'
    exit(0)
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


    row_specifier = (15 * rand(0..174))
    verb_row = $arr_of_arrs[$mood[$tense_choice] + row_specifier]
    infinitive_verb = verb_row[0]
    random_form_chooser = rand(4..9)
    correct_answer = verb_row[random_form_chooser]
    form_question = $arr_of_arrs[0][random_form_chooser]
    mood = verb_row[3]
    meaning = verb_row[1]
    question = "#{infinitive_verb} #{form_question}"
    #question = "What is the #{form_question} #{tense_choice} of #{infinitive_verb} in the #{mood} mood?"
    correct_answer = verb_row[random_form_chooser]

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
     delta_i = delta.to_i


     if delta_i <= -$round_length
       $incorrect_string = $incorrect_array.to_s.gsub(Regexp.union('"', '[', ']', "~,"), '')
       decimal_correct = ($amt_correct / ($amt_correct + $amt_incorrect.to_f))
       percentage_correct = (decimal_correct.round(2) * 100).to_i
       p "Good job you got #{$amt_correct} correct and #{$amt_incorrect} incorrect!"
       p "That's a #{percentage_correct}%!!"
       p "Here are the answers that you missed: #{$incorrect_string}."
       p "Would you like to export them into a .txt file in order to keep a study list?"
       study_list

     end
end
end
mood_options
