# CMSC 330 / Fall 2013 / Project 1
# Student: Emmanuel Taylor

# Fill in the implementation and submit just this file

# The validate method will return yes or no depending on whether or not a log
# file is valid or not.
def validate(filename)

  # Regular expression for IP addresses ranging up to 255. Then formatting it
  # with three periods.
  ip = '([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])'
  full_ip = ip + '\.' + ip + '\.' + ip + '\.' + ip

  # Regular expression for the first hyphen followed by the specified username
  # or another hyphen if no username is specified.
  hyp = '\s\-\s'
  uname = '(\-|(\w+))(\s)'

  # Regular expressions for the days, months, and years.
  days = '(3[0-1]|2[0-9]|1[0-9]|0[1-9])'
  months = '(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)'
  years = '([0-9]{4})'

  # Regular expressions for the hours, minutes, seconds, and the time zone.
  hours = '(2[0-3]|[0-1][0-9])'
  minutes = '([0-5][0-9])'
  seconds = '([0-5][0-9])'
  zone = '\-0400'

  # A formatted expression concatenating day, month, year, the times, and the 
  # zone together.
  date = '\[' + days + '\/' + months + '\/' + years + '\:' + hours + '\:' + minutes + '\:' + seconds + '\s' + zone + '\]\s'

  # Regular expressions for the request arbitrary string, status code, and the
  # number of bytes sent through the request.
  requests = '\"(\\\"|[^"])+(\\\"|[^"\\\])\"\s'
  status = '(([0-9]+)\s)'
  bytes = '(\-|([0-9]+))'

  # The final concatenated regular expression that each line in the file will
  # be compared to.
  valid_line = Regexp.new('^' + full_ip + hyp + uname + date + requests + status + bytes + '$')

  # Opening the file name, and checking each line against the valid line
  # regular expression. If the lines do not match or the line is not a newline
  # character, return no. Otherwise return yes.
  file = File.new(filename, "r")
  lines = file.readlines
  lines.each{ |line|
    if line !~ valid_line and line != ""
      then return "no"
    end
  }
  return "yes"
end

# This method will return the number of bytes sent by each request in bytes,
# kilobytes, megabytes, or gigabytes.
def bytes(filename)
  byte_total = 0
  num_bytes = 0

  # Opening the file and reading all of the lines.
  file = File.new(filename, "r")
  lines = file.readlines

  # Splits each line of bytes by gigabyte at the space.
  lines.each{ |line|
    if line != "\n" then
      splits = line.split(" ")
      byte_size = splits[9].to_i
      if byte_size != '-' then
        byte_total += byte_size
      end
    end
  }

  # Divides the total number of bytes by kilo to increase count.
  while byte_total > 1024
    byte_total /= 1024
    num_bytes += 1
  end

  # Prints the number of bytes in the appropriate unit.
  if num_bytes == 0 then
    return byte_total.to_s + " bytes"
  elsif num_bytes == 1 then
    return byte_total.to_s + " KB"
  elsif num_bytes == 2 then
    return byte_total.to_s + " MB"
  else
    return byte_total.to_s + " GB"
  end
end

# Produces a histogram indicating the total number of request served for each
# hour of the day.
def time(filename)
  file = File.new(filename, "r")
  lines = file.readlines
  hasher = Hash.new
  
  # Goes through each line and checks it against the newline character. The
  # lines will be split at the semicolons. We'll use our has to check hours
  # against nil and increment by 1 if they are not equal.
  lines.each { |line|
    if line != "\n" then
      splits = line.split(" ")
      date = splits[3].split(":")
      hours = date[1].to_i
      if hasher[hours] == nil then
        hasher[hours] = 1
      else
        hasher[hours] += 1
      end
   end
  }
   index = 0

  # While the index is less than or equal to 23, check against nil and print
  # the position of the index.
   while index <= 23
     if hasher[index] == nil then
       if index <= 9 then
         puts "0#{index} 0\n"
       else
         puts "#{index} 0\n"
       end
    else
       if index <= 9 then
         puts "0#{index} #{hasher[index]}\n"
       else
         puts "#{index} #{hasher[index]}\n"
       end
    end
    index += 1
  end
end 

# This method will produce a list containing the top-ten most common request
# strings recieved by the web server.
def popularity(filename)
  file = File.new(filename, "r")
  lines = file.readlines
  hasher = Hash.new

  # Compares each line to nil and the newline character. Splits each line at
  # a space and hashes the requests.
  lines.each{ |line|
    if line != "\n" and line != nil then
      splits = line.split(" ")
      requests = splits[5] + " " + splits[6] + " " + splits[7]
      if hasher[requests] == nil
        hasher[requests] = 1
      else
        hasher[requests] += 1
      end
    end
  }

  index = 0

  # While index is less than or equal to 9, check each hash key and set the max
  # equal to that key if it is larger. 
  while index <= 9
    if hasher.empty? == true then
       break
    else
       maximum_value = 0
       maximum_key = ""
       hasher.keys.each{ |key|
       if hasher[key] > maximum_value then
         maximum_value = hasher[key]
         maximum_key = key
       end
      }
      puts "#{maximum_value} #{maximum_key}\n"
      hasher.delete(maximum_key)
      end
      index += 1
   end
end 

# This method will calculate the number of requests recieved by the web server
# for each IP Address and the number of transferred bytes to that IP Address.
def requests(filename)
  hasher = Hash.new
  second_hasher = Hash.new

  file = File.new(filename, "r")
  lines = file.readlines
  
  lines.each{ |line|
  # Use scan to get entire line for backreferences
  entire_line = line.scan(/^([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)\s\-\s.+\[[0-9]+\/\w+\/[0-9]+\:[0-9]+\:[0-9]+\:[0-9]+\s.+\s\".+\"\s[0-9]+\s(.+)$/)
  if hasher[$1] == nil
    hasher[$1] = 1
  else 
    hasher[$1] += 1
  end
    
  if second_hasher[$1] == nil
    second_hasher[$1] = $2.to_i
  else
    second_hasher[$1] += $2.to_i
  end
  }
  
  index = 0
  array = Array.new()

  # Incrementing the index
  hasher.keys.each{ |key| 
    array[index] = key
    index += 1
  }

  # Sorting Algorithm
  array = array.sort_by!{ |ip_value|
    ip_value.to_s.split(".").map{ |octet| 
      octet.to_i
    }
  }

  # Printing out the sorted array with number of requests.
  array.each { |value|
    puts("#{value} #{hasher[value]} #{second_hasher[value]}")
  }
end

# Handling whether supported or unsupported operations are entered.
if ARGV[0] != nil and ARGV[1] != nil then
  if ARGV[0] == "validate" then
    puts "#{validate(ARGV[1])}\n"
  elsif ARGV[0] == "bytes" then
    puts "#{bytes(ARGV[1])}\n"
  elsif ARGV[0] == "time" then
    puts "#{time(ARGV[1])}\n"
  elsif ARGV[0] == "popularity" then
    puts "#{popularity(ARGV[1])}\n"
  elsif ARGV[0] == "requests" then
    puts "#{requests(ARGV[1])}\n"
  else
    puts "Unsupported command. Try again.\n"
  end
end
