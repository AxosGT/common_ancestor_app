module Api
  module V1
    class NodesController < ApplicationController
      def common_ancestor
        x = params[:x].to_i
        y = params[:y].to_i
        list_x = ANode.find_by(value: x)
        list_y = ANode.find_by(value: y)

        unless list_x && list_y
          render json: { root_id: nil, lowest_common_ancestor: nil, depth: nil }
          return
        end

        array_x = to_array(list_x)
        array_y = to_array(list_y)

        lowest_common_ancestor = array_x.find { |element_x| array_y.find { |element_y| element_y == element_x } }
        depth = to_array(ANode.find_by(value: lowest_common_ancestor)).length

        render json: { root_id: array_x.last, lowest_common_ancestor: lowest_common_ancestor, depth: depth }
      end

      def birds
        node_ids = params[:node_ids]
        descendant_node_ids = find_descendant_node_ids(node_ids)
        birds = Bird.where(node_id: descendant_node_ids)
        render json: birds.pluck(:id), status: :ok
      end

      private

      def find_descendant_node_ids(node_ids)
        descendant_node_ids = []
        node_ids.each do |node_id|
          node = Node.find(node_id)
          descendant_node_ids += node.subtree_ids
        end
        descendant_node_ids.uniq
      end

      def to_array(my_list)
        array = []
        while my_list
          array.push(my_list.value)
          my_list = ANode.find_by(value: my_list.previous)
        end
        array
      end
    end
  end
end
