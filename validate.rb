module Validate
  def validate_input(array, numb, row, column)
    return false if(validate_row(array, numb, row))
    return false if(validate_column(array, numb, column))
    return false if(validate_grid(array, numb, row, column))
    return true
  end
  def validate_row(array, numb, row)
    array[row].include? numb
  end
  def validate_column(array, numb, column)
    array.each do |row1|
      return true if(row1[column] == numb)
    end
    return false
  end
  def validate_grid(array, numb, row, column)
    x = row - (row % 3)
    y = column - (column % 3)
    if(array[x][y, 3].include? numb or array[x + 1][y, 3].include? numb or array[x + 2][y, 3].include? numb)
      return true
    else
      return false
    end
  end
end
