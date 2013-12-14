##########################################################################
### CMSC330 Project 5: Multi-threaded Space Simulation                 ###
### Source code: space.rb                                              ###
### Description: Multi-threaded Ruby program simulating space travel   ###
### Student Name: Emmanuel Taylor                                      ###
##########################################################################

require "monitor"

Thread.abort_on_exception = true   # to avoid hiding errors in threads 

#------------------------------------
# Global Variables
        
$headerPorts = "=== Starports ==="
$headerShips = "=== Starships ==="
$headerTraveler = "=== Travelers ==="
$headerOutput = "=== Output ==="

$simOut = []            # simulation output

$starport = []
$starship = []
$traveler = []
$printMonitor = Monitor.new()

#----------------------------------------------------------------
# Starport 
#----------------------------------------------------------------

class Starport
    def initialize (name,size)
        @name = name
        @size = size
        @ships = []
        @travelers = []
		@starMonitor = Monitor.new()
		@departCondition = @starMonitor.new_cond()
		@dockCondition = @starMonitor.new_cond()
    end
    
	def ships
		@ships
	end
	
	def travelers
		@travelers
	end
	
	def shipCap
		ship = nil
		@ships.each{ |sh|
			if sh.passengers.length < sh.size
				ship = sh
				break
			end
		}
		
		ship
	end
	
    def to_s
        @name
    end
	
	def size
		@size
	end
	
	def arrive(person)
		@travelers.push(person)
	end
	
	def starMonitor
		@starMonitor
	end
	
	def departCondition
		@departCondition
	end
	
	def dockCondition
		@dockCondition
	end
end

#------------------------------------------------------------------
# find_name(name) - find port based on name

def find_name(arr, name)
    arr.each { |p| return p if (p.to_s == name) }
    puts "Error: find_name cannot find #{name}"
        $stdout.flush
end

#------------------------------------------------------------------
# next_port(c) - find port after current port, wrapping around

def next_port(current_port)
    port_idx = $starport.index(current_port)
    if !port_idx
        puts "Error: next_port missing #{current_port}"
        $stdout.flush
        return  $starport.first
    end
    port_idx += 1
    port_idx = 0 if (port_idx >= $starport.length)
    $starport[port_idx]
end

#----------------------------------------------------------------
# Starship 
#----------------------------------------------------------------

class Starship
    def initialize (name, size)
        @name = name
		@size = size
        @passengers = []
		@current_loc = nil
		@previous_port = nil
		@current_port = nil
		@destination = nil
    end
	
	def size
		@size
	end
	
	def passengers
		@passengers
	end
	
    def to_s
        @name
    end
	
	def current_port
		@current_port
	end
	
	def set_curr_port(new)
		@current_port = new
	end
	
	def previous_port
		@previous_port
	end
	
	def set_prev_port(new)
		@previous_port = new
	end
	
	def destination
		@destination
	end
	
	def set_destination(new)
		@destination = new
	end
end         


#----------------------------------------------------------------
# Traveler 
#----------------------------------------------------------------

class Traveler
    def initialize(name, itinerary)
        @name = name
        @itinerary = itinerary
		@itinerary_idx = 0
		@in_station = true
    end
	
	def itinerary_idx
		@itinerary_idx
	end
	
	def set_itin_idx(new_idx)
		@itinerary_idx = new_idx
	end
	
    def to_s
        @name
    end
	
	def itinerary
		@itinerary
	end
	
	def in_station
		@in_station
	end
	
	def set_in_station(new)
		@in_station = new
	end
end

#------------------------------------------------------------------
# read command line and decide on display(), verify() or simulate()

def readParams(fname)
    begin
        f = File.open(fname)
    rescue Exception => e
        puts e
        $stdout.flush
        exit(1)
    end

    section = nil
    f.each_line{|line|

        line.chomp!
        line.strip!
        if line == "" || line =~ /^%/
            # skip blank lines & lines beginning with %

        elsif line == $headerPorts || line == $headerShips ||
        line == $headerTraveler || line == $headerOutput
            section = line

        elsif section == $headerPorts
            parts = line.split(' ')
            name = parts[0]
            size = parts[1].to_i
            $starport.push(Starport.new(name,size))
                
        elsif section == $headerShips
            parts = line.split(' ')
            name = parts[0]
			size = parts[1].to_i
            $starship.push(Starship.new(name,size))

        elsif section == $headerTraveler
            parts = line.split(' ')
            name = parts.shift
            itinerary = []
            parts.each { |p| itinerary.push(find_name($starport,p)) }
            person = Traveler.new(name,itinerary)
            $traveler.push(person)
            find_name($starport,parts.first).arrive(person)

        elsif section == $headerOutput
            $simOut.push(line)

        else
            puts "ERROR: simFile format error at #{line}"
            $stdout.flush
            exit(1)
        end
    }
end

#------------------------------------------------------------------
# 

def printParams()
    
    puts $headerPorts
    $starport.each { |s| puts "#{s} #{s.size}" }
    
    puts $headerShips 
    $starship.each { |s| puts "#{s} #{s.size}" }
    
    puts $headerTraveler 
    $traveler.each { |p| print "#{p} "
                               p.itinerary.each { |s| print "#{s} " } 
                               puts }

    puts $headerOutput
    $stdout.flush
end

#----------------------------------------------------------------
# Simulation Display
#----------------------------------------------------------------

def array_to_s(arr)
    out = []
    arr.each { |p| out.push(p.to_s) }
    out.sort!
    str = ""
    out.each { |p| str = str << p << " " }
    str
end

def pad_s_to_n(s, n)
    str = "" << s
    (n - str.length).times { str = str << " " }
    str
end

def ship_to_s(ship)
    str = pad_s_to_n(ship.to_s,12) << " " << array_to_s(ship.passengers)
    str
end

def display_state()
    puts "----------------------------------------"
    $starport.each { |port|
        puts "#{pad_s_to_n(port.to_s,13)} #{array_to_s(port.travelers)}"
        out = []
        port.ships.each { |ship| out.push("  " + (ship_to_s(ship))) }
        out.sort.each { |line| puts line }
    }
    puts "----------------------------------------"
end


#------------------------------------------------------------------
# display - print state of space simulation

def display()
    display_state()
	
	$starship.each { |sh|
		sh.set_destination($starport[0])
	}
	
    $simOut.each {|o|
        puts o
        if o =~ /(\w+) (docking at|departing from) (\w+)/
            ship = find_name($starship,$1); 
            action = $2;
            port = find_name($starport,$3); 
            if (action == "docking at")
                port.ships.push(ship)
				ship.set_prev_port(ship.current_port)
				ship.set_curr_port(port)
				ship.set_destination(nil)
            else
                port.ships.delete(ship)
				ship.set_prev_port(ship.current_port)
				ship.set_curr_port(nil)
				ship.set_destination(next_port(port))
            end
                
        elsif o =~ /(\w+) (board|depart)ing (\w+) at (\w+)/
            person = find_name($traveler,$1); 
            action = $2;
            ship = find_name($starship,$3); 
            port = find_name($starport,$4); 
            if (action == "board")
                ship.passengers.push(person)
                port.travelers.delete(person)
				person.set_itin_idx(person.itinerary_idx + 1)
				person.set_in_station(false)
            else
                ship.passengers.delete(person)
                port.travelers.push(person)
				person.set_in_station(true)
            end
        else
            puts "% ERROR Illegal output #{o}"
        end
        display_state()
    }	  
end

#------------------------------------------------------------------
# verify - check legality of simulation output

def verify
    validSim = true
	
	$starship.each { |sh|
		sh.set_destination($starport[0])
	}
	
    $simOut.each {|o|
        if o =~ /(\w+) (docking at|departing from) (\w+)/
            ship = find_name($starship,$1); 
            action = $2;
            port = find_name($starport,$3); 
            if (action == "docking at")
				if port != ship.destination
					validSim = false
				elsif port.ships.length >= port.size
					validSim = false
				else
					port.ships.push(ship)
					ship.set_prev_port(ship.current_port)
					ship.set_curr_port(port)
					ship.set_destination(nil)
				end
            else
				if port.ships.index(ship).nil?
					validSim = false
				else
					port.ships.delete(ship)
					ship.set_prev_port(ship.current_port)
					ship.set_curr_port(nil)
					ship.set_destination(next_port(port))
				end
			end
                
        elsif o =~ /(\w+) (board|depart)ing (\w+) at (\w+)/
            person = find_name($traveler,$1); 
            action = $2;
            ship = find_name($starship,$3); 
            port = find_name($starport,$4); 
			
            if (action == "board")
				if port.ships.index(ship).nil?
					validSim = false
				elsif ship.passengers.length >= ship.size
					validSim = false
				elsif !person.in_station
					validSim = false
				else
					ship.passengers.push(person)
					port.travelers.delete(person)
					person.set_itin_idx(person.itinerary_idx + 1)
					person.set_in_station(false)
				end
			else
				if port.ships.index(ship).nil?
					validSim = false
				elsif port != person.itinerary[person.itinerary_idx]
					validSim = false
				elsif (person.itinerary_idx > 1 && (person.itinerary[person.itinerary_idx] == person.itinerary[person.itinerary_idx - 1]))
					validSim = false
				elsif ship.passengers.index(person).nil?
					validSim = false
				else
					ship.passengers.delete(person)
					port.travelers.push(person)
					person.set_in_station(true)
				end
            end
        else
            puts "% ERROR Illegal output #{o}"
        end
    }
	
	$starship.each{ |sh|
		if sh.passengers.length > 0
			validSim = false;
		end
	}
	
	$traveler.each { |trv|
		if ((trv.itinerary_idx != trv.itinerary.length - 1) || !trv.in_station)
			validSim = false
		end
	}
	
    return validSim
end

#------------------------------------------------------------------
# simulate - perform multithreaded space simulation

def shipSimulator(ship)
	while true
		destination_port = ship.destination
		destination_port.starMonitor.synchronize {
			destination_port.dockCondition.wait_until {
				destination_port.ships.length < destination_port.size
			}
			destination_port.ships.push(ship)
			ship.set_prev_port(ship.current_port)
			ship.set_curr_port(destination_port)
			ship.set_destination(nil)
			destination_port.departCondition.broadcast()
			
			$printMonitor.synchronize {
				puts "#{ship} docking at #{destination_port}"
				$stdout.flush
			}
		}
		
		sleep (0.001)
		
		destination_port.starMonitor.synchronize {
			destination_port.ships.delete(ship)
			ship.set_prev_port(ship.current_port)
			ship.set_curr_port(nil)
			ship.set_destination(next_port(destination_port))
			destination_port.dockCondition.broadcast()
			
			$printMonitor.synchronize {
				puts "#{ship} departing from #{destination_port}"
				$stdout.flush
			}
		}
	end
end

def travelerSimulator(trav)
	while ((trav.itinerary_idx != trav.itinerary.length - 1))
		destination_port = trav.itinerary[trav.itinerary_idx]
		ship = nil
		
		destination_port.starMonitor.synchronize {
			destination_port.departCondition.wait_until {
				destination_port.ships.length > 0 && !destination_port.shipCap.nil?
			}
			ship = destination_port.shipCap
			ship.passengers.push(trav)
			destination_port.travelers.delete(trav)
			trav.set_itin_idx(trav.itinerary_idx + 1)
			trav.set_in_station(false)
			destination_port.dockCondition.broadcast()
			
			$printMonitor.synchronize {
				puts "#{trav} boarding #{ship} at #{destination_port}"
				$stdout.flush()
			}
		}
		
		destination_port = trav.itinerary[trav.itinerary_idx]
		sleep (0.001)
		
		destination_port.starMonitor.synchronize {
			destination_port.departCondition.wait_until {
				ship.current_port == destination_port
			}
			ship.passengers.delete(trav)
			destination_port.travelers.push(trav)
			trav.set_in_station(true)
			destination_port.dockCondition.broadcast()
			
			$printMonitor.synchronize {
				puts "#{trav} departing #{ship} at #{destination_port}"
				$stdout.flush
			}
		}
	end
end

def simulate()
	$starship.each { |sh|
		sh.set_destination($starport[0])
	}
	
	starship_thread = [] 
	traveler_thread = []
	
	$starship.each { |s|
		starship_thread.push(Thread.new {
			shipSimulator(s)
		})
	}
	
	$traveler.each { |t|
		traveler_thread.push(Thread.new {
			travelerSimulator(t)
		})
	}
	
	traveler_thread.each { |t|
		t.join()
	}
end

#------------------------------------------------------------------
# main - simulation driver

def main
    if ARGV.length != 2
        puts "Usage: ruby space.rb [simulate|verify|display] <simFileName>"
        exit(1)
    end
    
    # list command line parameters
    cmd = "% ruby space.rb "
    ARGV.each { |a| cmd << a << " " }
    puts cmd
    
    readParams(ARGV[1])
  
    if ARGV[0] == "verify"
        result = verify()
        if result
            puts "VALID"
        else
            puts "INVALID"
            exit(1)
        end

    elsif ARGV[0] == "simulate"
        printParams()
        simulate()

    elsif ARGV[0] == "display"
        display()

    else
        puts "Usage: space [simulate|verify|display] <simFileName>"
        exit(1)
    end
    exit(0)
end

main

