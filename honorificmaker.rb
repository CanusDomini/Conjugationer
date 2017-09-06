require 'csv'


csv = CSV.open('jlptverbs100.csv', 'a+')
$arr_of_arrs = CSV.read('jlptverbs100.csv')

list_of_verb_arrs = $arr_of_arrs
# dict_form_arr = []
# list_of_verb_arrs.each do |row|
#   dict_form = row[15]
#   dict_form_arr << dict_form
# end
# p dict_form_arr
# dict_form_arr.each do |dictform|
#   conjectural_casual_arr = []
#   conjectural_casual_form = dictform + "なら"
#   conjectural_casual_arr << conjectural_casual_form
#   csv << conjectural_casual_arr
#  end
i_form_arr = []
list_of_verb_arrs.each do |row|
  i_form = row[15]
  i_form_arr << i_form
end
 i_form_arr
#
#
 i_form_arr[1..505].each do |iform|
  keigo_form_arr = []
p  sonkeigo_form_polite = "お" + iform + "になります"
p  sonkeigo_form_casual = "お" + iform + "になる"
p  kenjougo_form_polite = "お" + iform + "します"
p  kenjougo_form_casual = "お" + iform + "する"
  keigo_form_arr << sonkeigo_form_casual
  keigo_form_arr << sonkeigo_form_polite
  keigo_form_arr << kenjougo_form_casual
  keigo_form_arr << kenjougo_form_polite
  p keigo_form_arr
  p csv << keigo_form_arr
end
