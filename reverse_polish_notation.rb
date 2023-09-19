def reverse_polish_notation(args)
    result = []
    stack = []

    for arg in args
        if arg.to_i != 0
            result.push(arg)
        elsif is_operation(arg)
            stack.push(arg)
        else 
            return "Wrong parameter in function"
        end
    end

    for item in stack.reverse()
        result.push(item)
    end

    return result
end

def is_operation(element)
    if(element == '+' || element == '-' || element == 'x' || element == '/')
        return true
    
    return false
    end
end


if ARGV.length != 0
    puts reverse_polish_notation(ARGV)
else
    puts "Function have no arguments!"
end