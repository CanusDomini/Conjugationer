require 'csv'


csv = CSV.open('jlptverbs5.csv', 'a+')
$arr_of_arrs = CSV.read('jlptverbs5.csv')

list_of_verb_arrs = $arr_of_arrs[1..215]
dict_form_arr = []
list_of_verb_arrs.each do |row|
  dict_form = row[2]
  dict_form_arr << dict_form
end
dict_form_arr.each do |dictform|
  conjectural_casual_arr = []
  conjectural_casual_form = dictform + "なら"
  conjectural_casual_arr << conjectural_casual_form
  csv << conjectural_casual_arr
 end
# i_form_arr = []
# list_of_verb_arrs.each do |row|
#   i_form = row[15]
#   i_form_arr << i_form
# end
#
#
# i_form_arr.each do |iform|
#   keigo_form_arr = []
#   sonkeigo_form_polite = "お" + iform + "になります"
#   sonkeigo_form_casual = "お" + iform + "になる"
#   kenjougo_form_polite = "お" + iform + "します"
#   kenjougo_form_casual = "お" + iform + "する"
#   keigo_form_arr << sonkeigo_form_casual
#   keigo_form_arr << sonkeigo_form_polite
#   keigo_form_arr << kenjougo_form_casual
#   keigo_form_arr << kenjougo_form_polite
#   p keigo_form_arr
#   csv << keigo_form_arr
# end
