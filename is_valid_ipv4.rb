def is_valid_ipv4?(str)
    parts = str.split('.')
    
    return false unless parts.length == 4
    
    parts.each do |part|
        return false unless part.match?(/\A\d+\z/)
        
        num = part.to_i
        return false unless num >= 0 && num <= 255
        
        return false if part.start_with?('0') && part != '0'
    end

    return true
end

ip_address = "192.168.1.1"
if is_valid_ipv4?(ip_address)
    puts "#{ip_address} is valid"
else
    puts "#{ip_address} isn't valid"
end