Project.find_or_create_by(name: 'project1', client_id: 1)
Project.find_or_create_by(name: 'project2', client_id: 2)
Project.find_or_create_by(name: 'project3', client_id: 3)
Project.find_or_create_by(name: 'project4', client_id: 3)
Project.find_or_create_by(name: 'project5', client_id: 3)
Project.find_or_create_by(name: 'other', client_id: 3)
Project.find_or_create_by(name: 'project6', client_id: 4)
Project.find_or_create_by(name: 'project7', client_id: 5)
Project.find_or_create_by(name: 'project8', client_id: 6)
Project.find_or_create_by(name: 'project9', client_id: 7)
Project.find_or_create_by(name: 'project10', client_id: 8)
Project.find_or_create_by(name: 'project11', client_id: 9)


puts "Projects Created Successfully...!"
