require './validate.rb'
class Sudoku
  include Validate
  def initialize(array, hash)
    @array = array
    @hash = hash
  end

  def generate_sudoku
    count = rand(15..30)
    while(count > 0) do
      numb = rand(1..9)
      row = rand(0..8)
      column = rand(0..8)
      if(validate_input(@array, numb, row, column))
        @array[row][column] = numb
        @hash["#{row}#{column}"] = numb
        count -= 1
      end
    end
    display(@array, @hash)
  end

  def display(array, hash)
    array.each_with_index do |row, index1|
      puts "_" * 25 if(index1 % 3 == 0)
      row.each_with_index do |column, index2|
        print "| " if(index2 % 3 == 0)
        if(column == 0)
          print "  "
        else
          if(hash["#{index1}#{index2}"])
            print "\e[31m#{column}\e[0m", " "
          else
            print column, " "
          end
        end
      end
      print "|\n"
    end
    print "_" * 25
  end

  def user_input
    loop do
      print "\n\n"
      numb = valid_user_input("INPUT NUMBER")
      return "q" if(numb == "q")
      row = valid_user_input("ROW NUMBER")
      return "q" if(row == "q")
      column = valid_user_input("COLUMN NUMBER")
      return "q" if(column == "q")
      row -= 1
      column -= 1
      if(validate_input(@array, numb, row, column) or numb == 0)
        if(@hash["#{row}#{column}"])
          print "You are not allowed to change it!!!!!\n\n"
        else
          @array[row][column] = numb
        end
      else
        print "Not valid, please enter other no...\n\n"
      end
      display(@array, @hash)
      break if(!@array.flatten.include? 0)
    end
  end

  def valid_user_input(text)
    print "Enter #{text} : \n"
    numb = gets.chomp
    return 0 if(numb == "0" and text == "INPUT NUMBER")
    return "q" if(numb == "Q" or numb == "q")
    numb = numb.to_i
    return numb if(numb.between?(1,9))
    print "You have entered incorrectly, please try again....\n\n"
    ret = valid_user_input(text)
    return ret
  end
end

array = Array.new(9) {Array.new(9, 0)}
hash = Hash.new
print "\nYour Sudoku Game is ready...\n\n"
sudoku = Sudoku.new(array, hash)
sudoku.generate_sudoku
print "\n\nYour inputs should follow these rules :"
print "\nINPUT NUMBER RANGE : 0 - 9\nROW NUMBER RANGE :  1 - 9\nCOLUMN NUMBER RANGE : 1 - 9\n"
print "\nEnter Q or q to exit at any time"
print "\nALL THE BEST!!!"
ret = sudoku.user_input
if(ret == "q")
  print "Better Luck next time...\n\n"
else
  print "\n\n Congratulations!!! You have successfully completed the game....\n\n"
end
