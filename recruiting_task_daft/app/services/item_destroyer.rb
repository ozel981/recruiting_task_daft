class ItemDestroyer
    def initialize(item)
      @item = item
    end
  
    def call
      destroy_item
    end

    private

    def destroy_item
        item.destory!
    end
end
 