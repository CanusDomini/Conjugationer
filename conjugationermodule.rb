#class Conjugationer
#require_relative 'JapaneseConjugationerN1'
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
