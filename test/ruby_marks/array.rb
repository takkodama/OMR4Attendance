result = {:first=>{1=>["2"]}, :second=>{1=>["0"]}, :third=>{1=>["1"]},
 :forth=>{1=>["4"]},:fifth=>{1=>["2"]}, :sixth=>{1=>["0"]},
 :seventh=>{1=>["6"]}, :eighth=>{1=>["4"]},:nineth=>{1=>["2"]}}

gakuseki = ""

result.each do |k, v|
	num = v[1][0]
	puts num
	gakuseki = gakuseki + num
end

p gakuseki

#p result[:first]

