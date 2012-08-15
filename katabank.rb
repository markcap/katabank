class Marcel

  def print_number

    file = File.open("data.txt")
    if file
      lines = IO.readlines("data.txt")
      line_index = 0
      
      #iterate through number of entries
      (lines.count / 4).times do
        final_code_string = ""
        column_index = 0
      
        #iterate through each ascii number
        (lines[line_index].size / 3).times do
          number_decode_string = ""
          
          #iterate through each line
          3.times do |index|
            number_decode_string += lines[index + line_index][column_index..(column_index+2)] 
          end
          
          #move column index to next digit and get the combined ascii string for current digit
          column_index +=3
          final_code_string += get_number(number_decode_string)
        end
    
        #checking to see if number is illegible or invalid
        if final_code_string.include?("?")
          puts final_code_string + " ILL"
        elsif !account_checksum(final_code_string)
          puts final_code_string + " ERR"
        else
          puts final_code_string
        end
        
        #move on to next entry
        line_index += 4
      end
    end
  end
  
  def get_number(string)
    
    #this converts ascii digits into normal numbers
    case
    when string == "     |  |"
      '1'
    when string == " _  _||_ "
      '2'
    when string == " _  _| _|"
      '3'
    when string == "   |_|  |"
      '4'
    when string == " _ |_  _|"
      '5'
    when string == " _ |_ |_|"
      '6'
    when string == " _   |  |"
      '7'
    when string == " _ |_||_|"
      '8'
    when string == " _ |_| _|"
      '9'
    when string == " _ | ||_|"
      '0'
    else 
      '?'
    end
    
  end
  
  def account_checksum(account_number)
    # account number:  3  4  5  8  8  2  8  6  5
    # position names:  d9 d8 d7 d6 d5 d4 d3 d2 d1
    # 
    # checksum calculation:
    # (d1+2*d2+3*d3 +..+9*d9) mod 11 = 0
    
    multiplier = 2
    account_total = 0
    
    account_number.reverse.each_char do |number|
      account_total += (number.to_i * multiplier)
      multiplier += 1
    end
    
    (account_total % 11) == 0
 
  end
  
end

whatever = Marcel.new
whatever.print_number