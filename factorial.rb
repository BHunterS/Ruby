def factorial(n)
    if n == 0
        return 1
    else
        return n * factorial(n - 1)
    end
end

print "Input number: "
num = gets.chomp.to_i

if num < 0
    puts "Incorrect value"
else
    result = factorial(num)
    puts "Factorial #{num} equal #{result}."
end
