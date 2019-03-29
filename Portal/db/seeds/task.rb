
TaskType.find_or_create_by(name: "DEVELOPMENT")
TaskType.find_or_create_by(name: "BUG")
TaskType.find_or_create_by(name: "FEATURE")
TaskType.find_or_create_by(name: "TESTING")

TaskPriority.find_or_create_by(name: "HIGH")
TaskPriority.find_or_create_by(name: "MEDIUM")
TaskPriority.find_or_create_by(name: "LOW")

TaskStatus.find_or_create_by(name: "NEW")
TaskStatus.find_or_create_by(name: "INPROGRESS")
TaskStatus.find_or_create_by(name: "RESOLVED")
TaskStatus.find_or_create_by(name: "CLOSED")