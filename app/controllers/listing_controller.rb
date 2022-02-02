class ListingController < ApplicationController
  def index
    @data = Site.all.map do |site|
      {
        id: site.id,
        name: site.title,
        data: site.deals.where("DATE(created_at) >= ? AND DATE(created_at) <= ?", Date.new(2020, 11, 1), Date.new(2021, 11, 30))
                  .select("avg(revenue) as avg, count(deals.id) as listing_count,EXTRACT('month' FROM deals.created_at) as month, EXTRACT('year' FROM deals.created_at) as year")
                  .group("month,year").to_json
      }
    end
    @graph_data = @data.map { |site|
      data = JSON.parse(site[:data])
      graph_data = []
      data.each do |s|
        graph_data.push([Date.new(s["year"].to_i, s["month"].to_i).strftime, s["listing_count"]])
      end
      {
        name: site[:name],
        data: graph_data
      }
    }

  end
end
