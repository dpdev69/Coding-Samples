#!/usr/bin/ruby -w

class FiniteAutomaton
    @@nextID = 0	# shared across all states
    attr_reader:state, :start, :final, :alphabet, :transition

    #---------------------------------------------------------------
    # Constructor for the FA
    def initialize
        @start = nil 		# start state 
        @state = { } 		# all states
        @final = { } 		# final states
        @transition = { }	# transitions
        @alphabet = [ ] 	# symbols on transitions
    end

    #---------------------------------------------------------------
    # Return number of states
    def num_states
        @state.size
    end

    #---------------------------------------------------------------
    # Creates a new state 
    def new_state
        newID = @@nextID
        @@nextID += 1
        @state[newID] = true
        @transition[newID] = {}
        newID 
    end

    #---------------------------------------------------------------
    # Creates a new state
    def add_state(v)
        unless has_state?(v)
            @state[v] = true
            @transition[v] = {}
        end
    end

    #---------------------------------------------------------------
    # Returns true if the state exists
    def has_state?(v)
        @state[v]
    end

    #---------------------------------------------------------------
    # Set (or reset) the start state
    def set_start(v)
        add_state(v)
        @start = v
    end

    #---------------------------------------------------------------
    # Set (or reset) a final state
    def set_final(v, final = true)
        add_state(v)
        if final
            @final[v] = true
        else
            @final.delete(v)
        end
    end

    #---------------------------------------------------------------
    # Returns true if the state is final
    def is_final?(v)
        @final[v]
    end

    #---------------------------------------------------------------
    # Creates a new transition from v1 to v2 with symbol x
    # Any previous transition from v1 with symbol x is removed
    def add_transition(v1, v2, x)
        add_state(v1)
        add_state(v2)
        if @transition[v1][x]
          @transition[v1][x].push(v2)
        else
          @transition[v1][x] = [v2]
        end
    end

    #---------------------------------------------------------------
    # Get the destination state from v1 with symbol x
    # Returns nil if non-existent
    def get_transition(v1,x)
        if has_state?(v1)
            @transition[v1][x]
        else
            nil
        end
    end

    #---------------------------------------------------------------
    # Get the destination state from v1 with symbol x
    # Returns nil if non-existent
    def has_transition(v1,x,v2)
        if has_state?(v1)
          if (@transition[v1][x].to_s == v2.to_s)
            return true
          end
        end
        return false
    end

    #---------------------------------------------------------------
    def get_start_state(v1,x,v2)
      states = []
      v1.each{ |start|
        if @transition[start][x]
          @transition[start][x].each{ |trans|
            if trans == v2
              states.push(start)
            end
          }
        end
      }
      return states.sort
    end

    #---------------------------------------------------------------
    # Returns true if the dfa accepts the given string
    def accept?(s, current = @start)
        if s == ""
            is_final?(current)
        else
            dest = get_transition(current,s[0,1])
            if dest == nil
               false
            else
               if dest.length > 1
                 false
               else
                 accept?(s[1..-1], dest[0])
               end
            end
        end
    end

    #---------------------------------------------------------------
    # Returns all states reachable from ss using only epsilon 
    # transitions
    def epsilonClosure(ss)
      states = []
      s_queue = []

      if ss != nil
        ss.each{ |x|
          s_queue << x
        }
        while !s_queue.empty?
          s_curr = s_queue[0]
          if !states.include?(s_curr)
            states.push(s_curr)
            trans = get_transition(s_curr, "")
            if trans
              trans.each{ |x|
                s_queue.push(x)
              }
            end
          end
          s_queue.shift
        end
        return states
      end
      return
    end

    #---------------------------------------------------------------
    # Prints FA 
    def pretty_print
        print "% Start "
	puts @start

        # Final states in sorted order
	print "% Final {"
	@final.keys.sort.each { |x| print " #{x}" }
	puts " }" 

        # States in sorted order
	print "% States {"
	@state.keys.sort.each { |x| print " #{x}" }
	puts " }" 

        # Alphabet in alphabetical order
        print "% Alphabet {"
	@alphabet.sort.each { |x| print " #{x}" }
	puts " }" 

        # Transitions in lexicographic order
        puts "% Transitions {"
	@transition.keys.sort.each { |v1| 
            @transition[v1].keys.sort.each { |x| 
                v2 = get_transition(v1,x)
                v2.each{ |y|
                    puts "%  (#{v1} #{x} #{v2})"
                } 
            }
        }
	puts "% }" 
    end
        
    #---------------------------------------------------------------
    # Prints FA statistics
    def print_stats
      transitions = 0;
      hasher = Hash.new

      @transition.keys.each{ |key|
        if hasher[key] == nil
          hasher[key] = 0
        end

        @transition[key].keys.each{ |value|
          if get_transition(key, value) != nil then
            v2 = get_transition(key, value).size
            transitions += get_transition(key, value).size
            hasher[key] += v2
          end
        }
      }

      hasher2 = Hash.new
      hasher.keys.each{ |state|
        if hasher2[hasher[state]] == nil then
          hasher2[hasher[state]] = 1
        else
          hasher2[hasher[state]] += 1
        end
      }

      puts "FiniteAutomaton"
      puts "#{@state.size} states"
      puts "#{@final.size} final states"
      puts "#{transitions} transitions"
      
      hasher2.keys.sort!.each{ |key|
        puts "#{hasher2[key]} states with #{key} transitions"
      }
    end

    #---------------------------------------------------------------
    # accepts just symbol ("" = epsilon)
    def symbol! sym
        initialize
        state0 = new_state
        state1 = new_state
        set_start(state0)
        set_final(state1, true)
        add_transition(state0, state1, sym)

        if (sym != "") && (!@alphabet.include? sym)
            @alphabet.push sym
        end
    end

    #---------------------------------------------------------------
    # accept strings accepted by self, followed by strings accepted by newFA
    def concat! newFA
      @final.keys.each{ |fin|
        add_transition(fin, newFA.start, "")
      }

      @final.clear
      @final.update(newFA.final)
      @state.update(newFA.state)
      @transition.update(newFA.transition)

      newFA.alphabet.each{ |letter|
        if @alphabet.include?(letter) == false
          @alphabet.push(letter)
        end
      }
    end

    #---------------------------------------------------------------
    # accept strings accepted by either self or newFA
    def union! newFA
      state0 = new_state
      state1 = new_state
      add_state(state0)
      add_state(state1)
      add_transition(state0, @start, "")
      add_transition(state0, newFA.start, "")
      set_start(state0)
      @state.update(newFA.state)
      @transition.update(newFA.transition)
      @final.update(newFA.final)

      @final.keys.each{ |fin|
        add_transition(fin, state1, "")
      }

      @final.clear
      set_final(state1, true)

      newFA.alphabet.each { |letter|
        if @alphabet.include?(letter) == false
          @alphabet.push(letter)
        end
      }
    end

    #---------------------------------------------------------------
    # accept any sequence of 0 or more strings accepted by self
    def closure!
      state0 = new_state
      state1 = new_state
      add_state(state0)
      add_state(state1)
      add_transition(state0, @start, "")
      add_transition(state0, state1, "")
      add_transition(state1, state0, "")
      set_start(state0)

      @final.keys.each{ |fin|
        add_transition(fin, state1, "")
      }

      @final.clear
      set_final(state1, true)
    end

    #---------------------------------------------------------------
    # returns DFA that accepts only strings accepted by self 
    def to_dfa
        # create a new one, or modify the current one in place,
        # and return it
      newDFA = FiniteAutomaton.new
      newDFA.alphabet.concat(@alphabet)
      rcap = {}
      state_change = {}

      r0 = epsilonClosure([@start])
      rcap[r0] = "unmarked"
      state0 = new_state
      state_change[r0] = state0
      newDFA.add_state(state0)
      newDFA.set_start(state0)
      if !(r0 & @final.keys).empty?
        newDFA.set_final(state0, true)
      end
      while rcap.has_value?("unmarked")
        r = rcap.index("unmarked")
        rcap[r] = "marked"
        @alphabet.each{ |letter|
          scap = []
          r.each{ |state|
            ts = get_transition(state, letter)
            if ts
              scap.concat(ts)
            end
          }
          if !scap.empty?
            epsilon = epsilonClosure(scap)
            if rcap[epsilon] == nil
              rcap[epsilon] = "unmarked"
              state1 = new_state
              state_change[epsilon] = state1
              newDFA.add_state(state1)
            end
            if state_change[r] == nil
              newDFA.add_transition(r, state_change[epsilon], letter)
            else
              newDFA.add_transition(state_change[r], state_change[epsilon], letter)
            end
          end
        }
      end
      rcap.keys.each{ |state|
        if !(state & @final.keys).empty?
          newDFA.set_final(state_change[state], true)
        end
      }
      return newDFA
    end

    #---------------------------------------------------------------
    # returns a DFA that accepts only strings not accepted by self, 
    # and rejects all strings previously accepted by self
    def complement!
        # create a new one, or modify the current one in place,
        # and return it
      newDFA = FiniteAutomaton.new
      newDFA.alphabet.concat(@alphabet)
      newDFA.set_start(@start)
      newDFA.state.update(@state)
      newDFA.transition.update(@transition)
      deadState = nil

      @state.keys.each{ |state|
        @alphabet.each{ |a|
          if get_transition(state, a) == nil then
            if deadState == nil then
              deadState = new_state
              newDFA.add_state(deadState)
              newDFA.set_final(deadState, true)
              newDFA.add_transition(state, deadState, a)
            else
              newDFA.add_transition(state, deadState, a)
            end
          end
        }
        
        if is_final?(state) == true
          set_final(state, false)
        else
          set_final(state, true)
        end
      }

      @alphabet.each{ |a|
        if deadState != nil
          if get_transition(deadState, a) == nil then
            newDFA.add_transition(deadState, deadState, a)
          end
        end
      }

      newDFA.final.update(@final)
      return newDFA
    end

    #---------------------------------------------------------------
    # return all strings accepted by FA with length <= strLen
    def gen_str strLen
	sortedAlphabet = @alphabet.sort
        resultStrs = [ ] 
        testStrings = [ ]
        testStrings[0] = [] 
        testStrings[0].push ""
        1.upto(strLen.to_i) { |x|
            testStrings[x] = []
            testStrings[x-1].each { |s|
                sortedAlphabet.each { |c|
                    testStrings[x].push s+c
                }
            }
        }
        testStrings.flatten.each { |s|
            resultStrs.push s if accept? s
        }
        result = ""
        resultStrs.each { |x| result.concat '"'+x+'" ' }
        result
    end

end

#---------------------------------------------------------------
# read standard input and interpret as a stack machine

def interpreter file
   dfaStack = [ ] 
   loop do
       line = file.gets
       if line == nil then break end
       words = line.scan(/\S+/)
       words.each{ |word|
           case word
               when /DONE/
                   return
               when /SIZE/
                   f = dfaStack.last
                   puts f.num_states
               when /PRINT/
                   f = dfaStack.last
                   f.pretty_print
               when /STAT/
                   f = dfaStack.last
                   f.print_stats
               when /DFA/
                   f = dfaStack.pop
                   f2 = f.to_dfa
                   dfaStack.push f2
               when /COMPLEMENT/
                   f = dfaStack.pop
                   f2 = f.complement!
                   dfaStack.push f2
               when /GENSTR([0-9]+)/
                   f = dfaStack.last
                   puts f.gen_str($1)
               when /"([a-z]*)"/
                   f = dfaStack.last
                   str = $1
                   if f.accept?(str)
                       puts "Accept #{str}"
                   else
                       puts "Reject #{str}"
                   end
               when /([a-zE])/
                   puts "Illegal syntax for: #{word}" if word.length != 1
                   f = FiniteAutomaton.new
                   sym = $1
                   sym="" if $1=="E"
                   f.symbol!(sym)
                   dfaStack.push f
               when /\*/
                   puts "Illegal syntax for: #{word}" if word.length != 1
                   f = dfaStack.pop
                   f.closure!
                   dfaStack.push f
               when /\|/
                   puts "Illegal syntax for: #{word}" if word.length != 1
                   f1 = dfaStack.pop
                   f2 = dfaStack.pop
                   f2.union!(f1)
                   dfaStack.push f2
               when /\./
                   puts "Illegal syntax for: #{word}" if word.length != 1
                   f1 = dfaStack.pop
                   f2 = dfaStack.pop
                   f2.concat!(f1)
                   dfaStack.push f2
               else
                   puts "Ignoring #{word}"
           end
        }
   end
end

#---------------------------------------------------------------
# main( )

if false			# just debugging messages
    f = FiniteAutomaton.new
    f.set_start(1)
    f.set_final(2)
    f.set_final(3)
    f.add_transition(1,2,"a")   # need to keep this for NFA
    f.add_transition(1,3,"a")  
    f.prettyPrint
end

if ARGV.length > 0 then
  file = open(ARGV[0])
else
  file = STDIN
end

interpreter file  # type "DONE" to exit

