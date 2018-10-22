json.extract! winery, :id, :name, :year, :created_at, :updated_at
json.wines winery.wines.count
json.active do
    if winery.active == true
        json.name "Active"
    else
        json.name "Inactive"
    end
end
json.url winery_url(winery, format: :json)
