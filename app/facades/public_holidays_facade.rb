class PublicHolidaysFacade
  def self.find_holidays
    json = PublicHolidaysService.search_holidays
    holidays = json.map do | data |
      PublicHolidays.new(data)
    end
    holidays.first(3)
  end
end
