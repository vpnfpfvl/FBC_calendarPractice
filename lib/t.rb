a = ["-mk", "-m", "333"]
opt = "-m"
p "-mk" == "-mk"
p "-mk" === "#{opt}k"
p "mk" === /[a-z]+/
p /[a-z]+/ === "ad"
p /#{opt}[a-z]+$/ === "-mk" ## これでOK
p /\w+$/ === "mk"
# p "-mk" === "/-m\w+$/"
# p "-mk" == "#{opt}/k/"
# p "-mk" == "/-m\w+/"
# p a.include?("#{opt}-m\w+$")
# p argv.each =~ ("#{opt}/\w+$/") ##正規表現のものが要素にあるか探す