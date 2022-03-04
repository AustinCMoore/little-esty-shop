RSpec.describe PublicHolidays do
  it "exists" do
    data = {
        :date => "2022-04-15",
        :name => "Good Friday"
      }
    public_holiday = PublicHolidays.new(data)
    expect(public_holiday).to be_an_instance_of(PublicHolidays)

  end

  it "has a name and a date" do
    data = {
        :date => "2022-04-15",
        :name => "Good Friday"
      }
    public_holiday = PublicHolidays.new(data)
    expect(public_holiday.date).to eq("2022-04-15")
    expect(public_holiday.name).to eq("Good Friday")
  end
end
