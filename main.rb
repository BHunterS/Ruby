require 'json'
require 'faker'

class TestDataGenerator
  def initialize(&block)
    @data = {}
    @obj = nil
    instance_eval(&block) if block_given?
  end

  def object(name, count = 1, &block)
    @data[name] ||= []
    count.times do
      @obj = {}
      instance_eval(&block) if block_given?
      @data[name] << @obj
    end
  end

  def field(name, value = "")
    raise 'No object defined' unless defined?(@obj)
    @obj[name] = value.nil? ? yield : value
  end

  def user
    field(:name) { Faker::Name.name }
    field(:age) { Faker::Number.between(from: 18, to: 80) }
    field(:email) { Faker::Internet.email }
  end

  def product
    field(:name) { Faker::Commerce.product_name }
    field(:price) { Faker::Commerce.price }
    field(:quantity) { Faker::Number.between(from: 1, to: 100) }
  end

  def address
    field(:street) { Faker::Address.street_address }
    field(:city) { Faker::Address.city }
    field(:state) { Faker::Address.state }
    field(:zip_code) { Faker::Address.zip_code }
  end

  def company
    field(:name) { Faker::Company.name }
    field(:industry) { Faker::Company.industry }
    field(:catch_phrase) { Faker::Company.catch_phrase }
  end

  def book
    field(:title) { Faker::Book.title }
    field(:author) { Faker::Book.author }
    field(:genre) { Faker::Book.genre }
  end

  def event
    field(:name) { Faker::Lorem.word }
    field(:date) { Faker::Date.between(from: Date.today, to: Date.today.next_year(1)) }
    field(:location) { Faker::Address.full_address }
  end

  def to_json(file_name)
    written = @data.to_json

    File.open("#{file_name}.json", 'w') do |file|
      file.write(written)
    end

    written
  end
end


generator = TestDataGenerator.new do
  object :users, 3 do
    field :name, Faker::Name.name
    field :age, Faker::Number.between(from: 18, to: 80)
    field :email, Faker::Internet.email
  end

  object :products, 2 do
    field :name, Faker::Commerce.product_name
    field :price, Faker::Commerce.price
    field :quantity, Faker::Number.between(from: 1, to: 100)
  end

  object :users, 3 do
    user
  end

  object :products, 2 do
    product
  end

  object :addresses, 2 do
    address
  end

  object :companies, 2 do
    company
  end

  object :books, 2 do
    book
  end

  object :events do
    event
  end
end

puts generator.to_json('data')
