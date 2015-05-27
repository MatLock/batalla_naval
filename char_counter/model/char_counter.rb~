class CharCounter

    def self.count(string)
		hash = Hash.new
        if string == nil
            return hash
        end
		string.each_char{|c| if c != ' '
                                hash[c] = string.count(c)
                             end                       
                        }
        return hash
	end

end
