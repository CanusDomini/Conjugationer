#class Conjugationer
#require_relative 'JapaneseConjugationerN1'
def level_and_language
  p "What language do you want to play with: Japanese/German/Spanish/Italian?"
  language_option = gets.chomp.upcase

  if language_option == "JAPANESE" || language_option == "J"
    $incrementer = 0
    $language_specific_increment = 1
    p "Would you like to play with N2 or N4"
    level_option = gets.chomp.upcase
    if level_option == "N2"
      $arr_of_arrs = CSV.read('jlptverbs100.csv')
      $upper_limit = 505
    elsif level_option == "N4"
      $arr_of_arrs = CSV.read('jlptverbs5.csv')
      $upper_limit = 190
    else
      p "Please enter N2 or N4."
      level_and_language
    end
  elsif language_option == "GERMAN" || language_option == "G"
    $arr_of_arrs = CSV.read('GermanVerbs.csv')
    $incrementer = 0
    $upper_limit = 431
    $language_specific_increment = 1
  elsif language_option == "SPANISH" || language_option == "S"
    $arr_of_arrs = CSV.read('spanish_verb_database_fixed.csv')
    $incrementer = -17
    $upper_limit = 11430
    $language_specific_increment = 18
  elsif language_option == "ITALIAN" || language_option == "I"
    $arr_of_arrs = CSV.read('italianverbs2.csv')
    $incrementer = -14
    $upper_limit = 3075
    $language_specific_increment = 15
  else
    p "Please enter one of the aforementioned languages."
    level_and_language
  end
  vocab_chooser
end

def vocab_chooser

  p "Would you like to choose specific words to play with?"
  $vocab_chooser_option = gets.chomp

  if $vocab_chooser_option == 'y' || $vocab_chooser_option == 'yes'

  $verb_array_row_hash = {} #this hash has the infinitive as the key and the row number as the value
  while $incrementer < $upper_limit

    $incrementer += $language_specific_increment
    p verb_infinitive = $arr_of_arrs[$incrementer][1]

    $verb_array_row_hash[verb_infinitive] = $incrementer

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

def continue
  p "Would you like to continue?"
  p "y/n?"
  continue_option = gets.chomp
  if continue_option == 'y'
    form_options
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

 def timer_beginning
   $incorrect_array = []
   $t1 = Time.now
   $amt_correct = 0
   $amt_incorrect = 0
 end

def timer_ending
 $t2 = Time.now
 $delta = t1 - t2
 $delta_i = delta.to_i
end

def round_ending
  if $delta_i <= -$round_length
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
    continue
  end
end
end
