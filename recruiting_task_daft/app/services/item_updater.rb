class ItemUpdater
    def initialize(params)
      @params = params
    end
  
    def call
      update_item
    end

    private

    attr_reader :params

    def update_item
        item.update!(params)
        if !params.has_key?(:quantity)
            item.update!(quantity: 1)
        elsif params[:quantity].to_i < 1
            ItemDestroyer.new(item).call
        end
    end

    def item
        @item ||= ItemsQuery.find_by_id(params[:id])
    end
end