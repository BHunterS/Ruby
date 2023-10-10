ROM_NUMS = {
    'M' => 1000,
    'CM' => 900,
    'D' => 500,
    'CD' => 400,
    'C' => 100,
    'XC' => 90,
    'L' => 50,
    'XL' => 40,
    'X' => 10,
    'IX' => 9,
    'V' => 5,
    'IV' => 4,
    'I' => 1
}

def roman_to_int(s)
    res = 0
    temp = 0
    s.chars.each_with_index do |el, i|
        if ROM_NUMS[s[i + 1]] && ROM_NUMS[el] < ROM_NUMS[s[i+1]]
            temp = ROM_NUMS[el]
        else
            res += (ROM_NUMS[el] - temp)
            temp = 0
        end
    end
    res
end

def int_to_roman(num)
    result = ''
    
    ROM_NUMS.each do |k, v|
        next if num/v == 0
        
        result += k.to_s * (num/v)
        num %= v
        return result if num == 0 
    end
    
    result
end

puts(int_to_roman(1990))
puts(int_to_roman(2008))
puts(int_to_roman(938))

puts(roman_to_int("MCMXC"))
puts(roman_to_int("MMVIII"))
puts(roman_to_int(int_to_roman(938)))
