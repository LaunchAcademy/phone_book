require 'sinatra'
require 'csv'

require 'pry'

def load_contacts
  contacts = []

  CSV.foreach('contacts.csv', headers: true, header_converters: :symbol) do |contact|
    contacts << contact.to_hash
  end

  contacts
end

get '/' do
  @contacts = load_contacts

  erb :index
end

# /contacts/eric.kelly@launchacademy.com
get '/contacts/:email' do
  @contacts = load_contacts
  @contact = @contacts.find do |contact|
    contact[:email] == params[:email]
  end

  erb :'contacts/show'
end
