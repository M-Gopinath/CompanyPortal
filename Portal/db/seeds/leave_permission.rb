LeaveType.find_or_create_by(name: "SICK LEAVE", short_name: "SL")
LeaveType.find_or_create_by(name: "PERSONAL LEAVE", short_name: "PL")
LeaveType.find_or_create_by(name: "EARNED LEAVE", short_name: "EL")
LeaveType.find_or_create_by(name: "COMOFF LEAVE", short_name: "COML")
LeaveType.find_or_create_by(name: "LOSS OF PAY", short_name: "LOP")

LeavePermissionStatus.find_or_create_by(name: "PENDING")
LeavePermissionStatus.find_or_create_by(name: "APPROVE")
LeavePermissionStatus.find_or_create_by(name: "REJECT")
LeavePermissionStatus.find_or_create_by(name: "CANCEL")