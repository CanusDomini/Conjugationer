require "CSV"

    $arr_of_arrs = CSV.read('jlptverbs5.csv')

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
    $verb_form = (8..11)
  elsif $form_option  == "te form" || $form_option  == 'tf'
    $verb_form = (12..15)
  elsif $form_option  == "i form"
    $verb_form = (16)
  elsif $form_option  == "ifs"
    $verb_form = (17..28)
  elsif $form_option  == "potential" || $form_option  == 'po'
    $verb_form = (29..32)
  elsif $form_option  == "passive" || $form_option  == 'pa'
    $verb_form = (33..36)
  elsif $form_option  == "causative" || $form_option  == 'c'
    $verb_form = (37..44)
  elsif $form_option  == "causative passive" || $form_option  == 'cp'
    $verb_form = (45..52)
  elsif $form_option  == "volitional" || $form_option  == 'v'
    $verb_form = (53..56)
  elsif $form_option  == "conjectural" || $form_option  == 'co'
    $verb_form = (57..60)
  elsif $form_option  == "alternative" || $form_option  == 'a'
    $verb_form = (61..64)
  elsif $form_option  == "imperative" || $form_option  == 'i'
    $verb_form = (65..67)
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
    p verb_form_chooser
    p $verb_form
    row_specifier = (rand(1..161))
    verb_row = $arr_of_arrs[row_specifier]
    hiragana_verb = verb_row[1]
    kanji_verb = verb_row[2]
    correct_answer = verb_row[verb_form_chooser]
    form_question = $arr_of_arrs[0][verb_form_chooser]
    mood = verb_row[3]
    meaning = verb_row[0]
    question = "#{kanji_verb} #{hiragana_verb} #{form_question}"
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
       p "Here are the answers that you missed: #{$incorrect_string}."
       p "Would you like to export them into a .txt file in order to keep a study list?"
       study_list

     end
end
end
form
