class PropertiesSearcher
  attr_reader :search_params

  def initialize(search_params)
    @search_params = search_params
  end

  def self.call(*args)
    new(*args).search
  end

  def search
    query = Property

    if search_params.empty?
      return query.all
    end

    if search_params["operation"].present?
      query = query.operation(search_params["operation"])
    end

    if search_params["min_price"].present? || search_params["max_price"].present?
      query = query.between_prices(search_params["min_price"], search_params["max_price"])
    end

    if search_params["locality"].present?
      query = query.locality(search_params["locality"])
    end

    query
  end
end
