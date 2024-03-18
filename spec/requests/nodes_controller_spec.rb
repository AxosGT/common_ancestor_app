require 'rails_helper'

RSpec.describe 'Nodes API', type: :request do
  describe 'GET /api/v1/common_ancestor' do
    let!(:node1) { create(:a_node, value: 1) }
    let!(:node2) { create(:a_node, value: 2, previous: node1.id) }
    let!(:node3) { create(:a_node, value: 3, previous: node2.id) }

    it 'returns the common ancestor and depth of two nodes' do
      get '/api/v1/common_ancestor', params: { x: node2.value, y: node3.value }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq({ "root_id" => node1.value, "lowest_common_ancestor" => node2.value, "depth" => 2 })
    end

    it 'returns null if either node is not found' do
      get '/api/v1/common_ancestor', params: { x: 1, y: 10 }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq({ "root_id" => nil, "lowest_common_ancestor" => nil, "depth" => nil })
    end
  end

  describe 'POST /api/v1/birds' do
    let!(:node1) { create(:node) }
    let!(:node2) { create(:node, parent: node1) }
    let!(:bird1) { create(:bird, node: node1) }
    let!(:bird2) { create(:bird, node: node2) }

    it 'returns birds belonging to specified nodes or their descendant nodes' do
      post '/api/v1/birds', params: { node_ids: [node1.id] }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq([bird1.id])
    end

    it 'returns empty array if no birds found for specified nodes' do
      post '/api/v1/birds', params: { node_ids: [999] } # Non-existing node
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq([])
    end
  end
end
