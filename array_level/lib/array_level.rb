class Array
  def level
    self.each_with_object([]) do |elem, ary|
      case elem
      when Array then ary.push(*elem)
      else ary << elem
      end
    end
  end
end
