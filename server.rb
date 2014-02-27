require 'CSV'
require 'pry'
require 'sinatra'







def csv_load
  hash = {}
  CSV.foreach('lackp_starting_rosters.csv', headers:true) do |row|

    # Extract Team Name from first column
      team_name = row.delete("team")[1]
      new_player = row.to_hash
    if hash.keys.include?(team_name)
      hash[team_name] << new_player
    else
      hash[team_name] = [new_player]
    end
  end
  hash
end

def get_team_name(hash)
  hash.keys
end

teams = csv_load




teams.each do |team|
        binding.pryteam

safe_url = URI::encode(team.first)

  get "/#{safe_url}" do
    @team = team.last
   @team.each do |player|

     end
    # erb :team_page
  end

end

get '/' do
  @teams = teams
  # binding.pry
  erb :index

end


set :views, File.dirname(__FILE__) + '/views'






