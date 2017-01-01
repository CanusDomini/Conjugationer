require "CSV"

    $arr_of_arrs = CSV.read('GermanVerbs.csv')

    def time_length

      while true

        p "How many seconds do you want your round to be?"

        length_option = gets.chomp

        if (/\A\d+\z/ =~ length_option)

          $round_length = length_option.to_i
          round

        else

          p "Please enter a number."
          time_length

        end
      end
    end


def mood
  p "What mood would you like to play with: indicative/subjunctive/conditional?"
  mood_option = gets.chomp
  if mood_option == 'indicative' || mood_option == 'i'
    indicative_tenses
  elsif mood_option == 'subjunctive' || mood_option == 's'
    subjunctive_tenses
  elsif mood_option == 'conditional' || mood_option == 'c'
    conditional_tenses
  else
    p "Please enter an option from the list."
    mood
  end
end

def indicative_tenses
  p "What tense would you like to play with: present/perfect/past/pluperfect/future 1/future 2?"

  $tense_option = gets.chomp
  if $tense_option  == "present" || $tense_option  == "p"
    $verb_form = (6..11)
  elsif $tense_option  == "perfect" || $tense_option  == 'pf'
    $verb_form = (13..18)
  elsif $tense_option  == "past" || $tense_option  == 'pa'
    $verb_form = (20..25)
  elsif $tense_option  == "pluperfect" || $tense_option == "pp"
    $verb_form = (27..32)
  elsif $tense_option  == "future 1" || $tense_option  == 'f1'
    $verb_form = (34..39)
  elsif $tense_option  == "future 2" || $tense_option  == 'f2'
    $verb_form = (41..46)
  else
    p "Please enter a form from the list."
    indicative_tenses
  end
  time_length
end

def subjunctive_tenses

  p "What tense would you like to play with: present/perfect/past/pluperfect"

  $tense_option = gets.chomp
  if $tense_option  == "present" || $tense_option  == "p"
    $verb_form = (48..53)
  elsif $tense_option  == "perfect" || $tense_option  == 'pf'
    $verb_form = (55..60)
  elsif $tense_option  == "past" || $tense_option  == 'pa'
    $verb_form = (62..67)
  elsif $tense_option  == "pluperfect" || $tense_option == "pp"
    $verb_form = (69..74)
  else
    p "Please enter a form from the list."
    subjunctive_tenses
  end
  time_length
end

def conditional_tenses

  p "What tense would you like to play with: present/perfect"

  $tense_option = gets.chomp
  if $tense_option  == "present" || $tense_option  == "p"
    $verb_form = (76..81)
  elsif $tense_option  == "perfect" || $tense_option  == 'pf'
    $verb_form = (83..88)
  else
    p "Please enter a form from the list."
    conditional_tenses
  end
  time_length
end


def continue
  p "Would you like to continue?"
  p "y/n?"
  continue_option = gets.chomp
  if continue_option == 'y'
    mood
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
    p $verb_form
    p verb_form_chooser = rand($verb_form)
    row_specifier = (rand(1..431))
    verb_row = $arr_of_arrs[row_specifier]
    infinitive = verb_row[1]
    correct_answer = verb_row[verb_form_chooser]
    form_question = $arr_of_arrs[0][verb_form_chooser]
    mood = verb_row[3]
    meaning = verb_row[0]

    p "#{infinitive}"
    p "(#{meaning})"
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
mood
