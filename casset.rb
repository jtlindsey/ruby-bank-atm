require_relative 'user'

class Casset
  def initialize(amount); end

  def def(withdrawalReport); end

  def self.storedDataFileLocation
    # Get JSON database file location
    pathtofile = File.join(File.dirname(__FILE__), '/data/cassetsData.json')
  end

  def self.storedData
    # Get ALL user data
    pathtofile = Casset.storedDataFileLocation
    # Parse data, 'symbolize_names: true' to convert json string keys to symbols
    JSON.parse(IO.read(pathtofile), symbolize_names: true)
  end

  def self.getStoredDataAndSave(userSession)
    existingData = Casset.storedData
    # Find the data for the current user "userId = userSession[:userId]" in the...
    # existingData object and replace it with the data from this session(userSession)
    userId = userSession[:userId]
    existingData.find { |customer| customer[:userId] == userId }.replace(userSession)

    # Save data as JSON with indentation (pretty_generate)
    File.open(Casset.storedDataFileLocation, 'w') do |f|
      f.write(JSON.pretty_generate(existingData))
    end
    puts 'Session successfully saved.'
  end
end
