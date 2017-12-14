module ReportsHelper
  def pill_class(year, result)
    return (year == result.keys.first) ? 'active show' : 'fade'
  end
end
