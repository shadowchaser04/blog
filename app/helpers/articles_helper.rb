module ArticlesHelper


  # lists as published or a draft instead of the binary 0 or 1
  def published_convert(arg)
      case arg
      when true
       return "published"
      when false
       return "draft"
      end
  end


end
