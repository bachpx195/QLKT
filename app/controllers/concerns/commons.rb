module Commons
  private
    def buildings(current_user)
      @admin_buildings = Admin::Building.where(user: current_user).where(parent_id: nil).order(parent_id: :asc)
      # Build tree
      @result = []
      buildings_tree(@result, @admin_buildings, '')
      return @result
    end

    def buildings_tree(buildings_tree, buildings, level)
      buildings.each do |building|
        if (level != '')
          nextLevel = "--#{level}"
          building.name = "#{nextLevel} #{building.name}"
        end
        buildings_tree.append(building)
        if building.children.count > 0
          buildings_tree(buildings_tree, building.children, nextLevel)
        end
      end
    end
end