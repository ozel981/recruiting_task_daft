class DiscountUpdater
    def initialize(params)
      @params = params
    end
  
    def call
      update_discount
    end

    private

    attr_reader :params

    def update_discount
        discount.update!(params)
    end
    
    def discount
        @discount ||= DiscountsQuery.find_by_id(params[:id])
    end
end