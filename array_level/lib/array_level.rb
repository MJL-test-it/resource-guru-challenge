# Monkey patch of Array class to include custom `flatten` method, `level`
# do not overwrite flatten to maintain expected performance of Array

class Array
  def level
    self.each_with_object([]) do |elem, ary|
      case elem
      when Array then ary.push(*elem.level)
      else ary << elem
      end
    end
  end

  def level!

  end
end
