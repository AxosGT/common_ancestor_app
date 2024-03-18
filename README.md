# README

Using the example data I successfully tested all cases
GET http://localhost:3000/api/v1/common_ancestor?x=5497637&y=2820230
GET http://localhost:3000/api/v1/common_ancestor?x=5497637&y=130
GET http://localhost:3000/api/v1/common_ancestor?x=5497637&y=4430546
GET http://localhost:3000/api/v1/common_ancestor?x=9&y=4430546
GET http://localhost:3000/api/v1/common_ancestor?x=4430546&y=4430546

#todo
Both end points are being called in application_controller.rb split these out into more then one controllers.

The names of the models are poor. 

The rspec needs its FactoryBot factories setup (:a_node, :node, and :bird)

The rspec nodes_controller_spec.rb could use some polish 

