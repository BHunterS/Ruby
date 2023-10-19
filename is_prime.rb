def is_prime(num)
    return false if (num < 2)

    (2..(num - 1)).each do |n|
        return false if num % n == 0
    end

    return true
end

print "Input number: "
num = gets.chomp.to_i

if is_prime(num)
    puts "#{num} is prime."
else
    puts "#{num} isn't prime."
end