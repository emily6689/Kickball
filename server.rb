require 'csv'
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

teams = csv_load
teams.each do |team|

  safe_url = URI::encode(team.first)
  get "/#{safe_url}" do
    @team_name = team.first
    @team_players = team.last
    erb :team_page
  end

end

get '/' do
  @teams = teams
  # binding.pry
  erb :index

end

get '/:position' do
  @players = []

  teams.each do |key, value|



    value.each do |player|
      # binding.pry
      player["team_name"] = key
      @players << player if  player["position"] == params[:position]

    end
   end

 erb :position_page

end

set :views, File.dirname(__FILE__) + '/views'






