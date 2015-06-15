#Usage 
#in Terminal cd into the dirctory of this file
# > irb
#> require './WordCount.rb'
#> wc = WordCount.new
#> wc.run('path to text file')


# Create a class to do all the 'work'
class WordCount 

	# the constructor - called when an instance is being made
	def initialize()

		#thse are called instance members, and are variables that can be used inside this class
		@a = Hash.new
		@b = Hash.new
		@sol = "Sol is amazing!"		
	end


	# the method that does it all
	def run(filename, top_results=100)

		# lets start with fresh slate
		clear_data

		# opps i left this in, enjoy :)
		puts @sol

		#read the contens of the file in as an array of lines
		f = File.readlines(filename)

		#loop of the lines
		for line in f

			# convert the lines to words, and then loop over them
			for word in line.split
				self.updateWord(word.downcase)
			end
		end

		# print the results out
		printResults(top_results)
		return nil
	end

	# prints out the the reusults, according to the value of top_resuls
	def printResults(top_results)

		# loop over the keys, put them in reverse order, and then select from the frist up to the nth (value of top_results)
		for key in @b.keys.sort.reverse[0..top_results]

			#print out the results
			puts "Words '#{@b[key].join(', ')}' occured #{key} times"
		end

		# Ruby weirdness, don't return anyting. This method prints to screen
		return nil
	end

	# add the new word to both the hashes
	def updateWord(word)

		word = remove_punctuation(word)

		# If we have an entry then increment its count
		if @a.has_key?(word)
			@a[word] += 1
		else 
			@a[word] = 1
		end


		count = @a[word]
		deleteWord(word, count)
		addWord(word, count)
	end

	def remove_punctuation(word)
		if word[-1] == '.' or word[',']
			word = word[0..word.size-2]
		end
		return word
	end


	# the word's count has increased, we must remove the old entry
	def deleteWord(word, count)

		# Check we in the right range, and threre is something to delete
		if count-1 > 0 && @b[count-1]
			@b[count-1].delete word
		end

		# Delete key from the hash map since its empty. 
		# This is to make the results easier to handle
		if @b[count-1] && @b[count-1].size == 0
			@b.delete(count-1)
		end
	end

	# add a word to sorted hash
	def addWord(word, count)
		if !@b[count]
			@b[count] = []
		end
		@b[count] << word
	end

	# to empty everything out, or rather clear out the state of the instance
	def clear_data()
		@a.clear
		@b.clear
	end
end


