class UserDetails {
  final String aadharNumber;
  final String name;
  final int dobMillis;
  final String gender;
  final String contactNumber;
  final List<Appointment> appointments; 

  UserDetails({
    required this.aadharNumber,
    required this.name,
    required this.dobMillis,
    required this.gender,
    required this.contactNumber,
    required this.appointments
  });

  Map<String, dynamic> toMap() {
    return {
      'aadharNumber': aadharNumber,
      'name': name,
      'dobMillis': dobMillis,
      'gender': gender,
      'contactNumber': contactNumber,
      'appointments': appointments.map((appointment) => appointment.toMap()).toList(),
    };
  }
}

class Appointment {
  final int appointmentId;
  final bool completed;

  Appointment({
    required this.appointmentId,
    required this.completed
  });

  Map<String, dynamic> toMap() {
    return {
      'appointmentId': appointmentId,
      'completed': completed,
    };
  }
}
